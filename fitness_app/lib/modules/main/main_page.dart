import 'dart:convert';

import 'package:cloudinary_dart/transformation/effect/effect.dart';
import 'package:cloudinary_dart/transformation/resize/resize.dart';
import 'package:cloudinary_dart/transformation/transformation.dart';
import 'package:cloudinary_flutter/cld_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../global/utils/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  upload() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      var resp = await http.post(Uri.parse(
          'https://api.cloudinary.com/v1_1/dltbbrtlv/upload?file=${image!.path}&upload_preset=e9xnvbev&api_key=${Constants.cloudinaryApiKey}&public_id=samples/newphoto'));
      var data = json.decode(resp.body);
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CldImageWidget(
              publicId: 'cld-sample',
              transformation: Transformation()
                ..resize(Resize.fill()
                  ..width(250)
                  ..height(250))
                ..effect(Effect.sepia()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: upload,
              child: const Text(
                'Upload',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
