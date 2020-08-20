import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'user_book_event.dart';
import 'drawer.dart';

class user_Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<user_Calender> {
  FirebaseUser user;
  DocumentSnapshot userdata;
  var _downloadURL;
  CalendarController _controller;

  @override
  void initState() {
    Init();
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }

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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[


            SizedBox(
              height: height / 40,
            ),

            TableCalendar(
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(

                  todayColor: Color(0xff9847b7),
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Color(0xffe3e1e1),
                  )),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Color(0xff9847b7),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Color(0xffe3e1e1),),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) {
                print(date.toIso8601String());
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xff9847b7),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xff9847b7),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "Today Activites",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff9847b7),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Spanish Town Hotel",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "july 10,2017",
                        style: TextStyle(fontSize: 12, color: Colors.black26),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(4.0),
                          topRight: const Radius.circular(4.0),
                          bottomLeft: const Radius.circular(4.0),
                          bottomRight: const Radius.circular(4.0)),
                      color: Color(0xff9847b7),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: Text(
                        "15:00",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
//                    onPressed: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => AdminLogin()));
//                    },
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  ButtonTheme(
                    minWidth: 50.0,
                    height: 30.0,
                    child: RaisedButton(
                      color: Colors.black12,
                      child: Column(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => book_event()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff9847b7),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Taco\'s with Daniel",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "july 12,2017",
                        style: TextStyle(fontSize: 12, color: Colors.black26),
                      )
                    ],
                  ),
                  Divider(
                    height: 2,
                    color: Colors.black12,
                  ),
                  SizedBox(
                    width: 82,
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(4.0),
                          topRight: const Radius.circular(4.0),
                          bottomLeft: const Radius.circular(4.0),
                          bottomRight: const Radius.circular(4.0)),
                      color: Color(0xff9847b7),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: Text(
                        "15:00",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
//                    onPressed: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => AdminLogin()));
//                    },
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  ButtonTheme(
                    minWidth: 50.0,
                    height: 30.0,
                    child: RaisedButton(
                      color: Colors.black12,
                      child: Column(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => book_event()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
