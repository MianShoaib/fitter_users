import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitter_users/User_Models/fitter_event_model.dart';
import 'package:fitter_users/User_UI/user_home.dart';
import 'package:fitter_users/User_UI/user_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class book_event extends StatefulWidget {
  final Event event;
  final booked;
  const book_event({Key key, this.booked, this.event}) : super(key: key);
  @override
  book_eventState createState() =>
      book_eventState(event: event, booked: booked);
}

class book_eventState extends State<book_event> {
  SharedPreferences _pref;
  book_eventState({this.event, this.booked});
  Event event;
  bool booked;
  String location = 'Pir Mahal,Toba Tek Singh';
  String rating = '4.9';
  String dollar = '400';
  String time = '10:00AM to 11:00AM';
  String date = '18.1.2021';
  String status = 'Mininum';
  String people = '6';

  void ShowToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple.shade300,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffe3e1e1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width,
                height: height / 6,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage(
                        "images/user/Events.jpg",
                      ),
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.dstATop)),
//                    borderRadius: BorderRadius.circular(20)
                ),
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: width / 5,
                        ),
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
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Container(
                          height: height / 1.5,
                          width: width / 1.1,
                          child: Card(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 38.0, bottom: 18, left: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                      mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      event.title,
                                      style: TextStyle(
                                          fontSize: height / 36,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff4f4848)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),

                                    SizedBox(
                                      height: height / 50,
                                    ),

                                    //description
                                    Text(
                                      "Description:",
                                      style: TextStyle(
                                        fontSize: height / 42,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff9847b7),
                                      ),
                                      //textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      width: width / 1.3,
                                      child: Text(
                                        event.note,
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
                                      height: height / 50,
                                    ),

                                    //location
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: width / 30,
                                        ),
                                        Text(
                                          "${event.location}",
                                          style: TextStyle(
                                              fontSize: height / 52,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff4f4848)),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          //textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height / 80,
                                    ),

                                    //time
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.access_time,
                                          color: Color(0xff4f4848),
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: width / 30,
                                        ),
                                        Text(
                                          '${event.time1.toString().split(" ")[1].substring(0, 5)} TO ${event.time2.toString().split(" ")[1].substring(0, 5)}',
                                          style: TextStyle(
                                              color: Color(0xff4f4848),
//                                                  fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height / 80,
                                    ),

                                    //date
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
//                                              color: Colors.yellow,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: width / 30,
                                        ),
                                        Text(
                                          "${event.start_date.toString().split(" ")[0]}",
                                          style: TextStyle(
                                              color: Color(0xff4f4848),
//                                                  fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height / 80,
                                    ),

                                    //rating
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
//                                              color: Colors.yellow,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: width / 30,
                                        ),
                                        Text(
                                          "$rating",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff4f4848)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height / 80,
                                    ),

                                    //dollar
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.attach_money,
//                                              color: Colors.yellow,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: width / 30,
                                        ),
                                        Text(
                                          "${event.user_price}",
                                          style: TextStyle(
                                              color: Color(0xff4f4848),
//                                                  fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height / 80,
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.people,
//                                              color: Colors.yellow,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: width / 30,
                                        ),
                                        Text(
                                          "${event.no_of_people}",
                                          style: TextStyle(
                                              color: Color(0xff4f4848),
//                                                  fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height / 80,
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.label_important,
//                                              color: Colors.yellow,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: width / 30,
                                        ),
                                        Text(
                                          "Status $status",
                                          style: TextStyle(
                                              color: Color(0xff4f4848),
//                                                  fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height / 50,
                                    ),

                                    //participate
                                    Container(
                                      width: width / 1.2,
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
                                    event.list_participants.length > 0
                                        ? Container(
                                            width: width / 1.2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: get_Participants(event),
                                            ),
                                          )
                                        : Container(
                                            child: Text("No Participant"),
                                          ),
                                    SizedBox(
                                      height: height / 60,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.date_range,
                                              size: 18,
                                              color: Color(0xff9847b7),
                                            ),
                                            Text(
                                              "Invite friends",
                                              style: TextStyle(
                                                fontSize: height / 48,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff9847b7),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              //textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.share,
                                              size: 18,
                                              color: Color(0xff9847b7),
                                            ),
                                            Text(
                                              "Share this Event",
                                              style: TextStyle(
                                                fontSize: height / 48,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff9847b7),
                                              ),
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
                          decoration: ShapeDecoration(
                            shape: CircleBorder(),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: DecoratedBox(
                              decoration: ShapeDecoration(
                                  shape: CircleBorder(),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(event.Worker_url),
                                  )),
                            ),
//                            child: CircleAvatar(
//                              backgroundImage: AssetImage("images/admin/pic1.jpeg"),
//                              radius: 32,
//                            ),
                          )),
                    ],
                  ),

                  SizedBox(
                    height: height / 60,
                  ),
                  Container(
                    width: width / 1.3,
                    child: Text(
                      "Location:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff9847b7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${event.location}',
                    style: TextStyle(
                      fontSize: height / 48,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff9847b7),
                    ),
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        return showDialog(
                          context: context,
                          builder: (context12) {
                            return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                content: Container(
                                  height: height / 9,
                                  child: Column(
                                    children: <Widget>[
                                      Text("Are You Sure?"),
                                      SizedBox(
                                        height: height / 60,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: width / 4,
                                            height: height / 18,
                                            child: FlatButton(
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0),
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
                                              onPressed: () async
                                              {
                                                bool booked = false;
                                                print("Book event");
                                                String name,
                                                    desc,
                                                    rating,
                                                    url,
                                                    email;
                                                _pref = await SharedPreferences
                                                    .getInstance();
                                                email =
                                                    _pref.getString("email");
                                                name =
                                                    _pref.getString("fullname");
                                                url =
                                                    _pref.getString("photourl");
                                                Firestore firestore =
                                                    Firestore.instance;
                                                CollectionReference
                                                    eventsreference =
                                                    await firestore
                                                        .collection("users")
                                                        .document(email)
                                                        .collection("Events");
                                                var docs = await eventsreference
                                                    .getDocuments();
                                                List<DocumentSnapshot>
                                                    event_docs = docs.documents;
                                                if (event_docs.length != null &&
                                                    event_docs.length != 0)
                                                {
                                                  for (var each in event_docs)
                                                  {
                                                    if (each.data["eventID"] == event.eventID1)
                                                    {
                                                      Navigator.pop(context12);
                                                      ShowToast(
                                                          "Event Already Booked.");
                                                      booked = true;
                                                      break;
                                                    }
                                                  }
                                                  if(!booked)
                                                  {
                                                    Navigator.pop(context12);
                                                    ShowToast(
                                                        "Booking the Event");
                                                    await firestore
                                                        .collection("Events")
                                                        .document(
                                                        event.eventID1)
                                                        .collection("Event")
                                                        .document(
                                                        event.eventID2)
                                                        .collection(
                                                        "participants")
                                                        .document()
                                                        .setData({
                                                      "name": name,
                                                      "desc": 'Hi There, I am Coming😎.',
                                                      "rating": rating,
                                                      "url": url,
                                                    });
                                                    await firestore
                                                        .collection("users")
                                                        .document(email)
                                                        .collection("Events")
                                                        .document()
                                                        .setData({
                                                      "worker" : event.worker,
                                                      "eventID":
                                                      event.eventID1
                                                    });
                                                    DocumentReference worker_noti_ref = await firestore.collection("workers").document(event.worker).collection("notifications").document();
                                                    worker_noti_ref.setData({
                                                      "desc": "Booked ${event.title}.",
                                                      "name": name,
                                                      "url": url,
                                                    });
                                                    ShowToast(
                                                        "Event Booked Successfully.");
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => user_navigation_bar()));
                                                  }
                                                }
                                                else
                                                  {
                                                    Navigator.pop(context12);
                                                  ShowToast(
                                                      "Booking the Event");
                                                    await firestore
                                                      .collection("Events")
                                                      .document(event.eventID1)
                                                      .collection("Event")
                                                      .document(event.eventID2)
                                                      .collection(
                                                          "participants")
                                                      .document()
                                                      .setData({
                                                    "name": name,
                                                    "desc": desc,
                                                    "rating": rating,
                                                    "url": url,
                                                  });
                                                    await firestore
                                                      .collection("users")
                                                      .document(email)
                                                      .collection("Events")
                                                      .document()
                                                      .setData({
                                                    "worker" : event.worker,
                                                    "eventID": event.eventID1
                                                  });
                                                    DocumentReference worker_noti_ref = await firestore.collection("workers").document(event.worker).collection("notifications").document();
                                                    worker_noti_ref.setData({
                                                      "desc": "Booked ${event.title}.",
                                                      "name": name,
                                                      "url": url,
                                                    });
                                                  ShowToast(
                                                      "Event Booked Successfully.");
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => user_navigation_bar()));
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 60,
                                          ),
                                          ButtonTheme(
                                            minWidth: width / 4,
                                            height: height / 18,
                                            child: FlatButton(
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        20.0),
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
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                      child: Container(
                        width: width / 1.2,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
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
                            "Book Event",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
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

  List<Widget> get_Participants(Event event) {
    List<Widget> list = List();
    for (var part in event.list_participants) {
      var image = CircleAvatar(
        backgroundImage: NetworkImage(part.photourl),
        radius: 16,
      );
      list.add(image);
    }
    return list;
  }
}
