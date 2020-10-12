import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_users/User_Models/fitter_event_model.dart';
import 'package:fitter_users/User_Models/fiter_user_participants_model.dart';
import 'package:fitter_users/User_Models/fitter_user_model.dart';
import 'package:fitter_users/User_UI/card_event_vertical.dart';
import 'package:fitter_users/User_UI/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_editProfile.dart';
import 'user_friends.dart';


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

class Profile_State extends State<user_profile>
{
  FirebaseUser user;
  String name,url,email,hometown,area,worker_name, worker_url;
  SharedPreferences _pref;
  List<String> event_ids = List();
  List<Event> list_of_events = List();
  int worker = 22;
  int friends = 324;
  int followers = 681;

  bool events_load = false;
  Widget loading(double height)
  {
    if (!events_load)
    {
      return Center(
        child: Container(
          padding: EdgeInsets.only(top: height / 3),
          child: CircularProgressIndicator(
            strokeWidth: 5.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppUser.loadingfrontColor,
            ),
            backgroundColor: AppUser.loadingbackgroundColor,
          ),
        ),
      );
    }
    return SizedBox();
  }

  void Init() async
  {
    _pref = await SharedPreferences.getInstance();
    email = _pref.getString("email");
    name = _pref.getString("fullname");
    url = _pref.getString("photourl");
    hometown = _pref.getString("home_town");
    area = _pref.getString("area");
    worker = _pref.getInt("workers");
    friends = _pref.getInt("friends");
    followers = _pref.getInt("followers");
    setState(() {
    });
    ////////////////////////////////////////////////////////////////
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
    events_load = true;
    setState(() {});
  }

  @override
  void initState()
  {
    Init();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
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
        drawer: SideDrawer(downloadURL: url, name: name, height: height, width: width),
        backgroundColor: Color(0xffe3e1e1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                        url==null ?
                        CircleAvatar(
                          backgroundColor: Colors.white70,
                          backgroundImage:
                          AssetImage("images/user/pic1.JPG"),
                          radius: 30,
                        ) :
                        CircleAvatar(
                          backgroundColor: Colors.white70,
                          backgroundImage: NetworkImage(url),
                          radius: 30,
                        ),
                        Text(
                          name == null ? "Name" : name,
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
                          worker == null ? "0" : '${worker}',
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
                                builder: (context) => user_friends(email: email,)));
                      },
                      child: Column(
                        children: <Widget>[
                          Text(
                            friends == null ? "0" : '${friends}',
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
                          followers == null ? "0" : '${followers}',
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
                      area == null ? "I Love Myself" : area,
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
                      hometown == null ? "Pir Mahal,Toba tek Singh" : hometown,
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
              Stack(
                children: <Widget>[
                  Container(
                    color: Color(0xffe3e1e1),
                    height: height,
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
                  loading(height),
                ],
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



