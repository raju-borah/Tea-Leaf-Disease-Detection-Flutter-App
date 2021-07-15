import 'package:ldd/image_input.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/image-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      // shrinkWrap: true,
      children: [
        // CustomClipPathComponent(),
        ImageInput(),
      ],
    ));
  }
}
