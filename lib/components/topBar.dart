import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/logo.png",
            height: 70,
          ),
          Container(
            child: Center(
              child: Text(
                'Tea Leaf Disease Detection',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Spacer(),
        ],
      ),
    );
  }
}
