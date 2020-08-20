import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_forgotPassword.dart';
import 'user_navigation_bar.dart';
import 'user_signup.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class user_login extends StatefulWidget {
  @override
  _worker_loginState createState() => _worker_loginState();
}

class _worker_loginState extends State<user_login> {

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future getUser() async
  {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    var user = await _firebaseAuth.currentUser();
    if(user!=null)
    {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => user_navigation_bar()));
    }
  }

  @override
  void initState()
  {
    getUser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String email,pass;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffe3e1e1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                SizedBox(
                  height: height/50,
                ),
                Image.asset("images/splash_logo.png",
                  scale: 8,),
                SizedBox(
                  height: height/40,
                ),
                Container(
                  width: width/1,
                  height: height/1.2,
//                alignment: Alignment.b,
                  decoration: BoxDecoration(
                    color:Color(0xffe3e1e1),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: height/30,
                      ),

                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 28,
                            color: Color(0xff9847b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height/40,
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          "Email",
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
                                Icons.email,
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
                                  email = value;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'luqman.edu303@gmail.com',
                                  hintStyle: TextStyle(color: Colors.grey),
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
                                Icons.lock_open,
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
                                  pass = value;
                                },
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    iconSize: 18,
                                    color: Colors.grey,
                                    onPressed: _toggle,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 0),
                                  border: InputBorder.none,
                                  hintText: '***********',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),



                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: new FlatButton(
                            child: new Text(
                              "Forgot Password?",
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
                                        builder: (context) => user_forget()))
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async
                          {
                            FirebaseAuth _auth = FirebaseAuth.instance;
                            var user = await  _auth.signInWithEmailAndPassword(email: email, password: pass);
                            if(user!=null)
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => user_navigation_bar()));
                              }
                            else
                              {
                                print("Error in login");
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
                            child: Center(child: Text("Login",
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

                      Center(
                        child: Text(
                          "OR",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),


                      SizedBox(
                        height: height/60,
                      ),


                      Center(
                        child: Text(
                          "Countine With",
                          style: TextStyle(color: Color(0xff9847b7), fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),

                      SizedBox(
                        height: height/60,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async
                                {
                            FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                            GoogleSignIn _googleSignIn = new GoogleSignIn();
                            final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
                            final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                            final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
                            AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
                            FirebaseUser userDetail = authResult.user;
                            String email = userDetail.email;
                            String name = userDetail.displayName;
                            print("Google Login");
                            print(email);
                            print(name);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => user_navigation_bar()));
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
                                    image: AssetImage("images/google.png"),
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
                              FacebookLogin fblogin = new FacebookLogin();
                              fblogin
                                  .logIn(['email','public_profile'])
                                  .then((result) async {
                                    switch(result.status)
                                    {
                                      case FacebookLoginStatus.loggedIn:
                                        {
                                          FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                                          final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
                                          AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
                                          FirebaseUser userDetail = authResult.user;
                                          String email = userDetail.email;
                                          String name = userDetail.displayName;
                                          print(email);
                                          print(name);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => user_navigation_bar()));
                                        }
                                    }
                              })
                                  .catchError((e){
                                    print(e);
                              });
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
                                    image: AssetImage("images/facebook.png"),
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
      ),
    );
  }
}
