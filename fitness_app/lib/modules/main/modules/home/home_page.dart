import 'package:fitness_app/global/gen/i18n.dart';
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
                Label(i18n.programs_TrendingPrograms),
                const SizedBox(
                  height: 170,
                  child: ProgramList(),
                ),
                Label(i18n.categories_Categories),
                const SizedBox(
                  height: 100,
                  child: CategoryList(),
                ),
                Label(i18n.programs_MostViewedPrograms),
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
}
