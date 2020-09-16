import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_users/User_Models/fitter_friend_model.dart';
import 'package:fitter_users/User_UI/user_findfriends.dart';
import 'package:fitter_users/User_UI/user_friendProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class user_friends extends StatefulWidget {
  final String email;

  const user_friends({Key key, this.email}) : super(key: key);
  @override
  worker_followerState createState() => worker_followerState(email);
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class worker_followerState extends State<user_friends> {
  final String email;
  Firestore firestore;
  List<Friends> friends_list = List();

  worker_followerState(this.email);

  Init() async {
    print("Getting Friends");
    firestore = Firestore.instance;
    QuerySnapshot user_requests_documents = await firestore
        .collection("users")
        .document(email)
        .collection("Friends")
        .getDocuments();
    List<DocumentSnapshot> user_requests_docs =
        await user_requests_documents.documents;
    for (var each in user_requests_docs) {
      String status = each.data["status"];
      if (status == "1") {
        Friends request = new Friends(
            personname: each.data["name"],
            imageUrl: each.data["photourl"],
            email: each.data["email"]);
        friends_list.add(request);
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
        iconTheme: IconThemeData(
          color: Color(0xff9847b7), //change your color here
        ),
        title: Text(
          "Friends",
          style: TextStyle(
            fontSize: 28,
            color: Color(0xff9847b7),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffe3e1e1),
        elevation: 2,
      ),
      backgroundColor: Color(0xffe3e1e1),
      body: friends_list.length == null
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: height / 60,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 300,
                          alignment: Alignment.center,
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(0xfff6f6f6),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              // border: InputBorder.none,
                              hintText: "Search",
                              hintStyle: (TextStyle(color: Colors.grey)),
                              contentPadding: const EdgeInsets.only(
                                left: 16,
                                right: 20,
                                top: 5,
                                bottom: 5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width / 50,
                        ),
                        Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.purple[400],
                            ),
                            onPressed: ()
                            {
                              print("Find Friends");
                            },
                            iconSize: height / 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 60,
                    ),
                    SizedBox(
                      height: height / 60,
                    ),
                    Container(
//                      color: Color(0xffF5F5F5),
                      height: height / 1.9,
//                      width: width / 1,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: friends_list.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            friend_profile()));
                                print("Hell");
                              },
                              leading: Container(
                                //color: Colors.yellow,
                                width: 50,
                                height: 50,
                                child: CircleAvatar(
                                  backgroundImage: friends_list[index]
                                              .imageUrl ==
                                          null
                                      ? new AssetImage('images/user/pic1.JPG')
                                      : new NetworkImage(
                                          friends_list[index].imageUrl),
                                  radius: 26,
                                ),
                              ),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    friends_list[index].personname,
                                    style: TextStyle(
                                      fontSize: height / 42,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff8C04FF),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    //textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Friends List Empty",
                      style: TextStyle(
                          fontSize: height / 38,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9847b7)),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: width / 50,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(
                            "Click to add new Friends",
                            style: TextStyle(
                                fontSize: height / 38,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff9847b7)),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            //textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: width / 50,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.purple[400],
                            ),
                            onPressed: ()
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          user_find_friends()));
                            },
                            iconSize: height / 20,
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

class listItems {
  String personname;
  String imageUrl;

  listItems({
    this.personname,
    this.imageUrl,
  });
}
