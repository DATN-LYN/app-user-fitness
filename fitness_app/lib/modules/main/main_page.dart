import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../global/gen/i18n.dart';
import '../../global/themes/app_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        StatisticsRoute(),
        ChatRoute(),
        SettingRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            selectedItemColor: AppColors.primaryBold,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: i18n.main_Home,
                icon: const Icon(Ionicons.home_sharp),
                activeIcon: const Icon(Ionicons.home_sharp),
              ),
              BottomNavigationBarItem(
                label: i18n.main_Statistics,
                icon: const Icon(Ionicons.bar_chart),
                activeIcon: const Icon(Ionicons.bar_chart),
              ),
              BottomNavigationBarItem(
                label: i18n.main_Chat,
                icon: const Icon(Ionicons.chatbox_ellipses),
                activeIcon: const Icon(Ionicons.chatbox_ellipses),
              ),
              BottomNavigationBarItem(
                label: i18n.main_Setting,
                icon: const Icon(Ionicons.settings),
                activeIcon: const Icon(Ionicons.settings),
              ),
            ],
          ),
        );
      },
    );
  }
}
