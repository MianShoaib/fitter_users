
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_users/User_Models/fiter_user_participants_model.dart';
import 'package:fitter_users/User_Models/fitter_event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class friend_profile extends StatefulWidget
{
  final String email;

  const friend_profile({Key key, this.email}) : super(key: key);
  @override
  Profile_State createState() => Profile_State(email);
}

class Profile_State extends State<friend_profile>
{
  int worker = 22;
  int friends = 324;
  int followers = 681;
  final String email;
  List listdata = [
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

  Profile_State(this.email);

  void Init(String mail) async
  {
    String mail,worker_name, worker_url;
    SharedPreferences _pref;
    List<String> event_ids = List();
    List<Event> list_of_events = List();
    ////////////////////////////////////////////////////////////////
    Firestore firestore = Firestore.instance;
    var collectionReference = firestore.collection("users").document(mail).collection("Events");
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff9847b7), //change your color here
        ),
        title:  Text(
          "Friend Profile",
          style: TextStyle(
//                fontSize: height / 42,
              fontWeight: FontWeight.w500,
              color: Color(0xff9847b7),),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          //textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Color(0xffe3e1e1),
        elevation: 2,
      ),
      backgroundColor: Color(0xffe3e1e1),
      body: SafeArea(
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
                      CircleAvatar(
                        backgroundImage:
                        AssetImage("images/admin/pic1.jpeg"),
                        radius: 42,
                      ),
                      Text(
                        "Luqman Asif",
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
                        "$worker",
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

                  Column(
                    children: <Widget>[
                      Text(
                        "$friends",
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

                  Column(
                    children: <Widget>[
                      Text(
                        "$followers",
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




            SizedBox(height: height/60,),

            GestureDetector(
              onTap: ()
              {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => user_editProfile()));
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
                child: Center(child: Text("Friend",
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
              width: width/1.3,
              child:  Text(
                "Engage with Events:",
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
                    color: Color(0xffefefef),
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
                                  width: width/2.6,
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
                          width: width/5.8,
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



