import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/widgets/label.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/category_list.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/home_header.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/program_list_most_viewed.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/program_list_newest.dart';
import 'package:fitness_app/modules/main/modules/home/widgets/user_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../global/providers/me_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final isLogedIn = ref.watch(isSignedInProvider);

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
                if (isLogedIn)
                  const UserStatistic()
                else
                  const UnLoginUserStatistics(),
                _listLabel(
                  label: i18n.programs_NewestPrograms,
                  onPressed: () =>
                      context.pushRoute(ProgramListRoute(isNewest: true)),
                ),
                const SizedBox(
                  height: 170,
                  child: ProgramListNewest(),
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
                  onPressed: () =>
                      context.pushRoute(ProgramListRoute(isNewest: false)),
                ),
                const SizedBox(
                  height: 170,
                  child: ProgramListMostViewed(),
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
          padding: const EdgeInsets.only(top: 24, bottom: 12),
        ),
        GestureDetector(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 12),
            child: Text(
              i18n.home_ViewAll,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
