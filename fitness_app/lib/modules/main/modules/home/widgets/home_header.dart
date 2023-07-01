import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/providers/me_provider.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/gen/i18n.dart';
import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/user_avatar.dart';

class HomeHeader extends ConsumerStatefulWidget {
  const HomeHeader({super.key});

  @override
  ConsumerState<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends ConsumerState<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    var user = ref.watch(meProvider)?.user;
    bool isLogedIn = ref.watch(isSignedInProvider);

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: AppColors.primary,
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: 36,
              ),
              child: SafeArea(
                bottom: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isLogedIn
                                ? '${i18n.home_Hello}!'
                                : '${i18n.home_Hello} ${user?.fullName ?? i18n.home_User}!',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(i18n.home_HaveANiceDay),
                        ],
                      ),
                    ),
                    if (isLogedIn)
                      InkWell(
                        onTap: () =>
                            context.pushRoute(const EditProfileRoute()),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1.5,
                              color: AppColors.white,
                            ),
                          ),
                          child: UserAvatar(
                            avatar: user!.avatar,
                            fullName: user.fullName,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Hero(
              tag: 'HomeAppBar',
              child: Container(
                height: 48,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey6,
                      offset: Offset(0, 4),
                      blurRadius: 20,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.pushRoute(const SearchRoute());
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 18,
                  ),
                  label: Text(i18n.common_Search),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.grey4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // HomeServiceSelector(
        //   onChange: widget.onServiceChanged,
        // ),
        const Divider(height: 1),
      ],
    );
  }
}
