import 'package:LDDTest/homeScreen.dart';
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
    return MaterialApp(
      title: 'Leaf Disease Detection',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
      ),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => HomeScreen(),
      },
    );
  }
}
