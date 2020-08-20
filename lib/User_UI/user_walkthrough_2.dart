import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class user_walkthrough_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe3e1e1),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("images/splash_logo.png"),
                width: 200,
                height: 160,
              ),
              Text(
                "Ready to Learn",
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xff9847b7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 60,
              ),
              Container(
                width: 300,
                height: 78,
                decoration: BoxDecoration(
                  color: Color(0xffe3e1e1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70)),
//                  boxShadow: [
//                    BoxShadow(
//                      color:Color(0xff8C04FF).withOpacity(0.9),
//                      spreadRadius: 0,
//                      blurRadius: 1,
//                      offset: Offset(0, 15), // changes position of shadow
//                    ),
//                  ],
                ),

                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ));
  }
}
