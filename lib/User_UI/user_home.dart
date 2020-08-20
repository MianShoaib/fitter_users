import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitter_users/User_UI/drawer.dart';
import 'package:fitter_users/User_UI/user_editProfile.dart';
import 'package:fitter_users/User_UI/user_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_book_event.dart';
import 'user_myEvent.dart';
import 'user_privacy_page.dart';
import 'user_purse.dart';
import 'user_serviceAgrement.dart';

class user_home extends StatefulWidget {
  @override
  worker_homeState createState() => worker_homeState();
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class worker_homeState extends State<user_home>
{
  FirebaseUser user;
  DocumentSnapshot userdata;
  var _downloadURL;
  List Todaylistdata = [
    listItems(
      heading: "The Story behind the space X",
      personname: "Sohail khan",
      imageUrl: "images/user/pic1.JPG",
      price: "400",
      lesson: "Technology",
      time: "10:30 AM to 11:00 PM",
      address: "pir mahal TTS",
    ),
    listItems(
      heading: "The Story behind the space X",
      personname: "Ali Talib",
      imageUrl: "images/user/pic1.JPG",
      price: "600",
      lesson: "Technology",
      time: "11:30 AM to 12:00 PM",
      address: "Kashmiri",
    ),
    listItems(
      heading: "The Story behind the space X",
      personname: "Luqman",
      imageUrl: "images/user/pic1.JPG",
      price: "600",
      lesson: "Technology",
      time: "11:30 AM to 12:00 PM",
      address: "Kashmiri",
    ),
  ];

  List Tomorrowlistdata = [
    listItems(
      heading: "The Story behind the space X",
      personname: "Talha khan",
      imageUrl: "images/user/pic1.JPG",
      price: "400",
      lesson: "Technology",
      time: "10:30 AM to 11:00 PM",
      address: "pir mahal TTS",
    ),
    listItems(
      heading: "The Story behind the space X",
      personname: "Ali Talib",
      imageUrl: "images/user/pic1.JPG",
      price: "600",
      lesson: "Technology",
      time: "11:30 AM to 12:00 PM",
      address: "Kashmiri",
    ),
    listItems(
      heading: "The Story behind the space X",
      personname: "Luqman",
      imageUrl: "images/user/pic1.JPG",
      price: "600",
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

  void getData() async
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
  void initState()
  {
    Init();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "images/splash_logo.png",
          scale: 10,
        ),
        iconTheme: IconThemeData(
          color: Color(0xff9847b7), //change your color here
        ),
        backgroundColor: Color(0xffe3e1e1),
        elevation: 2,
      ),
      drawer: SideDrawer(downloadURL: _downloadURL, userdata: userdata, height: height, width: width),
      backgroundColor: Color(0xffe3e1e1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: height / 60,
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: width / 1.4,
                      child: Text(
                        "Today",
                        style: TextStyle(
                            fontSize: height / 38,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff9847b7)),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        //textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
//              color: Colors.red,
                      height: height / 1.7,
//                      width: width / 1,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: Todaylistdata.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Color(0xffebe9e6),
                            elevation: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => book_event()));
                                  print("Hell");
                                },
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      //color: Colors.yellow,
                                      width: width / 4.4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage: AssetImage(
                                                Todaylistdata[index].imageUrl),
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
                                          SizedBox(
                                            height: height / 120,
                                          ),
                                          Container(
                                            width: width / 7.6,
                                            height: 26.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
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
                                                "\$" +
                                                    Todaylistdata[index].price,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 60,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
//                                  color: Colors.black87,
                                          width: width / 2.8,
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
                                          height: height / 90,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.bookmark_border,
                                              size: 14,
                                            ),
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
                                          height: height / 90,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                            ),
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
                                          height: height / 90,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              size: 14,
                                            ),
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
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: Container(
                                    width: width / 7,
                                    height: 28.0,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(100.0),
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
                                        "Open",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
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
                      height: height / 60,
                    ),
                    Container(
//                color: Colors.redAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: ListView.builder(
                          itemCount: Tomorrowlistdata.length,
                          shrinkWrap: false,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Color(0xffebe9e6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: width / 4.4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
//                                        crossAxisAslignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundImage: AssetImage(
                                              Tomorrowlistdata[index].imageUrl),
                                          radius: 26,
                                        ),
                                        Text(
                                          Tomorrowlistdata[index].personname,
                                          style: TextStyle(
                                              fontSize: height / 54,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff413564)),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: height / 120,
                                        ),
                                        Container(
                                          width: width / 7.6,
                                          height: 26.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100.0),
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
                                              "\$" +
                                                  Tomorrowlistdata[index].price,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
//                                  color: Colors.black87,
                                        width: width / 2.4,
                                        child: Text(
                                          Tomorrowlistdata[index].heading,
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
                                        height: height / 90,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.bookmark_border,
                                            size: 14,
                                          ),
                                          Text(
                                            Tomorrowlistdata[index].lesson,
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
                                        height: height / 90,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 14,
                                          ),
                                          Text(
                                            Tomorrowlistdata[index].time,
                                            style: TextStyle(
                                                fontSize: height / 58,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff4f4848)),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            //textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height / 90,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 14,
                                          ),
                                          Text(
                                            Tomorrowlistdata[index].address,
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
                            );
                          }),
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

class listItems {
  String personname;
  String imageUrl;
  String lesson;
  String time;
  String address;
  String price;
  String heading;

  listItems(
      {this.heading,
      this.personname,
      this.imageUrl,
      this.lesson,
      this.time,
      this.address,
      this.price});
}
