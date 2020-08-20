import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class user_requests extends StatefulWidget {
  @override
  worker_followerState createState() => worker_followerState();
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class worker_followerState extends State<user_requests> {

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
    return SafeArea(
      child: Scaffold(
//        appBar: AppBar(
//          iconTheme: IconThemeData(
//            color: Color(0xff8C04FF), //change your color here
//          ),
//          backgroundColor: Colors.white,
//          elevation: 0,
//        ),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(0.0),
                      bottomLeft: const Radius.circular(40.0),
                      bottomRight: const Radius.circular(40.0),
                      topRight: const Radius.circular(0.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff8c04ff).withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                ),
                //color: Colors.white,
                height: height / 8,
                width: width / 1,
                child: Image(
                  image: AssetImage("images/splash_logo.png"),
                )

//                  Image.asset("images/splash_logo.png",
//                  )
            ),
            SizedBox(
              height: height / 40,
            ),
            Container(
              width: width / 1,
              height: height / 1.36,
//                alignment: Alignment.b,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
//              boxShadow: [
//                BoxShadow(
//                  color:Color(0xff8C04FF).withOpacity(0.9),
//                  spreadRadius: 0,
//                  blurRadius: 1,
//                  offset: Offset(0, 15), // changes position of shadow
//                ),
//              ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: height / 50,
                  ),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xff8C04FF),
                      fontWeight: FontWeight.bold,
                    ),
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

                            trailing:    GestureDetector(
                              onTap: ()
                              {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => worker_SignUp_Step2()));
                              },
                              child: Container(
                                width: width/5,
                                height: 30.0,
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
