import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitter_users/User_Models/fitter_event_model.dart';
import 'package:fitter_users/User_Models/fitter_participants_model.dart';
import 'package:fitter_users/User_UI/card_event_vertical.dart';
import 'package:fitter_users/User_UI/user_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class user_myEvent extends StatefulWidget {
  @override
  worker_homeState createState() => worker_homeState();
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class worker_homeState extends State<user_myEvent>
{
  List<Event> list_of_events = List();
  List<String> event_ids = List();
  SharedPreferences _pref;
  String email,worker_name, worker_url;
  Future Init() async
  {
    _pref = await SharedPreferences.getInstance();
    email = _pref.getString("email");
    Firestore firestore = Firestore.instance;
    var collectionReference = firestore.collection("users").document(email).collection("Events");
    QuerySnapshot eventIDdocs = await collectionReference.getDocuments();
    List<DocumentSnapshot> alleventdocs = eventIDdocs.documents;
    for (var each_doc in alleventdocs)
    {
      event_ids.add(each_doc.data["eventID"]);
    }
    for (String each in event_ids)
    {
      DocumentReference events = await firestore.collection("Events").document(each);
      events.get().then((value)
      {
        worker_name = value.data["name"];
        worker_url = value.data["photourl"];
      });
      CollectionReference events_collection = events.collection("Event");
      QuerySnapshot event_docs = await events_collection.getDocuments();
      List<DocumentSnapshot> all_event_doc = event_docs.documents;
      for (var each in all_event_doc)
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
          list_of_events.add(event);
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
  Widget build(BuildContext context)
  {
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
                itemCount: list_of_events.length,
                itemBuilder: (context, index)
                {
                  return Event_Card(
                    width: width,
                    height: height,
                    event: list_of_events[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



