
import 'package:fitness_app/modules/category/widgets/program_tile_large.dart';
import 'package:flutter/material.dart';

import '../../global/gen/i18n.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({super.key});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym'),
      ),
      body: ListView.separated(
        itemCount: 10,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return const ProgramTileLarge();
        },
        separatorBuilder: (_, __) => const SizedBox(height: 16),
      ),
    );
  }
}
