import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = '/result-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final imageData = routeArgs['image'];
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Result'),
        // ),
        body: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Container(
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    topLeft: Radius.circular(36),
                  ),
                  child: Image.file(
                    imageData,
                    fit: BoxFit.cover,
                    height: 550,
                    width: 300,
                  )),
              // Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       SizedBox(height: 52.0),
              //       FadingText('Checking Your Leaf sample...',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 25,
              //           )),
              //     ])
            ],
          ),
        ),
      ],
    ));
  }
}
