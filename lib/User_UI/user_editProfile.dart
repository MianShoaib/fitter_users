import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitter_users/User_UI/user_home.dart';
import 'package:fitter_users/User_UI/user_login.dart';
import 'package:fitter_users/User_UI/user_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class user_editProfile extends StatefulWidget {
  @override
  _admin_loginState createState() => _admin_loginState();
}

class _admin_loginState extends State<user_editProfile> {
  String name = "",
      email = "",
      pass1 = "",
      pass2 = "",
      hometown = "",
      imagefile = "",
      area = "",
      url = "";
  FirebaseUser user;
  bool imagepicked = false;
  var gendertype = "1";
  SharedPreferences _pref;
  bool f1 = false, f2 = false;
  //--------------------------------------------------------
  //--------------------------------------------------------
  Firestore firestoreinstance = Firestore.instance;
  //--------------------------------------------------------
  var name_controller = TextEditingController(),
      /*pass1_controller = TextEditingController(),
      pass2_controller = TextEditingController(),*/
      area_controller = TextEditingController(),
      town_controller = TextEditingController();

  final _name_Key = GlobalKey<FormState>(),
      /*_pass1_key = GlobalKey<FormState>(),
      _pass2_key = GlobalKey<FormState>(),*/
      _town_Key = GlobalKey<FormState>(),
      _area_Key = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  DropdownButton gender() => DropdownButton<String>(
        icon: Icon(
          Icons.arrow_drop_down_circle,
          size: 18,
        ),
        items: [
          DropdownMenuItem<String>(
            value: "1",
            child: Text(
              "Male",
            ),
          ),
          DropdownMenuItem<String>(
            value: "2",
            child: Text(
              "Female",
            ),
          ),
          DropdownMenuItem<String>(
            value: "3",
            child: Text(
              "Other",
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            gendertype = value;
            print(gendertype);
          });
        },
        value: gendertype,
      );

