import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';

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
        SocialRoute(),
        HomeRoute(),
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
            selectedItemColor: AppColors.grey1,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                label: 'Social',
                icon: Icon(Icons.chat),
                activeIcon: Icon(Icons.chat),
              ),
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
                activeIcon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Setting',
                icon: Icon(Icons.settings),
                activeIcon: Icon(Icons.settings),
              ),
            ],
          ),
        );
      },
    );
  }
}
