import 'package:dart_openai/openai.dart';
import 'package:ferry/ferry.dart';
import 'package:fitness_app/global/gen/assets.gen.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_inboxes.data.gql.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_inboxes.req.gql.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/utils/client_mixin.dart';
import 'package:fitness_app/global/widgets/infinity_list.dart';
import 'package:fitness_app/modules/main/modules/chat/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../global/graphql/mutation/__generated__/mutation_upsert_inbox.req.gql.dart';
import '../../../../global/providers/auth_provider.dart';
import '../../../../global/utils/dialogs.dart';
import '../../../../global/widgets/fitness_empty.dart';
import '../../../../global/widgets/fitness_error.dart';
import 'widgets/shimmer_inbox.dart';

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
      ..vars.queryParams.page = 1
      ..vars.queryParams.limit = 22
      ..vars.queryParams.orderBy = 'Inbox.createdAt:DESC',
  );
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void refreshHandler() {
    setState(
      () => getMyInboxesReq = getMyInboxesReq.rebuild((b) => b
          // (b) => b
          //   ..vars.queryParams.page = 1
          //   ..updateResult = ((previous, result) => result),
          ),
    );
  }

  void chat(String message) async {
    if (message.isNotEmpty) {
      ref.read(messageResponseProvider.notifier).update((state) => []);
      setState(() => loading = true);
      await upsertChat(
        message: textController.text.trim(),
        isSender: true,
      );
      onCallOpenAI(message);
    }
  }

  void onCallOpenAI(String message) {
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
      ref.watch(messageResponseProvider.notifier).update(
            (state) => [
              ...state,
              event.choices.first.delta.content ?? '',
            ],
          );
    }).onDone(() async {
      await upsertChat(
        message: ref.read(messageResponseProvider).join(''),
        isSender: false,
      );
      setState(() {
        loading = false;
        getMyInboxesReq = getMyInboxesReq.rebuild(
          (b) => b..vars.queryParams.page = 1,
        );
      });
    });
  }

  Future upsertChat({
    required String message,
    required bool isSender,
  }) async {
    final user = context.read<AuthProvider>().user;
    var req = GUpsertInboxReq((b) => b
          ..fetchPolicy = FetchPolicy.CacheAndNetwork
          ..vars.input.isSender = isSender
          ..vars.input.message = message
          ..vars.input.userId =
              user?.id ?? '4b216e9d-9af8-4e13-bde7-df1b8cef02b5'
        // ..updateCacheHandlerKey = UpsertInboxHandler.key
        // ..updateCacheHandlerContext = {
        //   "inboxData": GGetMyInboxesData_getMyInboxes_items(
        //     (b) => b
        //       ..isSender = isSen der
        //       ..message = message
        //       ..userId = '4b216e9d-9af8-4e13-bde7-df1b8cef02b5',
        //   ),
        // },
        );
    final response = await client.request(req).first;
    if (response.hasErrors) {
      if (mounted) {
        DialogUtils.showError(context: context, response: response);
      }
    }

    // refreshHandler();
  }

  void _scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
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
        request: getMyInboxesReq,
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
                        ..items.addAll(
                          result?.getMyInboxes.items ?? [],
                        ),
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

          if (response?.loading == true) {
            return const ShimmerInbox();
          }

          if (response?.hasErrors == true || response?.data == null) {
            return FitnessError(response: response);
          }

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
            itemCount: inboxes!.length + 2,
            reverse: true,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemBuilder: (_, index) {
              if (index == 1) {
                if (loading) {
                  return MessageWidget(
                    item: GGetMyInboxesData_getMyInboxes_items(
                      (b) => b
                        ..userId = '4b216e9d-9af8-4e13-bde7-df1b8cef02b5'
                        ..isSender = true
                        ..message = textController.text,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }
              if (index == 0) {
                if (loading) {
                  return MessageWidget(
                    item: GGetMyInboxesData_getMyInboxes_items(
                      (b) => b
                        ..userId = '4b216e9d-9af8-4e13-bde7-df1b8cef02b5'
                        ..isSender = false
                        ..message = ref.watch(messageResponseProvider).join(''),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }

              final item = inboxes[index - 2];

              return MessageWidget(
                item: item,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            controller: scrollController,
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
              onTap: !loading ? () => chat(textController.text) : null,
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
