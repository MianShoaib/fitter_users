import 'dart:io';

import 'package:fitter_users/User_UI/user_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class user_purse extends StatefulWidget {
  @override
  purse_updateState createState() => purse_updateState();
}

class purse_updateState extends State<user_purse> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffe3e1e1),

    appBar: AppBar(
      iconTheme: IconThemeData(
        color: Color(0xff9847b7), //change your color here
      ),
      centerTitle: true,

      title: Text(
        "Card Details",
        style: TextStyle(
          fontSize: 22,
          color: Color(0xff9847b7),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color(0xffe3e1e1),
      elevation: 2,
    ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[


              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: height/60,
                    ),




                    Center(
                      child: Image(
                        image: AssetImage("images/user/credit_card.png"),
                        height: 200,
                        width: 200,
                      ),
                    ),





                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        "Card No.",
                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        children: <Widget>[
                          new Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                            child: Icon(
                              Icons.credit_card,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: 1.0,
                            color: Colors.grey.withOpacity(0.5),
                            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                          ),
                          new Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'xxxx xxxx xxxx xxxx',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        "Month/Year",
                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        children: <Widget>[
                          new Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                            child: Icon(
                              Icons.date_range,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: 1.0,
                            color: Colors.grey.withOpacity(0.5),
                            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                          ),
                          new Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '09-2020',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        "CVC2 CVV2",
                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        children: <Widget>[
                          new Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                            child: Icon(
                              Icons.confirmation_number,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: 1.0,
                            color: Colors.grey.withOpacity(0.5),
                            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                          ),
                          new Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'XXX',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        "Full Name",
                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        children: <Widget>[
                          new Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: 1.0,
                            color: Colors.grey.withOpacity(0.5),
                            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                          ),
                          new Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Sohal Ahmad Rajput',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                    ),








                    SizedBox(
                      height: height/30,
                    ),

                    Center(
                      child: GestureDetector(
                        onTap: ()
                        {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => user_navigation_bar()));
                        },
                        child: Container(
                          width: width/1.2,
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
                          child: Center(child: Text("Update",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),),),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height/40,
                    ),



                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
