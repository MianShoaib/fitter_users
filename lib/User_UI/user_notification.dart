import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitter_users/User_UI/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class user_notification extends StatefulWidget {
  @override
  notificationState createState() => notificationState();
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class notificationState extends State<user_notification>
{
  SharedPreferences _pref;
  String name,url,email;
  FirebaseUser user;
  DocumentSnapshot userdata;
  List<Requests> listdata = List();
  void Init() async
  {
    _pref = await SharedPreferences.getInstance();
    setState(() {
      name = _pref.getString("fullname");
      url = _pref.getString("photourl");
      email = _pref.getString("email");
    });

    Firestore firestore = Firestore.instance;
    QuerySnapshot user_events_documents = await firestore.collection("users").document(email).collection("Requests").getDocuments();
    List<DocumentSnapshot> user_events_docs = await user_events_documents.documents;
    for(var each in user_events_docs)
    {
      String status = each.data["status"];
      if(status == "0")
        {
          Requests request = new Requests(
            personname: each.data["name"],
            imageUrl: each.data["photourl"],
              email: each.data["email"]
          );
          listdata.add(request);
        }
        setState(() {});
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                height: height / 40,
              ),
              Container(
                width: width / 1,
                height: height / 1.2,
//                alignment: Alignment.b,
                decoration: BoxDecoration(
                  color: Color(0xffe3e1e1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),

                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: height / 20,
                    ),
                    Container(
//                      color: Color(0xffF5F5F5),
                      height: height / 1.3,
//                      width: width / 1,
                      child: ListView.builder(
                        itemCount: listdata.length,
                        itemBuilder: (context, index)
                        {
                          return Card(
                            color: Color(0xffefefef),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: ListTile(
                                onTap: (){
//                                  Navigator.push(context,
//                                      MaterialPageRoute(builder: (context) => request_detail()));
//                                  print("Hell");
                                },

                                leading: Container(
                                  //color: Colors.yellow,
                                  width: 50,
                                  height: 50,
                                  child: CircleAvatar(
                                    backgroundImage:
                                    listdata[index].imageUrl == null
                                        ? AssetImage('images/user/pic1.JPG')
                                    : NetworkImage(listdata[index].imageUrl),
                                    radius: 26,
                                  ),
                                ),
                                title: Text(
                                  listdata[index].personname,
                                  style: TextStyle(
                                      fontSize: height / 48,
                                      fontWeight: FontWeight.w500,
                                      color:  Color(0xff8C04FF),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                ),
                                trailing:  GestureDetector(
                                  onTap: ()
                                  {
//                                  Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => user_editProfile()));
                                  },
                                  child: Container(
                                    width: width/5,
                                    height: 26.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100.0),
                                      gradient: LinearGradient(
                                        begin: Alignment(0.0, -1.0),
                                        end: Alignment(0.0, 1.0),
                                        colors: [const Color(0xff8c04ff), const Color(0xffbc5dff)],
                                        stops: [0.0, 1.0],
                                      ),
                                    ),
                                    child: Center(child: Text("Accept",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12
                                      ),),),
                                  ),
                                ),

                              ),
                            ),
                          );
                        },
//
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Requests {
  String personname;
  String imageUrl;
  String email;

  Requests({
    this.personname,
    this.imageUrl,
    this.email,
  });
}
