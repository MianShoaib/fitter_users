
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitter_users/User_UI/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user_editProfile.dart';
import 'user_friends.dart';
import 'user_login.dart';
import 'user_myEvent.dart';
import 'user_notification.dart';
import 'user_privacy_page.dart';
import 'user_purse.dart';
import 'user_serviceAgrement.dart';


class user_profile extends StatefulWidget
{
  @override
  Profile_State createState() => Profile_State();
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class Profile_State extends State<user_profile> {
  FirebaseUser user;
  DocumentSnapshot userdata;
  var _downloadURL;
  int worker = 22;
  int friends = 324;
  int followers = 681;

  List listdata = [
    listItems(
      heading:"The Story behind the space X",
      personname: "Sohail khan",
      imageUrl: "images/user/pic1.JPG",
      price:"400",
      lesson: "Technology",
      time: "10:30 AM to 11:00 PM",
      address: "pir mahal TTS",
    ),

    listItems(
      heading:"The Story behind the space X",
      personname: "Ali Talib",
      imageUrl: "images/user/pic1.JPG",
      price:"600",
      lesson: "Technology",
      time: "11:30 AM to 12:00 PM",
      address: "Kashmiri",
    ),
  ];

  Future downloadImage() async
  {
    String downloadAddress = await FirebaseStorage.instance.ref().child(userdata["photourl"]).getDownloadURL();
    print(downloadAddress);
    setState(() {
      _downloadURL = downloadAddress;
    });
  }

  Future getData() async
  {
    user = await FirebaseAuth.instance.currentUser();
    Firestore firestore = Firestore.instance;
    await firestore.collection("users").document(user.email)
        .get()
        .then((doc) {
      if (doc.exists) {
        userdata = doc;
      }
      else {
        // doc.data() will be undefined in this case
        print("No such document!");
      }
    });
  }

  void Init() async
  {
    await getData();
    await downloadImage();
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Image.asset("images/splash_logo.png",
            scale: 10,),
          iconTheme: IconThemeData(
            color: Color(0xff9847b7), //change your color here
          ),
          backgroundColor: Color(0xffe3e1e1),
          elevation: 0,

        ),
        drawer: SideDrawer(downloadURL: _downloadURL, userdata: userdata, height: height, width: width),
        backgroundColor: Color(0xffe3e1e1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              Container(
//                  decoration: new BoxDecoration(
//                    color: Color(0xffe3e1e1),
//                    borderRadius: new BorderRadius.only(
//                        topLeft: const Radius.circular(0.0),
//                        bottomLeft: const Radius.circular(40.0),
//                        bottomRight: const Radius.circular(40.0),
//                        topRight: const Radius.circular(0.0)),
//                    boxShadow: [
//                      BoxShadow(
//                          color: Color(0xff9847b7).withOpacity(0.2),
//                          spreadRadius: 3.0,
//                          blurRadius: 5.0)
//                    ],
//                  ),
//                  //color: Colors.white,
//                  height: height / 8,
//                  width: width / 1,
//                  child: Image.asset("images/splash_logo.png",
//                  scale: 8,),
//
////                  Image.asset("images/splash_logo.png",
////                  )
//              ),
              SizedBox(
                height: height / 40,
              ),



              Container(
                width: width/1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Column(
                      children: <Widget>[
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
                        Text(
                          userdata == null ? "Name" : userdata["fullname"],
                          style: TextStyle(
                              fontSize: height / 42,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9847b7),),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.center,
                        ),
                      ],
                    ),


                    Column(
                      children: <Widget>[
                        Text(
                          userdata == null ? "$worker" : userdata["workers"].toString(),
                          style: TextStyle(
                            fontSize: height / 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),

                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.center,
                        ),
                        Text(
                          "Workers",
                          style: TextStyle(
                            fontSize: height / 48,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => user_friends()));
                      },
                      child: Column(
                        children: <Widget>[
                          Text(
                            userdata == null ? "$friends" : userdata["friends"].toString(),
                            style: TextStyle(
                              fontSize: height / 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),

                            overflow: TextOverflow.ellipsis,
                            //textAlign: TextAlign.center,
                          ),
                          Text(
                            "Friends",
                            style: TextStyle(
                              fontSize: height / 48,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            //textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: <Widget>[
                        Text(
                          userdata == null ? "$followers" : userdata["followers"].toString(),
                          style: TextStyle(
                            fontSize: height / 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),

                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.center,
                        ),
                        Text(
                          "Followers",
                          style: TextStyle(
                            fontSize: height / 48,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                  ],
                ),
              ),


              Divider(
                color: Colors.grey,
//                thickness: 1,
              ),

              SizedBox(height: height/60,),

              GestureDetector(
                onTap: ()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => user_editProfile()));
                },
                child: Container(
                  width: width/1.2,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    gradient: LinearGradient(
                      begin: Alignment(0.0, -1.0),
                      end: Alignment(0.0, 1.0),
                      colors: [const Color(0xff9847b7), const Color(0xffbc5dff)],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: Center(child: Text("Edit",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),),),
                ),
              ),

              SizedBox(height: height/60,),

              Divider(
                color: Colors.grey,
              ),



              SizedBox(
                height: height/60,
              ),
              Container(
                width: width/1.4,
                child:  Row(
                  children: <Widget>[
                    Text(
                      "Areas: ",
                      style: TextStyle(
                          fontSize: height / 38,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9847b7),),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                    ),


                    Text(
                      userdata == null ? "I Love Myself" : userdata["area"],
                      style: TextStyle(
                          fontSize: height / 42,
                          fontWeight: FontWeight.w800,
                          color: Colors.black54),
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
              Divider(
                color: Colors.grey,
              ),

              Container(
                width: width/1.2,
                color: Color(0xffe3e1e1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Icon(
                      Icons.location_on,
                      size: 20,
                    ),
                    SizedBox(width: width/60,),
                    Text(
                      userdata == null ? "Pir Mahal,Toba tek Singh" : userdata["home_town"],
                      style: TextStyle(
                          fontSize: height / 42,
                          fontWeight: FontWeight.w800,
                          color: Colors.black54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                    ),

                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),

//                  SizedBox(
//                    height: height/60,
//                  ),

              Divider(
                color: Colors.grey,
              ),



              SizedBox(
                height: height/60,
              ),
              Container(
                width: width/1.4,
                child:  Text(
                  "Event Board:",
                  style: TextStyle(
                      fontSize: height / 38,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff9847b7),),
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  //textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height/90,
              ),


              Container(
                color: Color(0xffe3e1e1),
                height: height/2,
//                      width: width / 1,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: listdata.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Color(0xffebebeb),
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 10),
                        child: ListTile(
                          onTap: (){
//                              Navigator.push(context,
//                                            MaterialPageRoute(builder: (context) => navigate_User()));
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
                                      AssetImage(listdata[index].imageUrl),
                                      radius: 26,
                                    ),
                                    Text(
                                      listdata[index].personname,
                                      style: TextStyle(
                                          fontSize: height / 50,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff413564)),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      ("\$")+listdata[index].price,
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
//                                    color: Colors.red,
                                    width: width/2.4,
                                    child: Text(
                                      listdata[index].heading,
                                      style: TextStyle(
                                          fontSize: height / 42,
                                          fontWeight: FontWeight.w500,
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
                                        listdata[index].lesson,
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
                                        listdata[index].time,
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
                                        listdata[index].address,
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
                            width: width/6,
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



