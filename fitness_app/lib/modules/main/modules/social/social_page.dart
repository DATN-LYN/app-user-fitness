import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/modules/main/modules/social/widgets/message_inpput_widget.dart';
import 'package:fitness_app/modules/main/modules/social/widgets/message_widget.dart';
import 'package:flutter/material.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey6.withOpacity(0.3),
      appBar: AppBar(
        title: const Text('Health care chat'),
        elevation: 0,
      ),
      body: ListView(
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
