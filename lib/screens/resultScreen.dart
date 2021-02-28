// import 'dart:convert';

import 'package:LDDTest/components/barChartOne.dart';
// import 'package:LDDTest/components/customClipPathComponent.dart';
// import 'package:LDDTest/components/topBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// import 'package:progress_indicators/progress_indicators.dart';
class ResultScreen extends StatelessWidget {
  static const routeName = '/result-screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    final filename = routeArgs['filename'];
    final detectionScores = routeArgs['detection_scores'];

    print("This is result data");
    print(detectionScores);
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
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CustomClipPathComponent(),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            //       child: IconButton(
            //         color: Theme.of(context).primaryColorLight,
            //         icon: Icon(Icons.arrow_back_rounded),
            //         onPressed: () {
            //           Navigator.pop(context);
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // TopBar(),
            // Center(
            //   child:
            if (detectionScores != null)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: size.width,
                  child: Center(
                    child: Text(
                      "Spot Detected",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            if (detectionScores == null)
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://tealeavesspotdata.s3.amazonaws.com/$filename.jpg",
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
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
                    'detection_scores': detectionScores,
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
