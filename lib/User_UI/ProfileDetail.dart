import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitter_users/User_Models/fitter_event_model.dart';
import 'package:fitter_users/User_UI/user_home.dart';
import 'package:fitter_users/User_UI/user_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profileDetail extends StatefulWidget {
  // final Event event;
  // final booked;
  // const book_event({Key key, this.booked, this.event}) : super(key: key);
  @override
  profileDetailState createState() =>
      profileDetailState(
          // event: event, booked: booked
      );
}

class profileDetailState extends State<profileDetail> {
  // SharedPreferences _pref;
  // profileDetailState({this.event, this.booked});
  // Event event;
  // bool booked;
  String name = 'Luqman Asif';
  String location = 'Fasilabad';
  String postion = 'Worker';
  String contact = '+92 323 5077538';
  // String dollar = '400';
  // String time = '10:00AM to 11:00AM';
  // String date = '18.1.2021';
  // String status = 'Mininum';
  // String people = '6';

  void ShowToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple.shade300,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffe3e1e1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              height: height / 6,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage(
                      "images/user/Events.jpg",
                    ),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.dstATop)),
//                    borderRadius: BorderRadius.circular(20)
              ),
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: width / 5,
                      ),
                      Text(
                        "Profile Detail",
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xff9847b7),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[


                SizedBox(
                  height: height / 60,
                ),

                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        height: height / 2,
                        width: width / 1.1,
                        child: Card(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 38.0, bottom: 18, left: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
//                                      mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: height / 36,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff4f4848)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),

                                  SizedBox(
                                    height: height / 50,
                                  ),

                                  //location
                                  Text(
                                    "Location",
                                    style: TextStyle(
                                      fontSize: height / 42,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff9847b7),
                                    ),
                                    //textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    width: width / 1.3,
                                    child: Text(
                                      location,
                                      style: TextStyle(
                                          fontSize: height / 60,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                      maxLines: 4,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ),

                                  SizedBox(
                                    height: height / 50,
                                  ),


                                  //postion
                                  Text(
                                    "Postion",
                                    style: TextStyle(
                                      fontSize: height / 42,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff9847b7),
                                    ),
                                    //textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    width: width / 1.3,
                                    child: Text(
                                      postion,
                                      style: TextStyle(
                                          fontSize: height / 60,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                      maxLines: 4,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ),


                                  SizedBox(
                                    height: height / 50,
                                  ),


                                  //conatct
                                  Text(
                                    "Phone No.",
                                    style: TextStyle(
                                      fontSize: height / 42,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff9847b7),
                                    ),
                                    //textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    width: width / 1.3,
                                    child: Text(
                                      contact,
                                      style: TextStyle(
                                          fontSize: height / 60,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54),
                                      maxLines: 4,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: 80,
                        height: 80,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: DecoratedBox(
                            decoration: ShapeDecoration(
                                shape: CircleBorder(),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                    // vent.Worker_url==null
                                  //     ?
                                  AssetImage('images/user/pic1.JPG')
                                      // : NetworkImage(event.Worker_url),
                                )),
                          ),
//                            child: CircleAvatar(
//                              backgroundImage: AssetImage("images/admin/pic1.jpeg"),
//                              radius: 32,
//                            ),
                        )),
                  ],
                ),

                SizedBox(
                  height: height / 60,
                ),


                SizedBox(
                  height: height / 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
