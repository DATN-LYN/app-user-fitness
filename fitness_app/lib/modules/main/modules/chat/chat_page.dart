import 'package:dart_openai/openai.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/modules/main/modules/chat/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String messagReplied = '';
  final textController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    OpenAI.apiKey = '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';
    super.initState();
  }

  void chat(String message) async {
    setState(() {
      loading = true;
    });
    textController.text = '';
    OpenAIChatCompletionModel chatCompletion =
        await OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo",
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: message,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    print(chatCompletion);
    final data = chatCompletion.choices.first.message.content;
    setState(() {
      messagReplied = data;
    });
    setState(() {
      loading = false;
    });
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
            content: messagReplied,
          ),
          MessageWidget(
            isSender: true,
            content: textController.text,
          ),
          if (loading)
            const MessageWidget(
              content: '',
              contentLoading: SizedBox(
                height: 20,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  colors: [Colors.black],
                  strokeWidth: 2,
                ),
              ),
              isSender: false,
            )
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
