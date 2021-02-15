import 'dart:convert';

import 'package:LDDTest/components/barChartOne.dart';
import 'package:LDDTest/components/customClipPathComponent.dart';
import 'package:LDDTest/components/topBar.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = '/result-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    final imageData = routeArgs['image'];
    final detectionScores = routeArgs['detection_scores'];
    final detectionBoxes = routeArgs['detection_boxes'];
    print("This is result data");
    print(detectionScores);
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Result'),
        // ),
        body: Stack(
      children: [
        CustomClipPathComponent(),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: IconButton(
                color: Theme.of(context).primaryColorLight,
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        TopBar(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(350),
                  // BorderRadius.only(
                  //   bottomLeft: Radius.circular(36),
                  //   topLeft: Radius.circular(36),
                  // ),
                  child: Image.file(
                    imageData,
                    fit: BoxFit.cover,
                    height: 300,
                    width: 300,
                  )),
            ],
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: MaterialButton(
            padding: EdgeInsets.all(10),
            minWidth: size.width / 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: () {
              Navigator.of(context).pushNamed(ChartsDemo.routeName);
            },
            child: Text(
              "View Graph",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
