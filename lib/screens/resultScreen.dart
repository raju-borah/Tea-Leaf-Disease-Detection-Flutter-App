// import 'dart:convert';

import 'package:ldd/components/barChartOne.dart';
// import 'package:LDDTest/components/customClipPathComponent.dart';
// import 'package:LDDTest/components/topBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// import 'package:progress_indicators/progress_indicators.dart';
class ResultScreen extends StatelessWidget {
  static const routeName = '/result-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    final ssdImageName = routeArgs['ssd_image_name'];
    final fasterImageName = routeArgs['faster_image_name'];
    final ssdScores = routeArgs['ssd_scores'];
    final fasterRcnnScores = routeArgs['faster_rcnn_scores'];
    print(ssdImageName);
    print(fasterImageName);
    print(ssdScores);
    print(fasterRcnnScores);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Result',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          toolbarHeight: 75,
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (ssdScores != null && fasterRcnnScores != null)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: size.width,
                  child: Center(
                    child: Text(
                      "Disease Detected",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            if (ssdScores == null && fasterRcnnScores == null)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: size.width,
                  child: Center(
                    child: Text(
                      "Healthy Leaves",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CachedNetworkImage(
                    imageUrl: kImageUrl + '$ssdImageName',
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CachedNetworkImage(
                    imageUrl: kImageUrl + '$fasterImageName',
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ],
            ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 400),
            //   child: Align(
            //     alignment: FractionalOffset.center,
            //     child: Text("${detectionScores[0]}"),
            //   ),
            // ),
            Spacer(),
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
                  Navigator.of(context)
                      .pushNamed(ChartsDemo.routeName, arguments: {
                    'ssd_scores': ssdScores,
                    'faster_rcnn_scores': fasterRcnnScores,
                  });
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
