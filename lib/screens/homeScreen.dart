import 'package:LDDTest/screens/ImageScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            child: Stack(children: <Widget>[
          Container(
            height: 250,
            width: size.width,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Theme.of(context).primaryColor.withOpacity(0.83),
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/logo.png",
                  height: 70,
                ),
                Container(
                  child: Text(
                    'Tea Leaf Disease Detection',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
        ])),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 30),
            child: Text(
              "Plants play an important role in the field of Human life from agriculture to gardening. Proper nurturing is required for healthy growth of plants. Plant diseases are a major threat to food and identifying the disease remains difficult. To address this problem, we came with an idea to provide an image-based automatic inspection interface.",
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
        Expanded(
          child: MaterialButton(
            padding: EdgeInsets.only(top: 0, bottom: 25),
            minWidth: double.infinity,
            textColor: Colors.white,
            color: Colors.green,
            onPressed: () {
              Navigator.of(context).pushNamed(ImageScreen.routeName);
            },
            child: Text(
              "Check Now",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
