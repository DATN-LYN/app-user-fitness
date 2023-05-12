import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';

import '../../../../../../global/gen/assets.gen.dart';
import '../../../../../../global/themes/app_colors.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({super.key});

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 32),
            Assets.images.finish.image(
              height: 400,
            ),
            Text(
              i18n.finish_Hooray,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                StatisticItem(
                  title: '809',
                  subtitle: 'Calories',
                  icon: const Icon(
                    Icons.local_fire_department,
                    size: 30,
                    color: AppColors.error,
                  ),
                  color: AppColors.error,
                ),
                StatisticItem(
                  title: '600',
                  subtitle: 'Minutes',
                  icon: const Icon(
                    Icons.timelapse,
                    size: 30,
                    color: AppColors.warning,
                  ),
                  color: AppColors.warning,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: ElevatedButton(
          onPressed: () =>
              AutoRouter.of(context).popUntilRouteWithName(MainRoute.name),
          child: Text(i18n.finish_GoBackToHome),
        ),
      ),
    );
  }

  Widget StatisticItem({
    required Icon icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(100),
            ),
            child: icon,
          ),
          const SizedBox(height: 25),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(subtitle),
        ],
      ),
    );
  }
}
