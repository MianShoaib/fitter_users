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
  List<String> list_of_friends = List();

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
    for (var each in user_requests_docs)
    {
      String status = each.data["status"];
      print(status);
      if (status == "1")
      {
        Friends request = new Friends(
            personname: each.data["name"],
            imageUrl: each.data["photourl"],
            email: each.data["email"]);
        friends_list.add(request);
        list_of_friends.add(request.personname);
      }
      friends_list = friends_list.toSet().toList();
      list_of_friends = list_of_friends.toSet().toList();
      print("friends_list");
      setState(() {});
    }
  }

  @override
  void initState() {
    Init();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
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
      body: friends_list.length != null || friends_list.length != 0
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
                          width: 290,
                          alignment: Alignment.center,
                          child: TextFormField(
                            onTap: ()
                            {
                              showSearch(
                                  context: context,
                                  delegate: Search(
                                      all_friends: friends_list,
                                      type: "friend",
                                      listExample: list_of_friends));
                            },
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          user_find_friends()));
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
                                            friend_profile(email: friends_list[index].email)));
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


class Search extends SearchDelegate
{
  final List<String> listExample;
  final List<Friends> all_friends;
  final String type;
  List<String> recentList = List();

  Search(
      {this.listExample,
        this.all_friends,
        this.type});
  String selectedResult = "";
  List<Friends> friends = List();

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context)
  {
    double height = MediaQuery.of(context).size.height;
    for (var each in all_friends) {
      if (each.personname == selectedResult)
      {
        print("Friend Matched");
        friends.add(each);
        friends = friends.toSet().toList();
        break;
      }
    }
    if (friends != null) {
      return Container(
//              color: Colors.red,
        height: height / 2,
//                      width: width / 1,
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: friends.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    image: friends[index].imageUrl == null
                        ? new AssetImage('images/user/pic1.JPG')
                        : new NetworkImage(friends[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                  new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    friends[index].personname,
                    style: TextStyle(
                        fontSize: height / 50,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff413564)),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    friends[index].email,
                    style: TextStyle(
                        fontSize: height / 60,
//                                fontWeight: FontWeight.bold,
                        color: Color(0xff4f4848)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    //textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        child: Center(
          child: Text("No Result"),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
          (element) => element.contains(query),
    ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: ()
          {
            selectedResult = suggestionList[index];
            recentList.add(selectedResult);
            showResults(context);
          },
        );
      },
    );
  }
}