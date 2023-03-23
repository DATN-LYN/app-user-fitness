import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
  final Set<String> urls = {
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#6',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  };

  @override
  void dispose() {
    controller(index).dispose();
    controllers.clear();
    listeners.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (urls.isNotEmpty) {
      initController(0).then((_) {
        playController(0);
      });
    }

    if (urls.length > 1) {
      initController(1).whenComplete(() => lock = false);
    }
  }

  VoidCallback listenerSpawner(index) {
    return () {
      int dur = controller(index).value.duration.inMilliseconds;
      int pos = controller(index).value.position.inMilliseconds;

      setState(() {
        if (dur <= pos) {
          position = 0;
          return;
        }
        position = pos / dur;
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
      listeners[index] = listenerSpawner(index);
    }
    controller(index).addListener(listeners[index]!);
    await controller(index).play();
    setState(() {});
  }

  void _previousVideo() {
    if (lock || index == 0) {
      return;
    }
    lock = true;

    stopController(index);

    if (index + 1 < urls.length) {
      removeController(index + 1);
    }

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

    if (index - 1 >= 0) {
      removeController(index - 1);
    }

    playController(++index);

    if (index == urls.length - 1) {
      lock = false;
    } else {
      initController(index + 1).whenComplete(() => lock = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Play'),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onLongPressStart: (_) => controller(index).pause(),
            onLongPressEnd: (_) => controller(index).play(),
            child: Center(
              child: AspectRatio(
                aspectRatio: controller(index).value.aspectRatio,
                child: Center(
                  child: VideoPlayer(controller(index)),
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
          ),
          Positioned(
            child: Container(
              height: 10,
              width: MediaQuery.of(context).size.width * position,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'Back',
            onPressed: _previousVideo,
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: 24),
          FloatingActionButton(
            heroTag: 'Next',
            onPressed: nextVideo,
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
