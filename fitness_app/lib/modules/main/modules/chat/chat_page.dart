import 'package:dart_openai/openai.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/utils/client_mixin.dart';
import 'package:fitness_app/modules/main/modules/chat/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../global/graphql/mutation/__generated__/mutation_upsert_inbox.req.gql.dart';
import '../../../../global/providers/auth_provider.dart';
import '../../../../global/utils/dialogs.dart';

final messageResponseProvider = StateProvider<List<String>>((ref) => []);

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> with ClientMixin {
  String messagReplied = '';
  final textController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 16),
          MessageWidget(
            isSender: false,
            content: ref.watch(messageResponseProvider).join(''),
            contentLoading: loading
                ? const SizedBox(
                    height: 20,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulse,
                      colors: [Colors.black],
                      strokeWidth: 2,
                    ),
                  )
                : null,
          ),
          MessageWidget(
            isSender: true,
            content: textController.text,
          ),
        ],
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
