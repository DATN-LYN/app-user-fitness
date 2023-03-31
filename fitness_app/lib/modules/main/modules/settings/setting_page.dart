import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/modules/main/modules/settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';

import '../../../../global/gen/i18n.dart';
import '../../../../global/widgets/avatar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.setting_Title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: Avatar(
              size: 80,
              name: 'Nhi',
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Nhi',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ShadowWrapper(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  i18n.setting_AboutApp,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SettingTile(
                  icon: Icons.language,
                  title: i18n.setting_Language,
                ),
                const Divider(height: 12),
                SettingTile(
                  icon: Icons.share,
                  title: i18n.setting_ShareWithFriends,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ShadowWrapper(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  i18n.setting_Security,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SettingTile(
                  icon: Icons.privacy_tip_outlined,
                  title: i18n.setting_PrivacyPolicy,
                ),
                const Divider(height: 12),
                SettingTile(
                  icon: Icons.note_outlined,
                  title: i18n.setting_TermsAndConditions,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ShadowWrapper(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  i18n.setting_Account,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SettingTile(
                  icon: Icons.password,
                  title: i18n.setting_ChangePassword,
                ),
                const Divider(height: 12),
                SettingTile(
                  icon: Icons.logout,
                  title: i18n.setting_Logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
