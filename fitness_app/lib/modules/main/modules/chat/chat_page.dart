import 'package:dart_openai/openai.dart';
import 'package:ferry/ferry.dart';
import 'package:fitness_app/global/gen/assets.gen.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_inboxes.req.gql.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/utils/client_mixin.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:fitness_app/global/widgets/shimmer_wrapper.dart';
import 'package:fitness_app/modules/main/modules/chat/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../global/graphql/mutation/__generated__/mutation_upsert_inbox.req.gql.dart';
import '../../../../global/providers/auth_provider.dart';
import '../../../../global/utils/constants.dart';
import '../../../../global/utils/dialogs.dart';
import '../../../../global/widgets/fitness_empty.dart';
import '../../../../global/widgets/fitness_error.dart';

final messageResponseProvider = StateProvider<List<String>>((ref) => []);

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> with ClientMixin {
  final textController = TextEditingController();
  bool loading = false;
  late var getMyInboxesReq = GGetMyInboxesReq(
    (b) => b
      ..requestId = '@getMyInboxesRequestId'
      ..fetchPolicy = FetchPolicy.CacheAndNetwork
      ..vars.queryParams.page = 1
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.orderBy = 'Remote.createdAt:DESC',
  );

  @override
  void initState() {
    super.initState();
  }

  void refreshHandler() {
    setState(
      () => getMyInboxesReq = getMyInboxesReq.rebuild(
        (b) => b
          ..vars.queryParams.page = 1
          ..updateResult = ((previous, result) => result),
      ),
    );
  }

  void chat(String message) async {
    ref.read(messageResponseProvider.notifier).update((state) => []);
    setState(() => loading = true);
    textController.text = '';
    final stream = OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: message,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );

    stream.listen((event) {
      setState(() {
        loading = false;
      });
      ref.watch(messageResponseProvider.notifier).update(
            (state) => [
              ...state,
              event.choices.first.delta.content ?? '',
            ],
          );
    }).onDone(
      () async {
        final user = context.read<AuthProvider>().user;
        var req = GUpsertInboxReq(
          (b) => b
            ..vars.input.isSender = false
            ..vars.input.message = ref.read(messageResponseProvider).join('')
            ..vars.input.userId =
                user?.id ?? '4b216e9d-9af8-4e13-bde7-df1b8cef02b5',
        );
        final response = await client.request(req).first;
        if (response.hasErrors) {
          print(response.linkException);
          if (mounted) {
            DialogUtils.showError(context: context, response: response);
          }
        }
      },
    );
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.grey6.withOpacity(0.1),
      appBar: AppBar(
        title: Text(i18n.chat_Title),
        elevation: 0,
      ),
      body: InfinityList(
        client: client,
        request: GGetMyInboxesReq(),
        loadMoreRequest: (response) {
          final data = response?.data?.getMyInboxes;
          if (data != null &&
              data.meta!.currentPage!.toDouble() <
                  data.meta!.totalPages!.toDouble()) {
            getMyInboxesReq = getMyInboxesReq.rebuild(
              (b) => b
                ..vars.queryParams.page = (b.vars.queryParams.page! + 1)
                ..updateResult = (previous, result) =>
                    previous?.rebuild(
                      (b) => b.getMyInboxes
                        ..meta = (result?.getMyInboxes.meta ??
                                previous.getMyInboxes.meta)!
                            .toBuilder()
                        ..items.addAll(result?.getMyInboxes.items ?? []),
                    ) ??
                    result,
            );
            return getMyInboxesReq;
          }
          return null;
        },
        refreshRequest: () {
          getMyInboxesReq = getMyInboxesReq.rebuild(
            (b) => b
              ..vars.queryParams.page = 1
              ..updateResult = ((previous, result) => result),
          );
          return getMyInboxesReq;
        },
        builder: (context, response, error) {
          if ((response?.hasErrors == true ||
                  response?.data?.getMyInboxes.meta?.itemCount == 0) &&
              getMyInboxesReq.vars.queryParams.page != 1) {
            getMyInboxesReq = getMyInboxesReq.rebuild(
              (b) => b..vars.queryParams.page = b.vars.queryParams.page! - 1,
            );
          }

          if (response?.loading ?? false) {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   setState(() {
            //     loading = true;
            //   });
            // });
            return const ShimmerInbox();
          }

          if (response?.hasErrors == true || response?.data == null) {
            return FitnessError(response: response);
          }

          print(response?.data?.getMyInboxes);

          final data = response!.data!.getMyInboxes;
          final hasMoreData = data.meta!.currentPage!.toDouble() <
              data.meta!.totalPages!.toDouble();
          final inboxes = data.items;

          if (inboxes?.isEmpty == true) {
            return FitnessEmpty(
              title: 'Empty',
              message: 'Inbox is empty',
              textButton: 'Refresh',
              image: Assets.images.sadFace.image(height: 100),
              onPressed: refreshHandler,
            );
          }

          return ListView.separated(
            itemCount: inboxes!.length + (hasMoreData ? 1 : 0),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemBuilder: (_, index) {
              final item = inboxes[index];

              if (index == inboxes.length) {
                return Container(
                  height: 64,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }
              return MessageWidget(
                item: item,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        color: AppColors.white,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.grey5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 16,
                  ),
                ),
                maxLines: 5,
                minLines: 1,
              ),
            ),
            const SizedBox(width: 12),
            TouchableOpacity(
              onTap: () => chat(textController.text),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: AppColors.grey1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerInbox extends StatelessWidget {
  const ShimmerInbox({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral20,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
