import 'package:fitness_app/global/providers/app_settings_provider.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/modules/main/modules/settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/enums/app_locale.dart';
import '../../../../global/gen/i18n.dart';
import '../../../../global/widgets/avatar.dart';
import '../../../../global/widgets/dialogs/radio_selector_dialog.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  void changeLanguage(AppSettingsProvider provider, I18n i18n) async {
    final data = await showDialog(
      context: context,
      builder: (_) => RadioSelectorDialog(
        currentValue: provider.appSettings.locale.getLabel(i18n),
        itemLabelBuilder: (item) => item,
        title: i18n.setting_Language,
        values: i18n.language,
      ),
    );
    if (data != provider.appSettings.locale.getLabel(i18n)) {
      if (mounted) {
        if (data == i18n.language[1]) {
          provider.changeLocale(AppLocale.viVN);
        } else {
          provider.changeLocale(AppLocale.enUs);
        }
      }
    }
  }

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
                Consumer<AppSettingsProvider>(
                    builder: (context, provider, child) {
                  return SettingTile(
                    icon: Icons.language,
                    title: i18n.setting_Language,
                    onTap: () => changeLanguage(provider, i18n),
                  );
                }),
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
