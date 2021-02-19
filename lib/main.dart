import 'package:LDDTest/components/barChartOne.dart';
import 'package:LDDTest/screens/ImageScreen.dart';
import 'package:LDDTest/screens/homeScreen.dart';
import 'package:LDDTest/screens/resultScreen.dart';
import 'package:LDDTest/screens/splashScreen.dart';
import 'package:LDDTest/screens/testScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //fixed the orientation of app to portait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // full screen
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leaf Disease Detection',
      theme: ThemeData(
        primarySwatch:Colors.green,
        accentColor: Colors.green,
        // canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(4, 147, 114, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(4, 147, 114, 1),
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            
      ),
      
      initialRoute: 'splash-screen', // default is '/'
      routes: {
        'splash-screen':(ctx)=>SplashScreenPage(),
        '/': (ctx) => HomeScreen(),
        ResultScreen.routeName: (ctx) => ResultScreen(),
        ImageScreen.routeName: (ctx) => ImageScreen(),
        ChartsDemo.routeName: (ctx) => ChartsDemo(),
        // TestScreen.routeName: (ctx) => TestScreen(),
      },
    );
  }
}
