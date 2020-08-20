import 'package:fitter_users/User_UI/user_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user_book_event.dart';
import 'user_eventPage.dart';
import 'user_notification.dart';
import 'user_privacy_page.dart';
import 'user_purse.dart';
import 'user_serviceAgrement.dart';



class user_myEvent extends StatefulWidget {
  @override
  worker_homeState createState() => worker_homeState();
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class worker_homeState extends State<user_myEvent> {



  List Todaylistdata = [
    listItems(
      heading:"The Story behind the space X",
      personname: "Sohail khan",
      imageUrl: "images/admin/profile.png",
      price:"400",
      lesson: "Technology",
      time: "10:30 AM to 11:00 PM",
      address: "pir mahal TTS",
    ),

    listItems(
      heading:"The Story behind the space X",
      personname: "Ali Talib",
      imageUrl: "images/admin/pic1.jpeg",
      price:"600",
      lesson: "Technology",
      time: "11:30 AM to 12:00 PM",
      address: "Kashmiri",
    ),


  ];


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Events",
        style: TextStyle(
          color: Color(0xff9847b7),
        ),),
        iconTheme: IconThemeData(
          color: Color(0xff9847b7), //change your color here
        ),
        backgroundColor: Color(0xffe3e1e1),
        elevation: 2,

      ),

      backgroundColor: Color(0xffe3e1e1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: height/20,
            ),


            Container(
//              color: Colors.red,
              height: height/2.5,
//                      width: width / 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: Todaylistdata.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xffe3e1e1),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: ListTile(
                        onTap: (){
                      Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => book_event()));
                          print("Hell");
                        },



                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              //color: Colors.yellow,
                              width: width / 4.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                    AssetImage(Todaylistdata[index].imageUrl),
                                    radius: 26,
                                  ),
                                  Text(
                                    Todaylistdata[index].personname,
                                    style: TextStyle(
                                        fontSize: height / 50,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff413564)),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    ("\$")+Todaylistdata[index].price,
                                    style: TextStyle(
                                        fontSize: height / 50,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff413564)),
                                    textAlign: TextAlign.center,
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/60,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
//                                  color: Colors.black87,
                                  width: width/2.8,
                                  child: Text(
                                    Todaylistdata[index].heading,
                                    style: TextStyle(
                                        fontSize: height / 46,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff4f4848)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    //textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(
                                  height: height/90,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.bookmark_border,size: 14,),
                                    Text(
                                      Todaylistdata[index].lesson,
                                      style: TextStyle(
                                          fontSize: height / 56,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff4f4848)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height/90,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.access_time,size: 14,),
                                    Text(
                                      Todaylistdata[index].time,
                                      style: TextStyle(
                                          fontSize: height / 56,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff4f4848)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height/90,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.location_on,size: 14,),
                                    Text(
                                      Todaylistdata[index].address,
                                      style: TextStyle(
                                          fontSize: height / 56,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff4f4848)),
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
                        trailing: Padding(
                          padding: const EdgeInsets.only(bottom:8.0,right: 4),
                          child: Container(
//                              color: Colors.green,
                            width: width/7,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.label,size: 18,),
                                Text("Open",
                                    style: TextStyle(
                                        fontSize: height / 56,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4f4848)))
                              ],
                            ),
                          ),
                        ),

                      ),
                    ),
                  );
                },
//                        separatorBuilder: (context, index)
//                        {
//                          return Divider();
//                        },
              ),
            ),

            SizedBox(
              height: height/60,
            ),

            Container(
//              color: Colors.red,
              height: height/2.5,
//                      width: width / 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: Todaylistdata.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xffebebeb),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => user_review()));
                          print("Hell");
                        },



                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              //color: Colors.yellow,
                              width: width / 4.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                    AssetImage(Todaylistdata[index].imageUrl),
                                    radius: 26,
                                  ),
                                  Text(
                                    Todaylistdata[index].personname,
                                    style: TextStyle(
                                        fontSize: height / 50,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff413564)),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    ("\$")+Todaylistdata[index].price,
                                    style: TextStyle(
                                        fontSize: height / 50,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff413564)),
                                    textAlign: TextAlign.center,
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              width: width/60,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
//                                  color: Colors.black87,
                                  width: width/2.4,
                                  child: Text(
                                    Todaylistdata[index].heading,
                                    style: TextStyle(
                                        fontSize: height / 46,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff4f4848)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    //textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(
                                  height: height/90,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.bookmark_border,size: 14,),
                                    Text(
                                      Todaylistdata[index].lesson,
                                      style: TextStyle(
                                          fontSize: height / 54,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff4f4848)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height/90,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.access_time,size: 14,),
                                    Text(
                                      Todaylistdata[index].time,
                                      style: TextStyle(
                                          fontSize: height / 54,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff4f4848)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height/90,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.location_on,size: 14,),
                                    Text(
                                      Todaylistdata[index].address,
                                      style: TextStyle(
                                          fontSize: height / 54,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff4f4848)),
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
                        trailing: Container(
//                              color: Colors.green,
                          width: width/7,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.label,size: 18,),
                              Text("Open",
                                  style: TextStyle(
                                      fontSize: height / 56,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff4f4848)))
                            ],
                          ),
                        ),

                      ),
                    ),
                  );
                },
//                        separatorBuilder: (context, index)
//                        {
//                          return Divider();
//                        },
              ),
            ),


          ],
        ),
      ),
    );
  }
}

class listItems {

  String personname;
  String imageUrl;
  String lesson;
  String time;
  String address;
  String price;
  String heading;

  listItems({
    this.heading,
    this.personname,
    this.imageUrl,
    this.lesson,
    this.time,
    this.address,
    this.price
  });
}



