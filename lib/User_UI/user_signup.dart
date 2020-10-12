import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'user_Signup2.dart';
import 'user_login.dart';

class user_SignUp extends StatefulWidget {
  @override
  _user_signupState createState() => _user_signupState();
}

class _user_signupState extends State<user_SignUp> {
  bool genderselected = false, dateselected = false, imagepicked = false;
  var name_controller = TextEditingController(),
      email_controller = TextEditingController(),
      pass_controller = TextEditingController(),
      home_controller = TextEditingController();

  final _name_Key = GlobalKey<FormState>(),
      _email_Key = GlobalKey<FormState>(),
      _pass_Key = GlobalKey<FormState>(),
      _home_key = GlobalKey<FormState>();

  String fullname = "", email = "", pass = "", hometown = "";

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateselected = true;
      });
    }
  }

  void ShowToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple.shade300,
        textColor: Colors.white);
  }

  var gendertype = "1";
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
            genderselected = true;
            gendertype = value;
            print(gendertype);
          });
        },
        value: gendertype,
      );

  File _image;
  var pickedFile;
  final picker = ImagePicker();
  Future getImage() async {
    pickedFile = await picker.getImage(source: ImageSource.gallery);
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffe3e1e1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    color: Color(0xffe3e1e1),
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(0.0),
                        bottomLeft: const Radius.circular(40.0),
                        bottomRight: const Radius.circular(40.0),
                        topRight: const Radius.circular(0.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff8c04ff).withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                  ),
                  //color: Colors.white,
                  height: height / 8,
                  width: width / 1,
                  child: Image.asset(
                    "images/splash_logo.png",
                    scale: 8,
                  ),

//                  Image.asset("images/splash_logo.png",
//                  )
                ),
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
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff9847b7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: height / 60,
                        ),

                        Center(
                          child: CircleAvatar(
                            backgroundImage: _image == null
                                ? AssetImage("images/user/pic1.JPG")
                                : FileImage(_image),
                            radius: 48,
                          ),
                        ),

                        SizedBox(
                          height: height / 60,
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
                              SizedBox(
                                width: width / 60,
                              ),
                              Icon(
                                Icons.camera_alt,
                                size: 22,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: height / 60,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Text(
                            "Full Name",
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
                                    controller: name_controller,
                                    onChanged: (value) {
                                      fullname = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Full Name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Luqman Asif',
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
                            "Email",
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
                                  Icons.email,
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
                                  key: _email_Key,
                                  child: TextFormField(
                                    controller: email_controller,
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter valid email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'luqman.edu303@gmail.com',
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
                            "Password",
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
                                  key: _pass_Key,
                                  child: TextFormField(
                                    controller: pass_controller,
                                    onChanged: (value) {
                                      pass = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Password';
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
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Text(
                                    "${selectedDate.toLocal()}".split(' ')[0]),
                              ))
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
                                  key: _home_key,
                                  child: TextFormField(
                                    controller: home_controller,
                                    onChanged: (value) {
                                      hometown = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter Home Town';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Pir Mahal,Toba Tek Singh',
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
                          height: height / 30,
                        ),

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (_name_Key.currentState.validate() &&
                                  _home_key.currentState.validate() &&
                                  _pass_Key.currentState.validate() &&
                                  _home_key.currentState.validate()) {
                                if (!imagepicked) {
                                  ShowToast('Please pick a Profile Image');
                                } else if (!dateselected) {
                                  ShowToast('Please set Birth Date');
                                } else if (!genderselected) {
                                  ShowToast('Please select Gender');
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => user_SignUp2(
                                                Fullname: fullname,
                                                User_Email: email,
                                                User_Pass: pass,
                                                Birth_Date: selectedDate,
                                                Gender: gendertype,
                                                Home_Town: hometown,
                                                Image_File: _image,
                                              )));
                                }
                              }
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
                                  "Countine",
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
                          height: height / 60,
                        ),

                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                  fontSize: 15.0,
                                ),
                              ),
                              new FlatButton(
                                child: new Text(
                                  "Login here",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff9847b7),
                                    fontSize: 15.0,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => user_login()))
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height / 90,
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
