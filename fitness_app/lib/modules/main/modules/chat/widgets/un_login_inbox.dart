import 'package:flutter/material.dart';

import '../../../../../global/gen/assets.gen.dart';
import '../../../../../global/themes/app_colors.dart';
import '../../../../../global/widgets/shadow_wrapper.dart';

class UnLoginInbox extends StatelessWidget {
  const UnLoginInbox({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Assets.images.logoContainer.image(width: 40, height: 40),
            const ShadowWrapper(
              child: Text('Hello! How can I help you?'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            ShadowWrapper(
              child: Text('What should I do to lose weight?'),
            ),
            Icon(
              Icons.account_circle_sharp,
              size: 40,
              color: AppColors.grey3,
            )
          ],
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width * 0.75),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.images.logoContainer.image(width: 40, height: 40),
              const Expanded(
                child: ShadowWrapper(
                  child: Text(
                    'Losing weight is a common goal for many people, and there are several steps you can take to achieve this. Here are some tips to help you get started: \n1. Set a realistic goal. Before you start, its important to set a realistic weight loss goal. This will help you stay motivated and on track. 2. Create a calorie deficit. Weight loss is all about burning more calories than you consume. To create a calorie deficit, you can either reduce your calorie intake, increase your physical activity, or a combination of both. 3. Choose healthy foods. To lose weight, focus on eating nutrient-dense, whole foods such as fruits, vegetables, lean proteins, and healthy fats. Avoid processed foods and those high in added sugars and saturated fats. 4. Control your portions. Portion control is key to weight loss. Use smaller plates, measure your food, and avoid eating in front of the TV or while distracted. 5. Exercise regularly. Regular exercise can help you burn calories and maintain muscle mass. Aim for at least 150 minutes of moderate-intensity exercise or 75 minutes of vigorous exercise per week. 6. Get enough sleep. Sleep is important for weight loss. Aim for 7-8 hours of sleep per night, as lack of sleep can lead to increased hunger and cravings. Remember, losing weight is a gradual process that requires patience and persistence. Focus on making small, sustainable changes to your lifestyle, and you\'ll be on your way to achieving your weight loss goals.',
                    maxLines: 40,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            ShadowWrapper(
              child: Text('Thank you'),
            ),
          ],
        ),
      ],
    );
  }
}
