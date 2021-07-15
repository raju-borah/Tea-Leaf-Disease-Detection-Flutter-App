import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ldd/components/barChartOne.dart';
import 'package:ldd/constants.dart';

class ImageCard extends StatelessWidget {
  static const routeName = '/large-image-card';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map;
    final imageName = routeArgs['img'];
    final modal = routeArgs['modal'];
    final scores = routeArgs['scores'];
    final classes = routeArgs['classes'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: 'image-card-$modal',
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: '$kImageUrl${imageName.toString().trim()}',
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: MaterialButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.green,
                    size: 30.0,
                  ),
                ),
              ),
              Text(
                "Disease Detected by",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
              Text(
                "$modal",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                minWidth: size.width,
                padding: EdgeInsets.all(25),
                shape: RoundedRectangleBorder(),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ChartsDemo.routeName, arguments: {
                    'detection_scores': scores,
                    'classes': classes,
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
          ),
        ],
      ),
    );
  }
}
