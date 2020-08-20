import 'dart:core';
import 'package:fitter_users/User_UI/user_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class book_event extends StatefulWidget {
  @override
  book_eventState createState() => book_eventState();
}


class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class book_eventState extends State<book_event> {

  String location = 'Pir Mahal,Toba Tek Singh';
  String rating = '4.9';
  String dollar = '400';
  String time = '10:00AM to 11:00AM';
  String date = '18.1.2021';
  String status = 'Mininum';
  String people = '6';


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
//      appBar: AppBar(
//        iconTheme: IconThemeData(
//          color: Color(0xff9847b7), //change your color here
//        ),
//        title:  Text(
//          "Book Event",
//          style: TextStyle(
////            fontSize: 22,
//            color: Color(0xff9847b7),
////            fontWeight: FontWeight.bold,
//          ),
//        ),
//        centerTitle: true,
//        backgroundColor: Color(0xffe3e1e1),
//        elevation: 2,
//      ),
      backgroundColor: Color(0xffe3e1e1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(

                width: width,
                height: height/6,
                decoration: BoxDecoration(
                  color: Colors.black,
                    image: DecorationImage(
                        image: AssetImage("images/user/Events.jpg",),
                        fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.dstATop)
                    ),
//                    borderRadius: BorderRadius.circular(20)
                ),
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed:()
            {
              Navigator.pop(context);
            },
                          icon: Icon(Icons.arrow_back,color: Colors.white,),
                        ),
              SizedBox(width: width/5,),

              Text(
          "Book Event",
          style: TextStyle(
            fontSize: 26,
            color: Color(0xff9847b7),
            fontWeight: FontWeight.bold,
          ),
                textAlign: TextAlign.center,
          ),
                      ],
                    )

                  ],
                ),
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

