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
    this.exerciseCount,
  });

  final Duration initialDuration;
  final bool isBreak;
  final String? exerciseCount;

  @override
  State<CountdownTimerPage> createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  late Duration countdownDuration = widget.initialDuration;
  late int seconds = widget.initialDuration.inSeconds;
  Timer? countdownTimer;

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds = countdownDuration.inSeconds - 1;
        if (seconds < 0) {
          timer.cancel();
          if (widget.isBreak) {
            context.popRoute();
          } else {
            context.replaceRoute(const PlayExerciseRoute());
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
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: widget.isBreak
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                widget.isBreak
                    ? '${i18n.countdown_BreakTime},'
                    : i18n.countdown_ReadyToGo,
                style: TextStyle(
                  fontSize: isPortrait ? 35 : 30,
                  color: AppColors.primaryBold,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (widget.isBreak) ...[
                const SizedBox(height: 8),
                Text(
                  i18n.countdown_WalkAround,
                  style: TextStyle(
                    fontSize: isPortrait ? 25 : 20,
                    color: AppColors.primaryBold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const Spacer(),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.square(
                      dimension: isPortrait ? 200 : 110,
                      child: CircularProgressIndicator(
                        value: ((widget.initialDuration.inSeconds - seconds) /
                                widget.initialDuration.inSeconds)
                            .toDouble(),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryBold,
                        ),
                        backgroundColor: AppColors.primarySoft,
                        strokeWidth: 6,
                      ),
                    ),
                    Text(
                      countdownDuration.inSeconds.toString(),
                      style: TextStyle(
                        fontSize: isPortrait ? 100 : 50,
                        color: AppColors.primaryBold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.isBreak) ...[
                SizedBox(height: isPortrait ? 48 : 22),
                Center(
                  child: Text(
                    i18n.countdown_YouHaveFinishCountEx(
                      widget.exerciseCount.toString(),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.primaryBold,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    i18n.countdown_DoNotForgetToDrinkWater,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.primaryBold,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: ElevatedButton(
          onPressed: () {
            countdownTimer?.cancel();
            if (widget.isBreak) {
              context.popRoute();
            } else {
              context.replaceRoute(const PlayExerciseRoute());
            }
          },
          child:
              Text(widget.isBreak ? i18n.button_Next : i18n.countdown_StartNow),
        ),
      ),
    );
  }
}
