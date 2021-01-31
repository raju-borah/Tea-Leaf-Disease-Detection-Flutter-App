import 'package:LDDTest/image_input.dart';
import 'package:flutter/material.dart';

// void selectCategory(BuildContext ctx) {
//   Navigator.of(ctx).pushNamed(
//     CategoryMealsScreen.routeName
//   );
// }

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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Leaf Disease Detection'),
        ),
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/images/bg.jpg"),
          //   ),
          // ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ClipPath(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      color: Theme.of(context).primaryColor,
                    ),
                    clipper: CustomClipPath(),
                  ),
                ),
              )),
              Image.asset('./assets/images/leaf.png'),
              ImageInput(),
            ],
          ),
        ));
  }
}
