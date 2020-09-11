import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitter_users/User_Models/fitter_event_model.dart';
import 'package:fitter_users/User_Models/fitter_participants_model.dart';
import 'package:fitter_users/User_UI/card_event_horizontal.dart';
import 'package:fitter_users/User_UI/card_event_vertical.dart';
import 'package:fitter_users/User_UI/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences _pref;
  String name, url;
  List<Event> list_of_events = List();
  List<Event> all_events = List();
  Future Init() async
  {
    DateTime today_Date = DateTime.now();
    String todays_Date = today_Date.toString().split(" ")[0];
    print(todays_Date);
    _pref = await SharedPreferences.getInstance();
    setState(() {
      name = _pref.getString("fullname");
      url = _pref.getString("photourl");
    });

    Firestore firestore = Firestore.instance;
    var collectionReference = firestore.collection("Events");
    QuerySnapshot totalDocuments = await collectionReference.getDocuments();
    print(totalDocuments);
    List<DocumentSnapshot> alldocuments = totalDocuments.documents;
    print(alldocuments);
    for (var each_doc in alldocuments)
    {
      String worker_name, worker_url;
      worker_name = each_doc.data["name"];
      worker_url = each_doc.data["photourl"];
      QuerySnapshot total =
          await each_doc.reference.collection("Event").getDocuments();
      List<DocumentSnapshot> all = total.documents;
      for (var each in all)
      {
        List<Participants> all_participants = List();
        QuerySnapshot participant_query =
            await each.reference.collection("participants").getDocuments();
        List<DocumentSnapshot> all_part = participant_query.documents;
        for (var each_part in all_part)
        {
          Participants participant = new Participants(
            name: each_part.data["name"],
            rating: each_part.data["rating"],
            photourl: each_part.data["url"],
            desc: each_part.data["desc"],
          );
          all_participants.add(participant);
        }
        Event event = new Event(
          eventID1: each_doc.documentID,
          eventID2: each.documentID,
          Worker_name: worker_name,
          Worker_url: worker_url,
          end_date: each.data["end_date"].toDate(),
          note: each.data["note"],
          no_of_people: each.data["no_of_people"],
          title: each.data["title"],
          type: each.data["type"],
          duration: each.data["duration"],
          time1: each.data["time1"].toDate(),
          time2: each.data["time2"].toDate(),
          user_price: each.data["user_price"],
          repeat: each.data["repeat"],
          location: each.data["location"],
          worker: each.data["worker"],
          start_date: each.data["start_date"].toDate(),
          status: each.data["status"],
          list_participants: all_participants,
        );
        setState(()
        {
          var get_date = each.data["start_date"].toDate().toString().split(" ")[0];
          if (todays_Date == get_date)
          {
            list_of_events.add(event);
            all_events.add(event);
          } else {
            all_events.add(event);
          }
        });
      }
    }
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
      drawer: SideDrawer(
          downloadURL: url, name: name, height: height, width: width),
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
                        itemCount: list_of_events.length,
                        itemBuilder: (context, index)
                        {
                          return Event_Card(
                            width: width,
                            height: height,
                            event: list_of_events[index],
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
                          itemCount: all_events.length,
                          shrinkWrap: false,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return card_event_horizontal(width: width, height: height,event: all_events[index]);
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