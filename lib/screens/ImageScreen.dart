import 'package:ldd/image_input.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/image-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // CustomClipPathComponent(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            child: Center(
              child: Text(
                'Tea Leaf Disease Detection',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ImageInput(),
            ),
          ),
        ],
      ),
    ));
  }
}
