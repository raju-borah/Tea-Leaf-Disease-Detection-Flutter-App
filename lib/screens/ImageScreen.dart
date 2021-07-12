import 'package:LDDTest/components/customClipPathComponent.dart';
import 'package:LDDTest/image_input.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/image-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tea Leaf Disease Detection',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomClipPathComponent(),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: ImageInput(),
              ),
            ],
          ),
        ));
  }
}
