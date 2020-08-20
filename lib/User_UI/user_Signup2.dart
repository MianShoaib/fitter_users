import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitter_users/User_UI/user_login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';

class user_SignUp2 extends StatefulWidget
{
  final Image_File, Fullname, User_Email, User_Pass, Birth_Date, Home_Town, Gender;
  const user_SignUp2({this.User_Email, this.User_Pass, this.Fullname, this.Home_Town, this.Gender, this.Birth_Date, this.Image_File});
  @override
  _Signup_State createState() => _Signup_State(
    fullname: Fullname,
    user_email: User_Email,
    user_pass: User_Pass,
    birth_date: Birth_Date,
    home_town: Home_Town,
    gender: Gender,
    imagefile: Image_File
  );
}


class _Signup_State extends State<user_SignUp2>
{
  final fullname, user_email, user_pass, birth_date, home_town, gender, imagefile;
  _Signup_State({this.fullname, this.user_email, this.user_pass, this.birth_date, this.home_town, this.gender,this.imagefile});
  String area , photourl = "";

  @override
  Widget build(BuildContext context)
  {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future uploadImage(BuildContext context) async
    {
      String filename = basename(imagefile.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(user_email);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(imagefile);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      photourl = taskSnapshot.ref.path;
      print(photourl);
    }



    return Scaffold(
      backgroundColor: Color(0xffe3e1e1),

//      appBar: AppBar(
//        iconTheme: IconThemeData(
//          color: Color(0xff8C04FF), //change your color here
//        ),
//        backgroundColor: Colors.white,
//        elevation: 0,
//      ),
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
                          color: Color(0xff9847b7).withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                  ),
                  //color: Colors.white,
                  height: height / 8,
                  width: width / 1,
                  child: Image.asset("images/splash_logo.png",
                    scale: 8,),


//                  Image.asset("images/splash_logo.png",
//                  )
                ),
                SizedBox(
                  height: height / 40,
                ),

                Container(
                  width: width/1,
                  height: height/1.2,
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
                          height: height/60,
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
                          height: height/60,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Text(
                            "Select the Area You Love",
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
                                  Icons.favorite_border,
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
                                  onChanged: (value)
                                  {
                                    area = value;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'select the area You Love',
                                    hintStyle: TextStyle(color: Colors.grey),
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
                          child: GestureDetector(
                            onTap: () async
                            {
                              print(fullname);
                              print(user_email);
                              print(user_pass);
                              print(birth_date);
                              print(home_town);
                              print(gender);
                              print(area);
                              FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                              AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: user_email, password: user_pass);
                              if(result!=null) {
                                print("User Created");
                                await uploadImage(context);
                                final firestoreInstance = Firestore.instance;
                                firestoreInstance.collection("users").document(user_email).setData(
                                    {
                                      "fullname" : fullname,
                                      "email" : user_email,
                                      "photourl" : photourl,
                                      "birth_date" : birth_date,
                                      "home_town" : home_town,
                                      "gender" : gender,
                                      "area" : area,
                                      "workers" : "0",
                                      "friends" : "0",
                                      "followers" : "0",
                                    });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => user_login()));
                              }
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
                              child: Center(child: Text("SignUp",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height/60,
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
                                    color: Color(0xff8c04ff),
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
                          height: height/90,
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