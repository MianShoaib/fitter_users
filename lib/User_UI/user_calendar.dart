import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitter_users/User_Models/fitter_event_model.dart';
import 'package:fitter_users/User_Models/fiter_user_participants_model.dart';
import 'package:fitter_users/User_UI/user_eventPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'user_book_event.dart';
import 'drawer.dart';

class user_Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<user_Calender> {
  String selected;
  SharedPreferences _pref;
  String name,
      url = "";
  String worker_name, worker_url, email;
  CalendarController calendarController = CalendarController();
  Map<DateTime, List<dynamic>> calendar_events;
  List<Event> list_of_events = List();
  List<dynamic> show_events = List();
  List<String> event_ids = List();

  Future Init() async
  {
    calendar_events = {};
    _pref = await SharedPreferences.getInstance();
    setState(() {
      name = _pref.getString("fullname");
      url = _pref.getString("photourl");
    });
    email = _pref.getString("email");
    Firestore firestore = Firestore.instance;
    var collectionReference = firestore.collection("users")
        .document(email)
        .collection("Events");
    QuerySnapshot eventIDdocs = await collectionReference.getDocuments();
    List<DocumentSnapshot> alleventdocs = eventIDdocs.documents;
    for (var each_doc in alleventdocs) {
      event_ids.add(each_doc.data["eventID"]);
    }
    for (String each in event_ids) {
      DocumentReference events = await firestore.collection("Events").document(
          each);
      events.get().then((value) {
        worker_name = value.data["name"];
        worker_url = value.data["photourl"];
      });
      CollectionReference events_collection = events.collection("Event");
      QuerySnapshot event_docs = await events_collection.getDocuments();
      List<DocumentSnapshot> all_event_doc = event_docs.documents;
      for (var each in all_event_doc) {
        List<Participants> all_participants = List();
        QuerySnapshot participant_query =
        await each.reference.collection("participants").getDocuments();
        List<DocumentSnapshot> all_part = participant_query.documents;
        for (var each_part in all_part) {
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
        setState(() {
          list_of_events.add(event);
        });
        List<Event> all_event = List();
        all_event.add(event);
        DateTime dt_start = DateTime.utc(
            event.start_date.year, event.start_date.month,
            event.start_date.day);
        DateTime dt_end = DateTime.utc(
            event.end_date.year, event.end_date.month, event.end_date.day);
        print(event.repeat);
        if (event.repeat == "Daily")
        {
          int d1 = dt_start.day;
          int d2 = dt_end.day;
          if (d1 != d2) {
            if (calendar_events[dt_start] != null) {
              int len = calendar_events[dt_start].length;
              calendar_events[dt_start].insert(len, event);
            }
            else {
              calendar_events[dt_start] = all_event;
            }
            if (calendar_events[dt_end] != null) {
              int len = calendar_events[dt_end].length;
              calendar_events[dt_end].insert(len, event);
            }
            else {
              calendar_events[dt_end] = all_event;
            }
          }
        } else {
          print("DT---- > " + dt_start.toString());
          if (calendar_events[dt_start] != null) {
            int len = calendar_events[dt_start].length;
            calendar_events[dt_start].insert(len, event);
          } else {
            calendar_events[dt_start] = all_event;
          }
        }
        setState(() {});
        print(calendar_events);
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
      double width = MediaQuery
          .of(context)
          .size
          .width;
      double height = MediaQuery
          .of(context)
          .size
          .height;

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: height / 40,
              ),
              TableCalendar(
                calendarController: calendarController,
                events: calendar_events,
                initialCalendarFormat: CalendarFormat.week,
                calendarStyle: CalendarStyle(
                    todayColor: Color(0xff9847b7),
                    selectedColor: Theme
                        .of(context)
                        .primaryColor,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white)),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Color(0xff9847b7),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events) {
                  selected = date.toString().split(" ")[0];
                  show_events = events;
                  setState(() {});

                  print(events.toString());
                },
                builders: CalendarBuilders(
                  markersBuilder: (context, date, events, holidays) {
                    final children = <Widget>[];
                    if (events.isNotEmpty) {
                      children.add(
                        Positioned(
                          right: 1,
                          bottom: 1,
                          child: _buildEventsMarker(date, events),
                        ),
                      );
                    }
                    return children;
                  },
                  selectedDayBuilder: (context, date, events) {
                    selected = date.toString().split(" ")[0];
                    return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: date.day == DateTime
                                .now()
                                .day
                                ? Color(0xff9847b7)
                                : Colors.red[200],
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        ));
                  },
                  todayDayBuilder: (context, date, events) =>
                      Container(
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
                //calendarController: _controller,
              ),
              ...show_events.map((event) {
                String start = event.start_date.toString().split(" ")[0],
                    end = event.end_date.toString().split(" ")[0];
                return Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      start == selected
                          ? end == selected
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            event.title,
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${event.start_date.toString().split(" ")[0]}',
                            style: TextStyle(
                                fontSize: 12, color: Colors.black26),
                          )
                        ],
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Starting of ' + event.title,
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${start}  TO  ${end}',
                            style: TextStyle(
                                fontSize: 12, color: Colors.black26),
                          )
                        ],
                      )
                          : end == selected
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ending of ' + event.title,
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${start}  TO  ${end}',
                            style: TextStyle(
                                fontSize: 12, color: Colors.black26),
                          )
                        ],
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            event.title,
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${start}',
                            style: TextStyle(
                                fontSize: 12, color: Colors.black26),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 70,
                      ),
//                     Container(
//                       decoration: new BoxDecoration(
//                         borderRadius: new BorderRadius.only(
//                             topLeft: const Radius.circular(4.0),
//                             topRight: const Radius.circular(4.0),
//                             bottomLeft: const Radius.circular(4.0),
//                             bottomRight: const Radius.circular(4.0)),
//                         color: Colors.purple,
//                       ),
//
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                           top: 5.0,
//                           bottom: 5.0,
//                           left: 10.0,
//                           right: 10.0,
//                         ),
//                         child: Text(
//                           '${event.time1.toString().split(" ")[1].substring(0, 5)}',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
// //                    onPressed: () {
// //                      Navigator.push(context,
// //                          MaterialPageRoute(builder: (context) => AdminLogin()));
// //                    },
//                     ),
                      SizedBox(
                        width: 3,
                      ),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 30.0,
                        child: RaisedButton(
                          color: Colors.purple,
                          child: Row(
                            // Replace with a Row for horizontal icon + text
                            children: <Widget>[
                              Text(
                                  '${event.time1.toString().split(" ")[1]
                                      .substring(0, 5)}',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25,
                                  )
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        user_event(
                                          event: event,
                                          participant: event.list_participants,
                                        )));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      );
    }

    Widget _buildEventsMarker(DateTime date, List events) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: calendarController.isSelected(date)
              ? Colors.purple[300]
              : calendarController.isToday(date)
              ? Colors.purple[300]
              : Colors.blue[400],
        ),
        width: 16.0,
        height: 16.0,
        child: Center(
          child: Text(
            '${events.length}',
            style: TextStyle().copyWith(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }
}