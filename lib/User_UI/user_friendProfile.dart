
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'user_editProfile.dart';


class friend_profile extends StatefulWidget {
  @override
  Profile_State createState() => Profile_State();
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class Profile_State extends State<friend_profile> {

  int worker = 22;
  int friends = 324;
  int followers = 681;


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



