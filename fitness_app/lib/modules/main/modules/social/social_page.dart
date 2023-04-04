import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:flutter/material.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Health care chat')),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          Container(
            constraints: BoxConstraints(maxWidth: width * 0.8),
            alignment: Alignment.centerLeft,
            child: ShadowWrapper(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.primarySoft,
              child: const Text(
                'dhashdasjhdjashdjashdashdashdashduiahsduahsduahsdauih',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: width * 0.8),
            alignment: Alignment.bottomRight,
            child: ShadowWrapper(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(8),
              child: const Text(
                'dhashdasjhdjashdjashdashdashdashduiahsduahsduahsdauih',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
