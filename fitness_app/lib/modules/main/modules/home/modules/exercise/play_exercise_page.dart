import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:chewie/chewie.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/exercise_fragment.data.gql.dart';
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_program.req.gql.dart';
import 'package:fitness_app/global/providers/current_stats_id.provider.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:fitness_app/global/widgets/dialogs/confirmation_dialog.dart';
import 'package:fitness_app/global/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../global/graphql/client.dart';
import '../../../../../../global/graphql/fragment/__generated__/program_fragment.data.gql.dart';
import '../../../../../../global/themes/app_colors.dart';
import '../../../../../../global/utils/date_time_helper.dart';
import '../../../../../../global/utils/dialogs.dart';

enum PlayerState { playing, paused }

class PlayExercisePage extends ConsumerStatefulWidget {
  const PlayExercisePage({
    super.key,
    required this.exercises,
    required this.program,
  });

  final List<GExercise> exercises;
  final GProgram program;

  @override
  ConsumerState<PlayExercisePage> createState() => _PlayExercisePageState();
}

class _PlayExercisePageState extends ConsumerState<PlayExercisePage> {
  int index = 0;
  bool lock = true;
  int maxValue = 0;
  int value = 0;
  bool loading = true;
  final Map<String, VideoPlayerController> controllers = {};
  final Map<int, VoidCallback> listeners = {};
  PlayerState playerState = PlayerState.playing;
  List<String> urls = [];

