import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/gen/assets.gen.dart';
import 'package:fitness_app/global/providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../global/gen/i18n.dart';
import '../../global/routers/app_router.dart';
import '../../global/themes/app_colors.dart';
import '../../global/widgets/elevated_button_opacity.dart';

class OnBoardPage extends ConsumerStatefulWidget {
  const OnBoardPage({super.key});

  @override
  ConsumerState<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends ConsumerState<OnBoardPage> {
  final pageController = PageController();
  String btnText = '';

  List<AssetGenImage> onboardImages = [
    Assets.images.intro1,
    Assets.images.intro2,
    Assets.images.intro3,
  ];

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    btnText = i18n.button_Next;
    final appSettings = ref.watch(appSettingProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                children: List.generate(
                  onboardImages.length,
                  (index) => page(i18n, index),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: onboardImages.length,
                    effect: WormEffect(
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.grey1.withOpacity(0.3),
                      dotWidth: 10,
                      dotHeight: 10,
                    ),
                  ),
                  ElevatedButtonOpacity(
                    label: btnText,
                    color: AppColors.neutral20,
                    height: 50,
                    radius: 30,
                    fontSize: 16,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    onTap: () async {
                      if (pageController.page! >= onboardImages.length - 1) {
                        setState(() {
                          btnText = i18n.button_Done;
                        });
                        appSettings.saveFirstLaunch();
                        if (mounted) {
                          AutoRouter.of(context).replaceAll(
                            [const MainRoute()],
                          );
                        }
                      } else {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  Widget page(I18n i18n, int index) {
    return Column(
      children: [
        const Spacer(),
        onboardImages[index].image(
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Text(
            i18n.onboard_Title[index],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Text(
            i18n.onboard_Description[index],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              height: 1.5,
            ),
            overflow: TextOverflow.visible,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