//                      Text(
//                        "Lesson Details",
//                        style: TextStyle(
//                          fontSize: 26,
//                          color: Color(0xff9847b7),
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),

                  SizedBox(
                    height: height / 60,
                  ),


                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[

                       Padding(
                         padding: const EdgeInsets.only(top:50.0),
                         child: Container(
                           height: height/1.5,
                           width: width/1.1,
                           child: Card(
                            child: Container(

                              child: Padding(
                                padding: const EdgeInsets.only(top:38.0,bottom: 18,left: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                      mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[

                                    Text(
                                      "The Story behind the space X",
                                      style: TextStyle(
                                          fontSize: height / 36,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff4f4848)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),

                                    SizedBox(
                                      height: height/50,
                                    ),

                                    //description
                                    Text(
                                      "Description:",
                                      style: TextStyle(
                                        fontSize: height / 42,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff9847b7),),
                                      //textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      width: width/1.3,
                                      child:  Text(
                                        "If an Instagram account is connected to the Page, they can respond to and delete comments. send Direct sync business contact info and create ads.",
                                        style: TextStyle(
                                            fontSize: height / 60,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54),
                                        maxLines: 4,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        //textAlign: TextAlign.center,
                                      ),

                                    ),

                                    SizedBox(
                                      height: height/50,
                                    ),

                                    //location
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.location_on,size: 16,),
                                        SizedBox(width: width/30,),
                                        Text(
                                          "$location",
                                          style: TextStyle(
                                              fontSize: height / 52,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff4f4848)
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          //textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height/80,
                                    ),

                                    //time
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.access_time,
                                             color: Color(0xff4f4848),
                                          size: 16,
                                        ),
                                        SizedBox(width: width/30,),
                                        Text("$time",
                                          style: TextStyle(
                                             color: Color(0xff4f4848),
//                                                  fontWeight: FontWeight.w500,
                                              fontSize: 16
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height/80,
                                    ),

                                    //date
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
//                                              color: Colors.yellow,
                                          size: 16,
                                        ),
                                        SizedBox(width: width/30,),
                                        Text("$date",
                                          style: TextStyle(
                                         color: Color(0xff4f4848),
//                                                  fontWeight: FontWeight.w500,
                                              fontSize: 16
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height/80,
                                    ),

                                    //rating
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
//                                              color: Colors.yellow,
                                          size: 16,
                                        ),
                                        SizedBox(width: width/30,),
                                        Text(
                                          "$rating",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff4f4848)
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height/80,
                                    ),

                                    //dollar
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.attach_money,
//                                              color: Colors.yellow,
                                          size: 16,
                                        ),
                                        SizedBox(width: width/30,),
                                        Text("$dollar",
                                          style: TextStyle(
                                              color: Color(0xff4f4848),
//                                                  fontWeight: FontWeight.w500,
                                              fontSize: 16
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height/80,
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.people,
//                                              color: Colors.yellow,
                                          size: 16,
                                        ),
                                        SizedBox(width: width/30,),
                                        Text("$people",
                                          style: TextStyle(
                                             color: Color(0xff4f4848),
//                                                  fontWeight: FontWeight.w500,
                                              fontSize: 16
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height/80,
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.label_important,
//                                              color: Colors.yellow,
                                          size: 16,
                                        ),
                                        SizedBox(width: width/30,),
                                        Text("Status $status",
                                          style: TextStyle(
                                             color: Color(0xff4f4848),
//                                                  fontWeight: FontWeight.w500,
                                              fontSize: 16
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height/50,
                                    ),


                                    //participate
                                    Container(
                                      width: width/1.2,
                                      child: Text(
                                        "Participants:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff9847b7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height / 100,
                                    ),
                                    Container(
                                      width: width/1.2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage: AssetImage("images/admin/pic1.jpeg"),
                                            radius: 16,
                                          ),

                                          SizedBox(
                                            width: width / 90,
                                          ),
                                          CircleAvatar(
                                            backgroundImage: AssetImage("images/user/pic1.JPG"),
                                            radius: 16,
                                          ),


                                          SizedBox(
                                            width: width / 90,
                                          ),
                                          CircleAvatar(
                                            backgroundImage: AssetImage("images/admin/pic1.jpeg"),
                                            radius: 16,
                                          ),

                                          SizedBox(
                                            width: width / 90,
                                          ),
                                          CircleAvatar(
                                            backgroundImage: AssetImage("images/admin/pic1.jpeg"),
                                            radius: 16,
                                          ),

                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      height: height/60,
                                    ),


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.date_range,size: 18,
                                              color: Color(0xff9847b7),),
                                            Text(
                                              "Invite friends",
                                              style: TextStyle(
                                                fontSize: height / 48,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff9847b7),),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              //textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),

                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.share,size: 18,
                                              color: Color(0xff9847b7),),
                                            Text(
                                              "Share this Event",
                                              style: TextStyle(
                                                fontSize: height / 48,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff9847b7),),
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
                      ),
                         ),
                       ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration:
                        ShapeDecoration(shape: CircleBorder(), color: Colors.white,),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: DecoratedBox(
                            decoration: ShapeDecoration(
                                shape: CircleBorder(),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("images/admin/pic1.jpeg"),)),
                          ),
//                            child: CircleAvatar(
//                              backgroundImage: AssetImage("images/admin/pic1.jpeg"),
//                              radius: 32,
//                            ),
                        )
                      ),
                    ],

                  ),



                  SizedBox(
                    height: height / 60,
                  ),
                      Container(
                        width: width/1.3,
                        child: Text(
                          "Location:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff9847b7),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Image.asset("images/admin/map.png",
                        scale: 1,),






                  Center(
                    child: GestureDetector(
                      onTap: ()
                      {
                        return showDialog(context: context,
                          builder: (context){
                            return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                content: Container(

                                  height: height/9,
                                  child: Column(

                                    children: <Widget>[
                                      Text("Are You Sure?"),
                                      SizedBox(height: height/60,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: width/4,
                                            height: height/18,
                                            child: FlatButton(
                                              shape: new RoundedRectangleBorder(
                                                borderRadius: new BorderRadius.circular(20.0),
                                                //    side: BorderSide(color: Color(0xff2CBE77))
                                              ),
                                              color: Color(0xff9847b7),
                                              textColor: Colors.white,
                                              child: Text(
                                                "Yes",
                                                style: TextStyle(
                                                    fontSize: height / 50,
                                                    fontWeight: FontWeight.w500
                                                  //letterSpacing: 1
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (context) => user_navigation_bar()));
                                              },
                                            ),
                                          ),
                                          SizedBox(width: width/60,),
                                          ButtonTheme(
                                            minWidth: width/4,
                                            height: height/18,
                                            child: FlatButton(
                                              shape: new RoundedRectangleBorder(
                                                borderRadius: new BorderRadius.circular(20.0),
                                                //    side: BorderSide(color: Color(0xff2CBE77))
                                              ),
                                              color: Color(0xff9847b7),
                                              textColor: Colors.white,
                                              child: Text(
                                                "No",
                                                style: TextStyle(
                                                    fontSize: height / 50,
                                                    fontWeight: FontWeight.w500
                                                  //letterSpacing: 1
                                                ),
                                              ),
                                              onPressed: () {

                                                Navigator.pop(context);

//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => navigate()));
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )

                            );
                          },
                        );
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
                        child: Center(child: Text("Book Event",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),),
                      ),
                    ),
                  ),



                  SizedBox(
                    height: height / 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

