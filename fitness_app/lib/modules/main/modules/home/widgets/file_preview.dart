import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../../locator.dart';

class FilePreviewPage extends StatefulWidget {
  const FilePreviewPage({super.key});

  @override
  State<FilePreviewPage> createState() => _FilePreviewPageState();
}

class _FilePreviewPageState extends State<FilePreviewPage> {
  final cloudinary = locator.get<CloudinaryPublic>();
  late VideoPlayerController _controller;

  // upload() async {
  //   final cloudinary =
  //       CloudinaryPublic('dltbbrtlv', 'ml_default', cache: false);

  //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);

  //   try {
  //     CloudinaryResponse response = await cloudinary.uploadFile(
  //       CloudinaryFile.fromFile(
  //         image!.path,
  //         resourceType: CloudinaryResourceType.Image,
  //       ),
  //       uploadPreset: 'ml_default',
  //     );

  //     print(response.secureUrl);
  //   } on CloudinaryException catch (e) {
  //     print(e.message);
  //     print(e.request);
  //   }
  // }

  uploadImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      // var resp = await http.post(Uri.parse(
      //     'https://api.cloudinary.com/v1_1/dltbbrtlv/upload?file=${image!.path}&upload_preset=e9xnvbev&api_key=${Constants.cloudinaryApiKey}&public_id=samples/newphoto'));
      // var data = json.decode(resp.body);
      //print(data);

      cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          image!.path,
          folder: 'samples/people',
        ),
      );
    }
  }

  uploadVideo() async {
    var video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video?.path != null) {
      // var resp = await http.post(Uri.parse(
      //     'https://api.cloudinary.com/v1_1/dltbbrtlv/upload?file=${image!.path}&upload_preset=e9xnvbev&api_key=${Constants.cloudinaryApiKey}&public_id=samples/newphoto'));
      // var data = json.decode(resp.body);
      //print(data);

      cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          video!.path,
          folder: 'samples/people',
        ),
      );
    }
  }

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://res.cloudinary.com/dltbbrtlv/video/upload/v1677340727/samples/people/k0y9xc8swef7rvcxrbth.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            CldImageWidget(
              publicId:
                  'https://res.cloudinary.com/dltbbrtlv/image/upload/v1677339573/samples/people/ws6ri8ajhjthkr577t1l.jpg',
            ),
            // Vide
            // CldVideo(
            //     'https://res.cloudinary.com/dltbbrtlv/video/upload/v1677340727/samples/people/k0y9xc8swef7rvcxrbth.mp4'),

            ElevatedButton(
              onPressed: uploadImage,
              child: const Text(
                'Upload image',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadVideo,
              child: const Text(
                'Upload video',
                style: TextStyle(fontSize: 20),
              ),
            ),

            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
