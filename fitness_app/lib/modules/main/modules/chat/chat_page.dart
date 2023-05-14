import 'dart:async';

import 'package:dart_openai/openai.dart';
import 'package:ferry/ferry.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_inboxes.req.gql.dart';
import 'package:fitness_app/global/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../global/graphql/client.dart';
import '../../../../global/graphql/mutation/__generated__/mutation_upsert_inbox.req.gql.dart';
import '../../../../global/graphql/query/__generated__/query_get_my_inboxes.data.gql.dart';
import '../../../../global/providers/me_provider.dart';
import '../../../../global/themes/app_colors.dart';
import '../../../../global/utils/dialogs.dart';
import '../../../../global/widgets/fitness_empty.dart';
import '../../../../global/widgets/fitness_error.dart';
import '../../../../global/widgets/infinity_list.dart';
import 'widgets/message_widget.dart';
import 'widgets/shimmer_inbox.dart';

final messageResponseProvider = StateProvider<List<String>>((ref) => []);

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
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

  void refreshHandler() {
    setState(
      () => getMyInboxesReq = getMyInboxesReq.rebuild(
        (b) => b
          ..vars.queryParams.page = 1
          ..updateResult = ((previous, result) => result),
      ),
    );
  }

  void chat() async {
    final message = textController.text.trim();
    if (message.isNotEmpty) {
      ref.read(messageResponseProvider.notifier).update((state) => []);
      await upsertChat(
        message: message,
        isSender: true,
      );
      textController.clear();
      onCallOpenAI(message);
    }
  }

  Future onCallOpenAI(String message) async {
    late StreamSubscription<OpenAIStreamChatCompletionModel> subscription;
    final stream = OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: message,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    setState(() => loading = true);

    subscription = stream.listen(
      (event) {
        ref.watch(messageResponseProvider.notifier).update(
              (state) => [
                ...state,
                event.choices.first.delta.content ?? '',
              ],
            );
      },
      onDone: () async {
        if (ref.read(messageResponseProvider).isEmpty) {
          Future.delayed(const Duration(seconds: 1), () {
            subscription.cancel();
            setState(() => loading = false);
            return;
          });
        } else {
          await upsertChat(
            message: ref.read(messageResponseProvider).join(''),
            isSender: false,
          );
          refreshHandler();
          setState(() {
            loading = false;
          });
        }
      },
      onError: (err) {
        setState(() => loading = false);
        return;
      },
      cancelOnError: true,
    );
  }

  Future upsertChat({
    required String message,
    required bool isSender,
  }) async {
    final client = ref.read(appClientProvider);
    final user = ref.read(meProvider);

    setState(() => loading = true);

    var req = GUpsertInboxReq(
      (b) => b
        ..fetchPolicy = FetchPolicy.CacheAndNetwork
        ..vars.input.isSender = isSender
        ..vars.input.message = message
        ..vars.input.userId = user?.id,
    );
    final response = await client.request(req).first;

    if (response.hasErrors) {
      if (mounted) {
        DialogUtils.showError(context: context, response: response);
      }
    } else {
      refreshHandler();
      setState(() => loading = false);
    }
  }

  // void _scrollDown() {
  //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
  // }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final client = ref.watch(appClientProvider);
    final isLogedIn = ref.watch(isSignedInProvider);

    return Scaffold(
      backgroundColor: AppColors.grey6.withOpacity(0.1),
      appBar: AppBar(
        title: Text(i18n.chat_Title),
        elevation: 0,
      ),
      body: isLogedIn
          ? InfinityList(
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
                    (b) =>
                        b..vars.queryParams.page = b.vars.queryParams.page! - 1,
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
                    onPressed: refreshHandler,
                  );
                }

                return ListView.separated(
                  itemCount: inboxes!.length + 1,
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      if (loading) {
                        return Consumer(
                          builder: (context, ref, child) {
                            return MessageWidget(
                              item: GGetMyInboxesData_getMyInboxes_items(
                                (b) => b
                                  ..userId =
                                      '4b216e9d-9af8-4e13-bde7-df1b8cef02b5'
                                  ..isSender = false
                                  ..message = ref
                                      .watch(messageResponseProvider)
                                      .join(''),
                              ),
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    }

                    final item = inboxes[index - 1];

                    return MessageWidget(
                      item: item,
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  controller: scrollController,
                );
              },
            )
          : const UnLoginInbox(),
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
              onTap: () {
                if (!loading && isLogedIn) {
                  chat();
                } else {
                  AuthHelper.showLoginDialog(context);
                }
              },
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
