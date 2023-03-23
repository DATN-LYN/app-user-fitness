import 'package:fitness_app/modules/main/modules/type/widgets/program_tile_large.dart';
import 'package:flutter/material.dart';

class TypeDetailPage extends StatefulWidget {
  const TypeDetailPage({super.key});

  @override
  State<TypeDetailPage> createState() => _TypeDetailPageState();
}

class _TypeDetailPageState extends State<TypeDetailPage> {
  @override
  Widget build(BuildContext context) {
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
