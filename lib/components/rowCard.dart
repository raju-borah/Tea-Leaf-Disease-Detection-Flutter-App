import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ldd/constants.dart';
import 'package:ldd/screens/imageCard.dart';

class CardRow extends StatelessWidget {
  CardRow(
      {@required this.imageName,
      @required this.modal,
      @required this.scores,
      @required this.classes});
  final imageName;
  final modal;
  final scores;
  final classes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, ImageCard.routeName, arguments: {
                'img': imageName,
                'modal': modal,
                'scores': scores,
                'classes': classes,
              });
            },
            child: Hero(
              tag: 'image-card-$modal',
              child: CachedNetworkImage(
                height: 200,
                width: 200,
                imageUrl: kImageUrl + '$imageName',
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
          ),
        ),
        Expanded(flex: 1, child: Text("$modal MODEL")),
      ],
    );
  }
}
