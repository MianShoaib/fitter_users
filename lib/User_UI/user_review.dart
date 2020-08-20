import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'user_myEvent.dart';




class user_review extends StatefulWidget {
  @override
  user_reviewState createState() => user_reviewState();
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class user_reviewState extends State<user_review> {
  var rating = 3.0;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff8C04FF), //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                height: height / 40,
              ),
              Container(
                width: width / 1,
                height: height / 1.3,
//                alignment: Alignment.b,
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
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
                      height: height / 50,
                    ),
                    Text(
                      "Rate it !",
                      style: TextStyle(
                        fontSize: 28,
                        color: Color(0xff8C04FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: height / 20,
                    ),

                    Text(
                      "Mark",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff8C04FF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),



                    Text(
                      "How is Your Trip?",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black45,
                        fontWeight: FontWeight.w700,
                      ),
                    ),


                    SizedBox(
                      height: height / 60,
                    ),



                    SmoothStarRating(
                      rating: rating,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      defaultIconData: Icons.star_border,
                      starCount: 5,
                      allowHalfRating: true,
                      spacing: 2,
                      size: 44,
                      color: Colors.yellow,
                      onRated: (value)
                      {
                        print(value);
                      },
                    ),


                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,

                            hintText: 'Additioanl Comment',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          maxLines: 8,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height / 60,
                    ),



                    GestureDetector(
                      onTap: ()
                      {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => user_myEvent()));
                      },
                      child: Container(
                        width: width/1.2,
                        height: 45.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                            colors: [const Color(0xff8c04ff), const Color(0xffbc5dff)],
                            stops: [0.0, 1.0],
                          ),
                        ),
                        child: Center(child: Text("Submit",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),),
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
