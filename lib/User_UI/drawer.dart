import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_users/User_UI/user_editProfile.dart';
import 'package:fitter_users/User_UI/user_login.dart';
import 'package:fitter_users/User_UI/user_myEvent.dart';
import 'package:fitter_users/User_UI/user_privacy_page.dart';
import 'package:fitter_users/User_UI/user_purse.dart';
import 'package:fitter_users/User_UI/user_serviceAgrement.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget
{
  const SideDrawer({
    Key key,
    @required  downloadURL,
    @required this.userdata,
    @required this.height,
    @required this.width,
  }) : _downloadURL = downloadURL, super(key: key);

  final String _downloadURL;
  final DocumentSnapshot userdata;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xff8C04FF),
        ),
        child: Drawer(
          elevation: 20,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(44),
                      bottomLeft: Radius.circular(44)),
                  color: Color(0xffe3e1e1),
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Color(0xff8C04FF),
                        radius: 31,
                        child:
                        _downloadURL==null ?
                        CircleAvatar(
                          backgroundColor: Colors.white70,
                          backgroundImage:
                          AssetImage("images/user/pic1.JPG"),
                          radius: 30,
                        ) :
                        CircleAvatar(
                          backgroundColor: Colors.white70,
                          backgroundImage: NetworkImage(_downloadURL),
                          radius: 30,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center + Alignment(.0, .8),
                      child: Text(
                        userdata == null ? "Name" : userdata["fullname"],
                        style:
                        TextStyle(color: Color(0xff8C04FF), fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 90,
              ),
              ListTile(
                dense: true,
                leading: Icon(
                  Icons.event,
                  color: Colors.white,
                  size: 20,
                ),
                title: Text(
                  'My Event',
                  style:
                  TextStyle(color: Colors.white, fontSize: height / 55),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_myEvent()));
                },
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                dense: true,
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                  size: 20,
                ),
                title: Text(
                  'Purse',
                  style:
                  TextStyle(color: Colors.white, fontSize: height / 55),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => user_purse()));
                },
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                dense: true,
                leading: Icon(
                  Icons.featured_play_list,
                  color: Colors.white,
                  size: 20,
                ),
                title: Text(
                  'Service Agreement',
                  style:
                  TextStyle(color: Colors.white, fontSize: height / 55),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => user_agre()));
                },
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                dense: true,
                leading: Icon(
                  Icons.stars,
                  color: Colors.white,
                  size: 20,
                ),
                title: Text(
                  'Privacy Page',
                  style:
                  TextStyle(color: Colors.white, fontSize: height / 55),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => User_privacy_page()));
                },
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                dense: true,
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20,
                ),
                title: Text(
                  'Setting',
                  style:
                  TextStyle(color: Colors.white, fontSize: height / 55),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_editProfile()));
                },
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: height / 6,
              ),
              ListTile(
                title: Align(
                  alignment: FractionalOffset.bottomRight,
                  child: new FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: width / 90,
                        ),
                        new Text(
                          "Logout",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    onPressed: ()
                    {
                      FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                      _firebaseAuth.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => user_login()));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}