import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitter_users/User_Models/fitter_friend_model.dart';
import 'package:fitter_users/User_Models/fitter_user_model.dart';
import 'package:fitter_users/User_UI/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class user_find_friends extends StatefulWidget {
  @override
  user_findfriends createState() => user_findfriends();
}

class user_findfriends extends State<user_find_friends> {
  SharedPreferences _pref;
  String name, url, email;
  FirebaseUser user;
  DocumentSnapshot userdata;
  List<Friends> listdata = List();
  List<String> already = List();
  List<String> requests = List();
  void Init() async
  {
    _pref = await SharedPreferences.getInstance();
    setState(() {
      name = _pref.getString("fullname");
      url = _pref.getString("photourl");
      email = _pref.getString("email");
    });
    getFriends();
  }

  void ShowToast(String message)
  {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple.shade300,
        textColor: Colors.white);
  }

  Future getFriends() async
  {
    Firestore firestore = Firestore.instance;
    ///////////////      ALREADY FRIENDS     ///////////////////////
    QuerySnapshot user_friends_documents = await firestore
        .collection("users")
        .document(email)
        .collection("Friends")
        .getDocuments();
    List<DocumentSnapshot> user_friends_docs =
        await user_friends_documents.documents;
    for (var each in user_friends_docs)
    {
      already.add(each.data["email"]);
    }
    QuerySnapshot user_requests_documents = await firestore
        .collection("users")
        .document(email)
        .collection("Requests")
        .getDocuments();
    List<DocumentSnapshot> user_requests_docs =
        await user_requests_documents.documents;
    for (var each in user_requests_docs) {
      requests.add(each.data["email"]);
    }
    /////////////////////// REMAINING ///////////////////////////////

    QuerySnapshot user_events_documents =
        await firestore.collection("users").getDocuments();
    List<DocumentSnapshot> user_events_docs =
        await user_events_documents.documents;
    for (var each in user_events_docs) {
      if (email == each.data["email"]) {
        continue;
      } else {
        if (already.contains(each.data["email"])) {
          print("already");
          continue;
        } else if (requests.contains(each.data["email"])) {
          print("in request");
          continue;
        } else {
          Friends request = new Friends(
            status: "Send Request",
              personname: each.data["fullname"],
              imageUrl: each.data["photourl"],
              email: each.data["email"]);
          listdata.add(request);
        }
      }
      setState(() {});
    }
  }

  Future sendRequest(String request_mail) async
  {
    Firestore firestore = Firestore.instance;
    await firestore
        .collection("users")
        .document(request_mail)
        .collection("Requests")
        .document().setData({
      "name" : name,
      "status" : "0",
      "email" : email,
      "photourl" : url,
    });
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
        elevation: 0,
      ),
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
                        itemBuilder: (context, index) {
                          return Card(
                            color: Color(0xffefefef),
                            elevation: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: ListTile(
                                onTap: () {
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
                                            : NetworkImage(
                                                listdata[index].imageUrl),
                                    radius: 26,
                                  ),
                                ),
                                title: Text(
                                  listdata[index].personname,
                                  style: TextStyle(
                                    fontSize: height / 48,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff8C04FF),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  //textAlign: TextAlign.center,
                                ),
                                trailing: GestureDetector(
                                  onTap: () async
                                  {
                                    print("Send Request");
                                    if(listdata[index].status == "Send Request")
                                      {
                                        sendRequest(listdata[index].email);
                                        listdata[index].status = "Request Sent";
                                        setState(() {});
                                      }
                                    else
                                      {
                                        ShowToast("Request Already Sent.");
                                      }
                                  },
                                  child: Container(
                                    width: width / 3,
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      gradient: LinearGradient(
                                        begin: Alignment(0.0, -1.0),
                                        end: Alignment(0.0, 1.0),
                                        colors: [
                                          const Color(0xff8c04ff),
                                          const Color(0xffbc5dff)
                                        ],
                                        stops: [0.0, 1.0],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${listdata[index].status}',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
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