  @override
  void dispose() {
    controller(index)!.dispose();
    controllers.clear();
    listeners.clear();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp) async {
      initData();
    });
    super.initState();
  }

  initData() async {
    upsertProgramView();

    if (mounted) {
      setState(() {
        urls = widget.exercises.map((e) {
          Uri initialUri = Uri.parse(e.videoUrl!);
          Uri replaceUri = initialUri.replace(scheme: 'https');
          return replaceUri.toString();
        }).toList();
      });

      await initController(0);

      playController(0);

      setState(() => loading = false);

      if (urls.length > 1) {
        await initController(1);
        setState(() {
          lock = false;
        });
      }
    }
  }

  void upsertProgramView() async {
    final client = ref.watch(appClientProvider);
    var req = GUpsertProgramReq(
      (b) => b
        ..vars.input.bodyPart = widget.program.bodyPart
        ..vars.input.categoryId = widget.program.categoryId
        ..vars.input.id = widget.program.id
        ..vars.input.imgUrl = widget.program.imgUrl
        ..vars.input.description = widget.program.description
        ..vars.input.level = widget.program.level
        ..vars.input.name = widget.program.name
        ..vars.input.view = (widget.program.view ?? 0) + 1,
    );

    final response = await client.request(req).first;
    if (response.hasErrors) {
      if (context.mounted) {
        DialogUtils.showError(context: context, response: response);
      }
    }
  }

  VoidCallback checkEndVideo(index) {
    return () {
      int dur = controller(index)!.value.duration.inMilliseconds;
      int pos = controller(index)!.value.position.inMilliseconds;

      setState(() {
        maxValue = dur;
        value = pos;
      });
      if (dur - pos < 1) {
        if (index < urls.length - 1) {
          nextVideo();
        } else if (index == urls.length - 1) {
          goToFinishPage();
        }
      }
    };
  }

  void goToFinishPage() {
    context.pushRoute(
      FinishRoute(
        exercises: widget.exercises,
        program: widget.program,
      ),
    );
  }

  VideoPlayerController? controller(int index) {
    if (urls.isEmpty) return null;
    return controllers[urls.elementAt(index)]!;
  }

  Future<void> initController(int index) async {
    var controller = VideoPlayerController.network(urls.elementAt(index));
    controllers[urls.elementAt(index)] = controller;
    await controller.initialize();
  }

  void stopController(int index) {
    controller(index)?.removeListener(listeners[index]!);
    controller(index)?.pause();
    controller(index)?.seekTo(const Duration(milliseconds: 0));
  }

  void playController(int index) {
    if (!listeners.keys.contains(index)) {
      listeners[index] = checkEndVideo(index);
    }
    controller(index)?.addListener(listeners[index]!);
    controller(index)?.play();
  }

  void previousVideo() {
    if (lock || index == 0) {
      return;
    }
    lock = true;

    stopController(index);

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
        index: index,
        exercises: widget.exercises,
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
    await controller(index)?.seekTo(
      Duration(milliseconds: milliseconds.toInt()),
    );
  }

  void showDialogConfirmQuit() {
    final i18n = I18n.of(context)!;
    controller(index)?.pause();
    setState(() => playerState = PlayerState.paused);

    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          image: const Icon(Icons.warning_rounded),
          titleText: i18n.exerciseDetail_QuitWorkout,
          contentText: i18n.exerciseDetail_QuitWorkoutDes,
          onTapPositiveButton: () {
            AutoRouter.of(context).popUntilRouteWithName(
              ProgramDetailRoute.name,
            );
            ref.read(currentStatsId.notifier).update((state) => null);
          },
          onTapNegativeButton: () {
            context.popRoute();
            controller(index)?.play();
            setState(() => playerState = PlayerState.playing);
          },
        );
      },
    );
  }

  void onPlayPauseVideo() async {
    if (playerState == PlayerState.playing) {
      setState(() {
        playerState = PlayerState.paused;
      });
      await controller(index)?.pause();
    } else {
      setState(() {
        playerState = PlayerState.playing;
      });
      await controller(index)?.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final theme = Theme.of(context);

    return LoadingOverlay(
      loading: loading,
      child: Scaffold(
        appBar: isPortrait
            ? AppBar(
                title: Text(widget.exercises[index].name ?? '_'),
                centerTitle: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  onPressed: showDialogConfirmQuit,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.landscapeLeft,
                        DeviceOrientation.landscapeRight,
                      ]);
                    },
                    icon: const Icon(Icons.fullscreen),
                  ),
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
                    child: Text('${index + 1} / ${urls.length}'),
                  ),
                ],
              )
            : null,
        body: SafeArea(
          child: !isPortrait && controller(index) != null
              ? landscapeVideoPlayer()
              : portraitVideoPlayer(context),
        ),
      ),
    );
  }

  Widget portraitVideoPlayer(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(child: videoPlayer()),
        ),
        const SizedBox(height: 16),
        remainDurationContainer(),
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
                onPressed: onPlayPauseVideo,
                icon: playerState == PlayerState.playing
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                if (index == urls.length - 1) {
                  goToFinishPage();
                } else {
                  nextVideo();
                }
              },
              icon: const Icon(
                Icons.skip_next_rounded,
                color: AppColors.grey1,
              ),
              iconSize: 30,
            ),
          ],
        )
      ],
    );
  }

  Widget landscapeVideoPlayer() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Chewie(
          controller: ChewieController(
            videoPlayerController: controller(index)!,
            autoInitialize: true,
          ),
        ),
        CircleAvatar(
          backgroundColor: AppColors.grey6,
          child: IconButton(
            onPressed: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
                // DeviceOrientation.landscapeLeft,
                // DeviceOrientation.landscapeRight,
              ]);
            },
            icon: const Icon(
              Icons.fullscreen_exit,
            ),
          ),
        ),
      ],
    );
  }

  Widget? videoPlayer() {
    if (controller(index) != null) {
      return AspectRatio(
        aspectRatio: controller(index)!.value.aspectRatio,
        child: Center(
          child: VideoPlayer(controller(index)!),
        ),
      );
    }
    return null;
  }

  Widget remainDurationContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primarySoft,
      ),
      child: Text(
        DateTimeHelper.totalDurationFormat(
          (controller(index)?.value.duration ?? const Duration()) -
              (controller(index)?.value.position ?? const Duration()),
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
