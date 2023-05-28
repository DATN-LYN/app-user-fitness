import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_logout.req.gql.dart';
import 'package:fitness_app/global/graphql/client.dart';
import 'package:fitness_app/global/providers/app_settings_provider.dart';
import 'package:fitness_app/global/providers/auth_provider.dart';
import 'package:fitness_app/global/providers/me_provider.dart';
import 'package:fitness_app/global/widgets/shadow_wrapper.dart';
import 'package:fitness_app/global/widgets/shimmer_image.dart';
import 'package:fitness_app/modules/main/modules/settings/widgets/change_password_bottom_sheet.dart';
import 'package:fitness_app/modules/main/modules/settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../global/enums/app_locale.dart';
import '../../../../global/gen/i18n.dart';
import '../../../../global/routers/app_router.dart';
import '../../../../global/utils/constants.dart';
import '../../../../global/widgets/avatar.dart';
import '../../../../global/widgets/dialogs/confirmation_dialog.dart';
import '../../../../global/widgets/dialogs/radio_selector_dialog.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  bool isLoading = false;
  void changeLanguage() async {
    final i18n = I18n.of(context)!;

    final currentLocale = ref.watch(appSettingProvider).locale.getLabel(i18n);
    final data = await showDialog(
      context: context,
      builder: (_) => RadioSelectorDialog(
        currentValue: currentLocale,
        itemLabelBuilder: (item) => item,
        title: i18n.setting_Language,
        values: i18n.language,
      ),
    );
    if (data != null && data != currentLocale) {
      if (mounted) {
        final provider = ref.read(appSettingProvider.notifier);
        if (data == i18n.language[1]) {
          provider.changeLocale(AppLocale.viVN);
        } else {
          provider.changeLocale(AppLocale.enUs);
        }
      }
    }
  }

  Future<void> changePasswordHandler() async {
    final data = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (_) => const ChangePasswordBottomSheet(),
    );

    if (data != null) {}
  }

  void logOut() {
    final i18n = I18n.of(context)!;
    final user = ref.read(meProvider);
    final client = ref.read(appClientProvider);

    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        titleText: i18n.setting_ConfirmLogout,
        contentText: i18n.setting_ConfirmLogoutDes,
        positiveButtonText: i18n.button_Ok,
        onTapPositiveButton: () async {
          if (user != null) {
            final loginReq = GLogoutReq((b) => b.vars.userId = user.id);

            setState(() => isLoading = true);
            final response = await client.request(loginReq).first;
            setState(() => isLoading = false);

            if (response.data?.logout.success == true) {
              if (mounted) {
                ref.read(authProvider.notifier).logOut();
                Navigator.pop(context);
                AutoRouter.of(context).push(const LoginRoute());
              }
            }
          }
        },
      ),
    );
  }

  void openPrivacyPolicyUrl() async {
    if (await canLaunchUrlString(Constants.privacyPolicyUrl)) {
      await launchUrlString(Constants.privacyPolicyUrl);
    }
  }

  void openTermsAndConditionsUrl() async {
    if (await canLaunchUrlString(Constants.termsAndConditionsUrl)) {
      await launchUrlString(Constants.termsAndConditionsUrl);
    }
  }

  void shareIntroUrl() {
    Share.share(
      Constants.introductionUrl,
      subject: I18n.of(context)!.setting_ShareWithFriends,
    );
  }

  void goToEditProfile() {
    context.pushRoute(const EditProfileRoute());
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    var user = ref.watch(meProvider)?.user;
    bool isLogedIn = ref.watch(isSignedInProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.setting_Title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: ShimmerImage(
              width: 100,
              height: 100,
              borderRadius: BorderRadius.circular(100),
              imageUrl: user?.avatar ?? '_',
              errorWidget: Avatar(
                size: 100,
                name: user?.fullName,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              isLogedIn ? user?.fullName ?? '_' : 'Guest User',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              isLogedIn ? user?.email ?? '_' : 'Guest User',
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
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
                  i18n.setting_Account,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                if (isLogedIn) ...[
                  SettingTile(
                    icon: Ionicons.person_circle_outline,
                    title: i18n.setting_EditProfile,
                    onTap: goToEditProfile,
                  ),
                  const Divider(height: 12),
                  SettingTile(
                    icon: Icons.password,
                    title: i18n.setting_ChangePassword,
                    onTap: changePasswordHandler,
                  ),
                  const Divider(height: 12),
                  SettingTile(
                    icon: Icons.headphones,
                    title: i18n.support_Title,
                    onTap: () => context.pushRoute(const SupportListRoute()),
                  ),
                  const Divider(height: 12),
                ],
                if (!isLogedIn)
                  SettingTile(
                    icon: Icons.login,
                    title: i18n.login_LogIn,
                    onTap: () => context.pushRoute(const LoginRoute()),
                  )
                else
                  SettingTile(
                    icon: Icons.logout,
                    title: i18n.setting_Logout,
                    onTap: () => logOut(),
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
                  i18n.setting_AboutApp,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SettingTile(
                  icon: Ionicons.language,
                  title: i18n.setting_Language,
                  onTap: changeLanguage,
                ),
                const Divider(height: 12),
                SettingTile(
                  icon: Ionicons.share_social,
                  title: i18n.setting_ShareWithFriends,
                  onTap: shareIntroUrl,
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
                  onTap: openPrivacyPolicyUrl,
                ),
                const Divider(height: 12),
                SettingTile(
                  icon: Icons.file_copy_outlined,
                  title: i18n.setting_TermsAndConditions,
                  onTap: openTermsAndConditionsUrl,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
