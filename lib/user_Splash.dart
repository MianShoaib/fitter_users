import 'package:flutter/material.dart';
import 'dart:async';

class user_Splash extends StatefulWidget {


//  final ImageProvider splash_logo;
//  Splash({
//    Key key,
//    this.splash_logo = const AssetImage('assets/images/splash_logo.png'),
//  }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<user_Splash> {
  startTime() async {
    var _duration = new Duration(milliseconds: 2000);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: Image.asset("images/splash_logo.png",
        scale: 5,)
      ),
    );
  }
}
