import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../global/themes/app_colors.dart';
import '../../global/utils/duration_time.dart';

enum PlayerState { playing, paused }

class ExerciseDetailPage extends StatefulWidget {
  const ExerciseDetailPage({super.key});

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  int index = 0;
  double position = 0;
  bool lock = true;
  final Map<String, VideoPlayerController> controllers = {};
  final Map<int, VoidCallback> listeners = {};
  int maxValue = 0;
  int value = 0;
  PlayerState playerState = PlayerState.playing;
  final List<String> urls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#6',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  ];

  @override
  void dispose() {
    controller(index).dispose();
    controllers.clear();
    listeners.clear();
    super.dispose();
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() {
    if (urls.isNotEmpty) {
      initController(0).then((_) {
        playController(0);
      });
    }
    if (urls.length > 1) {
      initController(1).whenComplete(() => lock = false);
    }
  }

  VoidCallback checkEndVideo(index) {
    return () {
      int dur = controller(index).value.duration.inMilliseconds;
      int pos = controller(index).value.position.inMilliseconds;

      setState(() {
        maxValue = dur;
        value = pos;
      });
      if (dur - pos < 1) {
        if (index < urls.length - 1) {
          nextVideo();
        }
      }
    };
  }

  VideoPlayerController controller(int index) {
    return controllers[urls.elementAt(index)]!;
  }

  Future<void> initController(int index) async {
    var controller = VideoPlayerController.network(urls.elementAt(index));
    controllers[urls.elementAt(index)] = controller;
    await controller.initialize();
  }

  void removeController(int index) {
    controller(index).dispose();
    controllers.remove(urls.elementAt(index));
    listeners.remove(index);
  }

  void stopController(int index) {
    controller(index).removeListener(listeners[index]!);
    controller(index).pause();
    controller(index).seekTo(const Duration(milliseconds: 0));
  }

  void playController(int index) async {
    if (!listeners.keys.contains(index)) {
      listeners[index] = checkEndVideo(index);
    }
    controller(index).addListener(listeners[index]!);
    await controller(index).play();
    setState(() {});
  }

  void previousVideo() {
    if (lock || index == 0) {
      return;
    }
    lock = true;

    stopController(index);

    // if (index + 1 < urls.length) {
    //   removeController(index + 1);
    // }

    playController(--index);

    if (index == 0) {
      lock = false;
    } else {
      initController(index - 1).whenComplete(() => lock = false);
    }
  }

  void nextVideo() async {
    if (lock || index == urls.length - 1) {
      return;
    }
    lock = true;

    stopController(index);

    await context.pushRoute(
      CountdownTimerRoute(
        isBreak: true,
        initialDuration: const Duration(seconds: 20),
      ),
    );

    playController(++index);

    if (index == urls.length - 1) {
      lock = false;
    } else {
      initController(index + 1).whenComplete(() => lock = false);
    }
  }

  void handlerSliderChanged(double milliseconds) async {
    await controller(index).seekTo(
      Duration(milliseconds: milliseconds.toInt()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chest And Tricep'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            style: theme.textButtonTheme.style?.copyWith(
              textStyle: const MaterialStatePropertyAll(
                TextStyle(
                  color: AppColors.grey1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            child: Text(
              '${index + 1} / ${urls.length}',
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: !isPortrait
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        videoPlayer(),
                        remainDurationContainer(),
                      ],
                    )
                  : Center(child: videoPlayer()),
            ),
            if (isPortrait) ...[
              const SizedBox(height: 16),
              remainDurationContainer(),
            ],
            const SizedBox(height: 16),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 5,
                activeTickMarkColor: Colors.transparent,
                inactiveTickMarkColor: Colors.transparent,
                overlayShape: SliderComponentShape.noThumb,
              ),
              child: Slider(
                max: max(maxValue.toDouble(), value.toDouble()),
                value: value.toDouble() > 0 ? value.toDouble() : 0,
                divisions: maxValue.toInt() > 0 ? maxValue.toInt() : 1,
                onChanged: handlerSliderChanged,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousVideo,
                  icon: const Icon(
                    Icons.skip_previous_rounded,
                    color: AppColors.grey1,
                  ),
                  iconSize: 30,
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  width: 48,
                  height: 48,
                  child: IconButton(
                    onPressed: () async {
                      if (playerState == PlayerState.playing) {
                        setState(() {
                          playerState = PlayerState.paused;
                        });
                        await controller(index).pause();
                      } else {
                        setState(() {
                          playerState = PlayerState.playing;
                        });
                        await controller(index).play();
                      }
                    },
                    icon: playerState == PlayerState.playing
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: nextVideo,
                  icon: const Icon(
                    Icons.skip_next_rounded,
                    color: AppColors.grey1,
                  ),
                  iconSize: 30,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AspectRatio videoPlayer() {
    return AspectRatio(
      aspectRatio: controller(index).value.aspectRatio,
      child: Center(
        child: VideoPlayer(controller(index)),
      ),
    );
  }

  Container remainDurationContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primarySoft,
      ),
      child: Text(
        DurationTime.totalDurationFormat(
          controller(index).value.duration - controller(index).value.position,
        ),
        style: const TextStyle(
          fontSize: 41,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryBold,
        ),
      ),
    );
  }
}
