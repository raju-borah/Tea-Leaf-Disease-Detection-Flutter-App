import 'package:flutter/material.dart';
import 'package:ldd/components/rowCard.dart';

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
    final ssdClasses = routeArgs['ssd_classes'];
    final fasterRcnnClasses = routeArgs['faster_rcnn_classes'];
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
          padding: const EdgeInsets.all(20.0),
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (ssdScores != null && fasterRcnnScores != null)
              Container(
                width: size.width,
                padding: EdgeInsets.only(bottom: 20.0),
                child: Center(
                  child: Text(
                    "Disease Detected",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            if (ssdScores == null && fasterRcnnScores == null)
              Container(
                padding: EdgeInsets.only(bottom: 20.0),
                width: size.width,
                child: Center(
                  child: Text(
                    "Healthy Leaves",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CardRow(
                  imageName: ssdImageName,
                  modal: "SSD",
                  scores: ssdScores,
                  classes: ssdClasses,
                ),
                Divider(
                  color: Colors.green,
                ),
                CardRow(
                  imageName: fasterImageName,
                  modal: "Faster RCNN",
                  scores: fasterRcnnScores,
                  classes: fasterRcnnClasses,
                ),
              ],
            ),
          ],
        ));
  }
}