  void ShowToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple.shade300,
        textColor: Colors.white);
  }

  void Storepref() async
  {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("fullname", name);
    _pref.setString("photourl", url);
    _pref.setString("birth_date", selectedDate.toString());
    _pref.setString("home_town", hometown);
    _pref.setString("gender", gendertype.toString());
    _pref.setString("area", area);
    bool store = await _pref.commit();
    if(store)
    {
      print("User Stored in Preferences as well");
    }
  }

  File _image;
  var pickedFile;
  Future getImage() async {
    pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imagepicked = true;
      _image = File(pickedFile.path);
    });
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future downloadImage() async
  {
    String downloadAddress = await FirebaseStorage.instance.ref().child(user.email).getDownloadURL();
    print(downloadAddress);
    setState(() {
      url = downloadAddress;
    });
  }

  Future uploadImage(BuildContext context) async
  {
    print(user.email);
    try{
      StorageReference oldRef = FirebaseStorage.instance.ref().child(user.email);
      await oldRef.delete();
      print("Image Deleted");
    }
    catch(e)
    {
      print(e);
    }
    //String filename = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(user.email);
    print(_image);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    url = taskSnapshot.ref.path;
  }

  void Init() async
  {
    user = await FirebaseAuth.instance.currentUser();
    print(user.email);
    _pref = await SharedPreferences.getInstance();
    email = _pref.getString("email");
    name = _pref.getString("fullname");
    url = _pref.getString("photourl");
    hometown = _pref.getString("home_town");
    area = _pref.getString("area");
    setState(() {});
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
          "Edit Profile",
          style: TextStyle(
            color: Color(0xff9847b7),
          ),
        ),
        backgroundColor: Color(0xffe3e1e1),
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: height / 40,
                ),
                Container(
                  width: width / 1,
                  height: height / 1.2,
//                alignment: Alignment.b,
                  decoration: BoxDecoration(
                    color: Color(0xffe3e1e1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
//              boxShadow: [
//                BoxShadow(
//                  color:Color(0xff8C04FF).withOpacity(0.9),
//                  spreadRadius: 0,
//                  blurRadius: 1,
//                  offset: Offset(0, 15), // changes position of shadow
//                ),
//              ],
                  ),

                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: height / 60,
                        ),
                        Center(
                          child: url == null || imagepicked != false
                              ? _image == null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white70,
                                      backgroundImage:
                                          AssetImage("images/user/pic1.JPG"),
                                      radius: 30,
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.white70,
                                      backgroundImage: FileImage(_image),
                                      radius: 30,
                                    )
                              : CircleAvatar(
                                  backgroundColor: Colors.white70,
                                  backgroundImage: NetworkImage(url),
                                  radius: 30,
                                ),
                        ),
                        GestureDetector(
                          onTap: getImage,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Upload image",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 22,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height / 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Text(
                            "UserName",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              new Expanded(
                                child: Form(
                                  key: _name_Key,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      name = value;
                                    },
                                    controller: name_controller
                                      ..text = name == null ? "" : name,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter valid Username.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter you Name Here",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Text(
                            "New Password",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Icon(
                                  Icons.lock_open,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              new Expanded(
                                child: Form(
                                  key: _pass1_key,
                                  child: TextFormField(
                                    onChanged: (value)
                                    {
                                      pass1 = value;
                                    },
                                    controller: pass1_controller,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter valid pass of length 7 minimum';
                                      }
                                      return null;
                                    },
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        iconSize: 18,
                                        color: Colors.grey,
                                        onPressed: _toggle,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 0),
                                      border: InputBorder.none,
                                      hintText: '***********',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Text(
                            "Confirm New Password",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Icon(
                                  Icons.lock_open,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              new Expanded(
                                child: Form(
                                  key: _pass2_key,
                                  child: TextFormField(
                                    controller: pass2_controller,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter valid pass of length 7 minimum';
                                      }
                                      return null;
                                    },
                                    onChanged: (value)
                                    {
                                      pass2 = value;
                                    },
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.remove_red_eye),
                                        iconSize: 18,
                                        color: Colors.grey,
                                        onPressed: _toggle,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 0),
                                      border: InputBorder.none,
                                      hintText: '***********',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Text(
                            "Birthday",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              new Expanded(
                                child: GestureDetector(
                                  onTap: ()
                                  {
                                    _selectDate(context);
                                  },
                                  child: Text("${selectedDate.toLocal()}"
                                      .split(' ')[0]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Text(
                            "Home Town",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Icon(
                                  Icons.home,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              new Expanded(
                                child: Form(
                                  key: _town_Key,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter valid Address';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      hometown = value;
                                    },
                                    controller: town_controller
                                      ..text = hometown == null ? "" : hometown,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Pir Mahal,Toba tek Singh",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Text(
                            "Gender",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                        ),
                        SizedBox(
                          height: height / 90,
                        ),
                        Center(
                          child: Container(
                            width: width / 1.14,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
//                        color: Colors.yellow,
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 18),
                                child: gender(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Text(
                            "Area You Love",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              new Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              new Expanded(
                                child: Form(
                                  key: _area_Key,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Area of Interest';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      area = value;
                                    },
                                    controller: area_controller
                                      ..text = area == null ? "" : area,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'I love Myself',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height / 30,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async
                            /*{
                              if (_name_Key.currentState.validate() &&
                                  _area_Key.currentState.validate() &&
                                  *//*_pass1_key.currentState.validate() &&
                                  _pass2_key.currentState.validate() &&*//*
                                  _town_Key.currentState.validate())
                              {
                                if (pass1 == pass2)
                                {
                                  user = await FirebaseAuth.instance.currentUser();
                                  if (imagepicked)
                                  {
                                    await uploadImage(context);
                                    await downloadImage();
                                  }
                                  await firestoreinstance
                                      .collection("users")
                                      .document(user.email)
                                      .updateData({
                                    "fullname": name,
                                    "birth_date": selectedDate,
                                    "home_town": hometown,
                                    "gender": gendertype.toString(),
                                    "area": area,
                                  });
                                  print("User Stored on firestore");
                                  await Storepref();
                                  user.updatePassword(pass1).whenComplete(() => print("Password Updated"));
                                  await FirebaseAuth.instance.signOut();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => user_login()));
                                }
                                else {
                                  ShowToast("Pass Doesn't Match");
                                }
                              }
                            }*/
                            {
                              user = await FirebaseAuth.instance.currentUser();
                              if (imagepicked)
                              {
                                await uploadImage(context);
                                await downloadImage();
                              }
                              await firestoreinstance
                                  .collection("users")
                                  .document(email)
                                  .updateData({
                                "fullname": name,
                                "birth_date": selectedDate,
                                "home_town": hometown,
                                "gender": gendertype.toString(),
                                "area": area,
                              });
                              print("User Stored on firestore");
                              await Storepref();
                              await ShowToast("Changes Updated");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => user_navigation_bar()));
                            },
                            child: Container(
                              width: width / 1.2,
                              height: 50.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                gradient: LinearGradient(
                                  begin: Alignment(0.0, -1.0),
                                  end: Alignment(0.0, 1.0),
                                  colors: [
                                    const Color(0xff9847b7),
                                    const Color(0xffbc5dff)
                                  ],
                                  stops: [0.0, 1.0],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height / 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
