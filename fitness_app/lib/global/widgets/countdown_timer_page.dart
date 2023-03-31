import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';

import '../gen/i18n.dart';
import '../themes/app_colors.dart';

class CountdownTimerPage extends StatefulWidget {
  const CountdownTimerPage({super.key});

  @override
  State<CountdownTimerPage> createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  Duration countdownDuration = const Duration(seconds: 3);

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final seconds = countdownDuration.inSeconds - 1;
        if (seconds < 0) {
          timer.cancel();
          context.replaceRoute(const ExerciseDetailRoute());
        } else {
          countdownDuration = Duration(seconds: seconds);
        }
      });
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                i18n.countdown_ReadyToGo,
                style: const TextStyle(
                  fontSize: 40,
                  color: AppColors.primaryBold,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 50),
              Text(
                countdownDuration.inSeconds.toString(),
                style: const TextStyle(
                  fontSize: 100,
                  color: AppColors.primaryBold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: ElevatedButton(
          onPressed: () {
            context.replaceRoute(const ExerciseDetailRoute());
          },
          child: Text(i18n.countdown_StartNow),
        ),
      ),
    );
  }
}
