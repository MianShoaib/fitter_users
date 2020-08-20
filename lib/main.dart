
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitter_users/User_UI/user_walkthrough.dart';
import 'package:fitter_users/user_Splash.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new user_Splash(),
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new user_walkthrough()
      },
    );
  }
}
