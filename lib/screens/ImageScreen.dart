import 'package:LDDTest/components/customClipPathComponent.dart';
import 'package:LDDTest/image_input.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/image-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CustomClipPathComponent(),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
              child: IconButton(
                color: Theme.of(context).primaryColorLight,
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
              child: Text(
                "Leaf Disease Detection",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Center(
          child: ImageInput(),
        )
      ],
    )
        //  Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       SizedBox(height: 52.0),
        //       FadingText('Checking Your Leaf sample...',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 25,
        //           )),
        //     ])
        // Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/bg.jpg",
        //     ),
        //   ),
        // ),
        // child:

        );
  }
}
