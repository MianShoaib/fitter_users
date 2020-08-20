
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class User_privacy_page extends StatefulWidget {
  @override
  service_agreState createState() => service_agreState();
}

class service_agreState extends State<User_privacy_page> {

  @override
  Widget build(BuildContext context) {

    String Service_Text1 ="If an Instagram account is connected to the Page, they"
        "can respond to and delete comments. send Direct sync"
        "business contact info and create ads.";
    String Service_Text2 ="If an Instagram account is connected to the Page, they"
        "can respond to and delete comments. send Direct sync"
        "business contact info and create ads.If an Instagram ac"
        "count is connected to the Page, they can respond to and"
        "delete comments. send Direct sync business contact info"
        "and create ads.";



    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffe3e1e1),

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff9847b7), //change your color here
        ),
        title: Text(
          "Privacy Page",
          style: TextStyle(
            fontSize: 22,
            color:Color(0xff9847b7),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffe3e1e1),
        elevation: 2,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: height/20,
              ),



              Container(
                width: width/1.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      "Details:",
                      style: TextStyle(
                          fontSize: height / 42,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff9847b7),),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height/90,
                    ),
                    Text(
                      "$Service_Text1",
                      style: TextStyle(
                          fontSize: height / 58,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          letterSpacing: 1
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "$Service_Text2",
                      style: TextStyle(
                          fontSize: height / 58,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          letterSpacing: 1
                      ),
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
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
