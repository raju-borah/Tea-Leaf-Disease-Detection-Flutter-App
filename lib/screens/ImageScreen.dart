import 'package:LDDTest/image_input.dart';
import 'package:flutter/material.dart';

// clippath
class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 50, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ImageScreen extends StatelessWidget {
  static const routeName = '/image-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: ClipPath(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 380,
              color: Theme.of(context).primaryColor,
            ),
            clipper: CustomClipPath(),
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
        Center(
          child: ImageInput(),
          // ],
          // ),
        )
      ],
    )
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
