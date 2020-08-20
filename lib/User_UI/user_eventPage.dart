import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class user_event extends StatefulWidget {
  @override
  worker_eventState createState() => worker_eventState();
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class worker_eventState extends State<user_event> {



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff8C04FF), //change your color here
        ),
        title:  Text(
          "Event Details",
          style: TextStyle(
//            fontSize: 28,
            color: Color(0xff8C04FF),
//            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SizedBox(
              height: height / 40,
            ),
            Container(
              width: width / 1,
              height: height / 1.38,
//                alignment: Alignment.b,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: height / 20,
                    ),


                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top:18.0,bottom: 18),
                        child: Column(
                          children: <Widget>[

                            Container(
                              width: width/1.1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Text(
                                    "The Story behind the space X",
                                    style: TextStyle(
                                        fontSize: height / 38,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4f4848)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    //textAlign: TextAlign.center,
                                  ),

                                  GestureDetector(
                                    onTap: ()
                                    {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => admin_login()));
                                    },
                                    child: Container(
                                      width: width/6,
                                      height: 26.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100.0),
                                        gradient: LinearGradient(
                                          begin: Alignment(0.0, -1.0),
                                          end: Alignment(0.0, 1.0),
                                          colors: [const Color(0xff8c04ff), const Color(0xffbc5dff)],
                                          stops: [0.0, 1.0],
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.bookmark_border,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          Text("Open",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14
                                            ),),

                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            SizedBox(
                              height: height/90,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.location_on,size: 18,),
                                  Text(
                                    "Pir Mahal, Toba Tek Singh",
                                    style: TextStyle(
                                        fontSize: height / 48,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4f4848)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    //textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: height/90,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[


                                Container(
                                  width: width/7.6,
                                  height: 26.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    gradient: LinearGradient(
                                      begin: Alignment(0.0, -1.0),
                                      end: Alignment(0.0, 1.0),
                                      colors: [const Color(0xff8c04ff), const Color(0xffbc5dff)],
                                      stops: [0.0, 1.0],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text("\$400",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width/3,
                                  height: 26.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    gradient: LinearGradient(
                                      begin: Alignment(0.0, -1.0),
                                      end: Alignment(0.0, 1.0),
                                      colors: [const Color(0xff12C053), const Color(0xff109043)],
                                      stops: [0.0, 1.0],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      Text("10:00AM to 11:00",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12
                                        ),),

                                    ],
                                  ),
                                ),
                                Container(
                                  width: width/4.4,
                                  height: 26.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    gradient: LinearGradient(
                                      begin: Alignment(0.0, -1.0),
                                      end: Alignment(0.0, 1.0),
                                      colors: [const Color(0xffC2C911), const Color(0xffBCA017)],
                                      stops: [0.0, 1.0],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      Text("18-3-1997",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12
                                        ),),

                                    ],
                                  ),
                                ),
                                Container(
                                  width: width/4,
                                  height: 26.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    gradient: LinearGradient(
                                      begin: Alignment(0.0, -1.0),
                                      end: Alignment(0.0, 1.0),
                                      colors: [const Color(0xff8c04ff), const Color(0xffbc5dff)],
                                      stops: [0.0, 1.0],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text("Status: Minimum",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10
                                      ),
                                    ),
                                  ),
                                ),
                              ],

                            ),

                            SizedBox(
                              height: height/90,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.date_range,size: 18,
                                      color: Color(0xff8C04FF),),
                                    Text(
                                      "Invite friends",
                                      style: TextStyle(
                                        fontSize: height / 48,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff8C04FF),),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),

                                Row(
                                  children: <Widget>[
                                    Icon(Icons.share,size: 18,
                                      color: Color(0xff8C04FF),),
                                    Text(
                                      "Share this Event",
                                      style: TextStyle(
                                        fontSize: height / 48,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff8C04FF),),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),

                                Row(
                                  children: <Widget>[
                                    Icon(Icons.people,size: 18,
                                      color: Color(0xff8C04FF),),
                                    Text(
                                      "4",
                                      style: TextStyle(
                                        fontSize: height / 48,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff8C04FF),),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height / 60,
                    ),





                    Container(
                      width: width/1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
//                            color: Colors.yellow,
                            width:width/5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage("images/user/pic1.jpeg"),
                                  radius: 28,
                                ),
                                SizedBox(
                                  height: height / 120,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 14,
                                    ),
                                    Text(
                                      "4.9",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
//                            color: Colors.yellow,
                            width:width/1.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text(
                                  "Syed Talha",
                                  style: TextStyle(
                                      fontSize: height / 42,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                ),
                                Text(
                                  "If an Instagram account is connected to the Page, they can respond to and delete comments. send Direct sync business contact info and create ads.",
                                  style: TextStyle(
                                      fontSize: height / 60,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black45),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 60,
                    ),


                    Container(
                      width: width/1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
//                            color: Colors.yellow,
                            width:width/5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage("images/user/pic1.jpeg"),
                                  radius: 28,
                                ),
                                SizedBox(
                                  height: height / 120,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 14,
                                    ),
                                    Text(
                                      "4.9",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
//                            color: Colors.yellow,
                            width:width/1.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text(
                                  "Syed Talha",
                                  style: TextStyle(
                                      fontSize: height / 42,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                ),
                                Text(
                                  "If an Instagram account is connected to the Page, they can respond to and delete comments. send Direct sync business contact info and create ads.",
                                  style: TextStyle(
                                      fontSize: height / 60,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black45),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 60,
                    ),


                    Container(
                      width: width/1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
//                            color: Colors.yellow,
                            width:width/5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage("images/user/pic1.jpeg"),
                                  radius: 28,
                                ),
                                SizedBox(
                                  height: height / 120,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 14,
                                    ),
                                    Text(
                                      "4.9",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
//                            color: Colors.yellow,
                            width:width/1.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text(
                                  "Syed Talha",
                                  style: TextStyle(
                                      fontSize: height / 42,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                ),
                                Text(
                                  "If an Instagram account is connected to the Page, they can respond to and delete comments. send Direct sync business contact info and create ads.",
                                  style: TextStyle(
                                      fontSize: height / 60,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black45),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 60,
                    ),






                    SizedBox(
                      height: height / 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

