import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_login.dart';
import 'user_signup.dart';

class user_lanidngPage extends StatefulWidget {
  @override
  _admin_loginState createState() => _admin_loginState();
}

class _admin_loginState extends State<user_lanidngPage> {

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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                height: height/30,
              ),
              Image.asset("images/splash_logo.png",
                scale: 6,),
              SizedBox(
                height: height/20,
              ),
              Container(
                width: width/1,
                height: height/1.3,
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

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: height/30,
                    ),

                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 28,
                        color: Color(0xff9847b7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: height/20,
                    ),


                    GestureDetector(
                      onTap: ()
                      {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => user_login()));
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
                        child: Center(child: Text("Login",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),),
                      ),
                    ),


                    SizedBox(
                      height: height/20,
                    ),

                    Text(
                      "OR",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                    ),


                    SizedBox(
                      height: height/20,
                    ),


                    Text(
                      "Countine With",
                      style: TextStyle(color: Color(0xff9847b7), fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),

                    SizedBox(
                      height: height/50,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: ()
                          {
//                          Navigator.push(
////                              context,
////                              MaterialPageRoute(
////                                  builder: (context) => navigation_bar()));
                          },
                          child: Container(
                            width: width/7,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Color(0xffe3e1e1),
                              borderRadius: BorderRadius.circular(100.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],

                            ),
                            child: Center(
                                child: Image(
                                  image: AssetImage("images/worker/google.png"),
                                  height: 20,
                                  width: 20,
                                )
                            ),
                          ),
                        ),
                        SizedBox(width: width/40,),
                        GestureDetector(
                          onTap: ()
                          {
                            print("Facebook Login");
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => navigation_bar()));
                          },
                          child: Container(
                            width: width/7,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Color(0xffe3e1e1),
                              borderRadius: BorderRadius.circular(100.0),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],

                            ),
                            child: Center(
                                child: Image(
                                  image: AssetImage("images/worker/facebook.png"),
                                  height: 20,
                                  width: 20,
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
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
                                "SignUp here",
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
                                        builder: (context) => user_SignUp()))
                              },
                            ),
                          ],
                        ),
                      ),
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
