import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';

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
          context.pushRoute(const ExerciseDetailRoute());
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ready to go',
                style: TextStyle(
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
            context.pushRoute(const ExerciseDetailRoute());
          },
          child: const Text(
            'START NOW',
          ),
        ),
      ),
    );
  }
}
