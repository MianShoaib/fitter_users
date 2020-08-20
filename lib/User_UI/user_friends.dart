
import 'package:fitter_users/User_UI/user_friendProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class user_friends extends StatefulWidget {
  @override
  worker_followerState createState() => worker_followerState();
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class worker_followerState extends State<user_friends> {

  List listdata = [
    listItems(
      personname: "Sohail khan",
      imageUrl: "images/admin/profile.png",
    ),

    listItems(
      personname: "Ali Talib",
      imageUrl: "images/admin/pic1.jpeg",

    ),


    listItems(
      personname: "Talha khan",
      imageUrl: "images/admin/pic2.jpg",
    ),

    listItems(
      personname: "Rehan khan",
      imageUrl: "images/admin/pic2.jpg",
    ),

    listItems(
      personname: "Luqman Asif",
      imageUrl: "images/admin/pic1.jpeg",
    ),

  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff9847b7),//change your color here
        ),
        title:  Text(
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[


              SizedBox(
                height: height / 60,
              ),
              Container(
                height: 50,
                width: 300,
                alignment: Alignment.center,
                child: TextFormField(
                  cursorColor: Colors.grey,

//                controller: controller,
//                focusNode: focusNode,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,

                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                        color: Color(0xfff6f6f6),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
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
                  itemCount: listdata.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10),
                      child: ListTile(
                        onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => friend_profile()));
                            print("Hell");
                        },

                        leading: Container(
                          //color: Colors.yellow,
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                            backgroundImage:
                            AssetImage(listdata[index].imageUrl),
                            radius: 26,
                          ),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              listdata[index].personname,
                              style: TextStyle(
                                fontSize: height / 42,
                                fontWeight: FontWeight.w500,
                                color:  Color(0xff8C04FF),
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
//
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
