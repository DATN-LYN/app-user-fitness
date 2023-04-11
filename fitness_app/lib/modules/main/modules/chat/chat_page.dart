import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/modules/main/modules/chat/widgets/message_inpput_widget.dart';
import 'package:fitness_app/modules/main/modules/chat/widgets/message_widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
        reverse: true,
        children: const [
          SizedBox(height: 16),
          MessageWidget(
            isSender: false,
          ),
          MessageWidget(
            isSender: true,
          ),
        ],
      ),
      bottomNavigationBar: const MessageInputWidget(),
    );
  }
}
