import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_users/User_UI/user_home.dart';
import 'package:fitter_users/User_UI/user_login.dart';
import 'package:fitter_users/User_UI/user_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'user_walkthrough_1.dart';
import 'user_walkthrough_2.dart';
import 'user_walkthrough_3.dart';
class user_walkthrough extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<user_walkthrough> {
  int currentIndexPage;
  int pageLength;

  @override
  void initState() {
    currentIndexPage = 0;
    pageLength = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        PageView(
          children: <Widget>[
            user_walkthrough_1(),
            user_walkthrough_2(),
            user_walkthrough_3(),

          ],
          onPageChanged: (value) {
            setState(() => currentIndexPage = value);
          },
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.16,
          // left: MediaQuery.of(context).size.width * 0.35,
          child: Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: new DotsIndicator(
                position: currentIndexPage.toDouble(),
                dotsCount: pageLength,
                decorator: DotsDecorator(
                    activeColor: Colors.white, color: Colors.grey),
//                      numberOfDot: pageLength,
//                      position: currentIndexPage,
//                      dotColor: Colors.black87,
//                      dotActiveColor: Colors.amber
//
              ),
            ),
          ),
        ),

//
    Positioned(
      bottom: MediaQuery.of(context).size.height /40,
      child: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25),
        child: GestureDetector(
          onTap: () async
          {
            FirebaseUser user = await FirebaseAuth.instance.currentUser();
            if (user != null)
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          user_navigation_bar()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          user_login()));
            }
          },
          child: Container(
          width: 178.0,
          height: 50.0,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          gradient: LinearGradient(
          begin: Alignment(0.0, -1.0),
          end: Alignment(0.0, 1.0),
          colors: [const Color(0xff9847b7), const Color(0xffbc5dff)],
          stops: [0.0, 1.0],
          ),
          ),
            child: Center(child: Text("Skip",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),),),
          ),
        ),
      ),
    ),

      ],
    ));
  }
}

