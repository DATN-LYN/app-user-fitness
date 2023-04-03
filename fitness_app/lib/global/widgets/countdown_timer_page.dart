import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';

import '../gen/i18n.dart';
import '../themes/app_colors.dart';

class CountdownTimerPage extends StatefulWidget {
  const CountdownTimerPage({
    super.key,
    this.initialDuration = const Duration(seconds: 3),
    this.isBreak = false,
  });

  final Duration initialDuration;
  final bool isBreak;

  @override
  State<CountdownTimerPage> createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  late Duration countdownDuration = widget.initialDuration;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final seconds = countdownDuration.inSeconds - 1;
        if (seconds < 0) {
          timer.cancel();
          if (widget.isBreak) {
            context.popRoute();
          } else {
            context.replaceRoute(const ExerciseDetailRoute());
          }
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
                widget.isBreak
                    ? i18n.countdown_BreakTime
                    : i18n.countdown_ReadyToGo,
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
            if (widget.isBreak) {
              context.popRoute();
            } else {
              context.replaceRoute(const ExerciseDetailRoute());
            }
          },
          child:
              Text(widget.isBreak ? i18n.button_Next : i18n.countdown_StartNow),
        ),
      ),
    );
  }
}
