import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../global/gen/i18n.dart';
import '../../../../../global/providers/auth_provider.dart';
import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/user_avatar.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    var user = context.watch<AuthProvider>().user;

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
                            user?.fullName == null ? 'Hello User !' : 'Hello!',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text('Have a nice day')
                        ],
                      ),
                    ),
                    if (user != null)
                      InkWell(
                        // onTap: () =>
                        //     context.pushRoute(const EditProfileRoute()),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 1.5,
                              //strokeAlign: StrokeAlign.outside,
                              color: AppColors.white,
                            ),
                          ),
                          child: UserAvatar(
                            avatar: 'jfsdjfdjfi',
                            fullName: user.fullName,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
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
                  //context.pushRoute(const SearchPlaceRoute());
                },
                icon: const Icon(
                  Icons.search,
                  size: 18,
                ),
                label: const Text('Search'),
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
