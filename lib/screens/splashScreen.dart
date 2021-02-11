import 'package:LDDTest/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: HomeScreen(),
      title: new Text(
        'Welcome To Tea Leaf Disease Detector',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.asset(
          'assets/images/tealogo.png',
          height: 500,
          width: 500,),
      backgroundColor: Colors.white,
      loaderColor: Theme.of(context).primaryColor,
    );
  }
}