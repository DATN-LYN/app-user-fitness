import 'package:fitness_app/global/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../global/gen/i18n.dart';
import '../../global/themes/app_colors.dart';
import '../../global/widgets/elevated_button_opacity.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  final pageController = PageController();

  List<AssetGenImage> onboardImages = [
    Assets.images.intro1,
    Assets.images.intro2,
    Assets.images.intro3,
  ];


  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Scaffold(
      body: SafeArea(child: Column(children: [
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
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 20,
              ),
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
                    label: i18n.button_Next,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ],
              ),
            ),
      ],),
      ),
    );
  }

  Widget page(I18n i18n, int index){
  return Column(
    children: [
       Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: onboardImages[index].image(
            fit: BoxFit.contain,
            height: 300,
            width: double.infinity
          ),
        ),
        const SizedBox(height: 20),
    ],
  );
  }
}

