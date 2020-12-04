import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_users/User_UI/user_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class user_purse extends StatefulWidget {
  @override
  purse_updateState createState() => purse_updateState();
}

class purse_updateState extends State<user_purse>
{
  FirebaseUser user;

  SharedPreferences _pref;
  String cardnumber,name,cv_number,M_Y;
  var cardnumber_controller = TextEditingController(),
      name_controller = TextEditingController(),
      cv_number_controller = TextEditingController(),
      M_Y_controller = TextEditingController();

  final _cardnumber_key = GlobalKey<FormState>(),
      _name_Key = GlobalKey<FormState>(),
      _cv_number_Key = GlobalKey<FormState>(),
      _M_Y_key = GlobalKey<FormState>();

  Future Init() async
  {
    user = await FirebaseAuth.instance.currentUser();
    _pref = await SharedPreferences.getInstance();
    print(_pref);
    setState(()
    {
      cardnumber = _pref.get("cardnumber");
      name = _pref.get("name");
      cv_number = _pref.get("cv_number");
      M_Y = _pref.get("M_Y");
    });
  }


  @override
  void initState() {
    Init();
    // TODO: implement initState
    super.initState();
  }
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
                            child: Form(
                              key: _cardnumber_key,
                              child: TextFormField(
                                controller: cardnumber_controller
                                  ..text = cardnumber == null ? "" : cardnumber,
                                onChanged: (value)
                                {
                                  cardnumber = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty || value.length!=16)
                                  {
                                    return 'Please enter valid Card Number of Lenght 16';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'xxxx xxxx xxxx xxxx',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                keyboardType: TextInputType.number,
                              ),
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
                            child: Form(
                              key: _M_Y_key,
                              child: TextFormField(
                                controller: M_Y_controller
                                  ..text = M_Y == null ? "" : M_Y,
                                onChanged: (value)
                                {
                                  M_Y = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty)
                                  {
                                    return 'Please enter valid Month/Year';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '09-2020',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                keyboardType: TextInputType.number,
                              ),
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
                            child: Form(
                              key: _cv_number_Key,
                              child: TextFormField(
                                controller: cv_number_controller
                                  ..text = cv_number == null ? "" : cv_number,
                                onChanged: (value)
                                {
                                  cv_number = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty || value.length!=3)
                                  {
                                    return 'Please enter valid Card Number of Lenght 3';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'XXX',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                keyboardType: TextInputType.number,
                              ),
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
                            child: Form(
                              key: _name_Key,
                              child: TextFormField(
                                controller: name_controller
                                  ..text = name == null ? "" : name,
                                onChanged: (value)
                                {
                                  name = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty)
                                  {
                                    return 'Please enter Name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Sohal Ahmad Rajput',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height/30,
                    ),

                    Center(
                      child: RaisedButton(
                        onPressed: () async
                        {
                          print("Updating Purse");
                          if(_name_Key.currentState.validate() &&
                              _cv_number_Key.currentState.validate() &&
                              _M_Y_key.currentState.validate() &&
                              _cardnumber_key.currentState.validate())
                          {
                            _pref.setString("cardnumber", cardnumber);
                            _pref.setString("name", name);
                            _pref.setString("cv_number", cv_number);
                            _pref.setString("M_Y", M_Y);
                            bool store = await _pref.commit();
                            if(store)
                            {
                              print("Purse Stored in Preferences as well");
                            }

                            final firestore = Firestore.instance;
                            firestore.collection("users").document(user.email)
                                .collection("Purse").document(user.email).updateData({
                              "cardnumber": cardnumber,
                              "name": name,
                              "cv_number": cv_number,
                              "M_Y": M_Y
                            })
                                .then((value)
                            {
                              print("User Purse Updated in Preferences as well");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => user_navigation_bar()));
                            });
                          }},
                        padding: EdgeInsets.symmetric(vertical: height/50,horizontal: width/2.8),
                        color: Color(0xff9847b7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xffbc5dff))
                        ),
                        child: Text("Update",
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),),),
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
