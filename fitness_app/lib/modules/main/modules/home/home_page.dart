import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/widgets/label.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/category_list.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/home_header.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/program_list.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/user_statistic.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          key = GlobalKey();
        });
      },
      child: Column(
        key: key,
        children: [
          const HomeHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const UserStatistic(),
                _listLabel(
                  label: i18n.programs_TrendingPrograms,
                  onPressed: () => context.pushRoute(const ProgramListRoute()),
                ),
                const SizedBox(
                  height: 170,
                  child: ProgramList(),
                ),
                _listLabel(
                  label: i18n.categories_Categories,
                  onPressed: () => context.pushRoute(const CategoryListRoute()),
                ),
                const SizedBox(
                  height: 100,
                  child: CategoryList(),
                ),
                _listLabel(
                  label: i18n.programs_MostViewedPrograms,
                  onPressed: () => context.pushRoute(const ProgramListRoute()),
                ),
                const SizedBox(
                  height: 170,
                  child: ProgramList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listLabel({
    required String label,
    required VoidCallback onPressed,
  }) {
    final i18n = I18n.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Label(
          label,
          padding: const EdgeInsets.only(top: 24, bottom: 8),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(i18n.home_ViewAll),
        ),
      ],
    );
  }
}
