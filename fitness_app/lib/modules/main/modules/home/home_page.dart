import 'package:fitness_app/modules/main/modules/home/widgets/home_header.dart';
import 'package:flutter/material.dart';

import '../../../../global/utils/client_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ClientMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        Expanded(
          child: Container(),
        )
      ],
    );
  }
}
