import 'package:fitter_users/User_Models/fitter_event_model.dart';
import 'package:fitter_users/User_Models/fiter_user_participants_model.dart';
import 'package:fitter_users/User_UI/card_user_participants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class user_event extends StatefulWidget {
  final Event event;
  final List<Participants> participant;
  const user_event({Key key, this.event, this.participant}) : super(key: key);
  @override
  worker_eventState createState() => worker_eventState(event, participant);
}

class worker_eventState extends State<user_event> {
  final Event event;
  String rating = '4.9';
  String status = 'Mininum';
  final List<Participants> participant;
  worker_eventState(this.event, this.participant);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff8C04FF), //change your color here
        ),
        title: Text(
          "Event Details",
          style: TextStyle(
//            fontSize: 28,
            color: Color(0xff8C04FF),
//            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: height / 40,
            ),
            Container(
              width: width / 1,
              height: height / 1.38,
//                alignment: Alignment.b,
              decoration: BoxDecoration(
                //color: Color(0xffF5F5F5),
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
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

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: height / 20,
                    ),
                    Card(
                      color: Colors.purple[200],
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 18),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: width / 1.1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    event.title,
                                    style: TextStyle(
                                        fontSize: height / 38,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4f4848)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    //textAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    onTap: () {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => admin_login()));
                                    },
                                    child: Container(
                                      width: width / 6,
                                      height: 26.0,
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.bookmark_border,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Open",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 90,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    size: 18,
                                  ),
                                  Text(
                                    "${event.location}",
                                    style: TextStyle(
                                        fontSize: height / 48,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4f4848)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    //textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 90,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: width / 7.6,
                                  height: 26.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
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
                                      "\$${event.user_price}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width / 3,
                                  height: 26.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    gradient: LinearGradient(
                                      begin: Alignment(0.0, -1.0),
                                      end: Alignment(0.0, 1.0),
                                      colors: [
                                        const Color(0xff12C053),
                                        const Color(0xff109043)
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        '${event.time1.toString().split(" ")[1].substring(0, 5)} TO ${event.time2.toString().split(" ")[1].substring(0, 5)}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width / 4.4,
                                  height: 26.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    gradient: LinearGradient(
                                      begin: Alignment(0.0, -1.0),
                                      end: Alignment(0.0, 1.0),
                                      colors: [
                                        const Color(0xffC2C911),
                                        const Color(0xffBCA017)
                                      ],
                                      stops: [0.0, 1.0],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        '${event.start_date.toString().split(" ")[0]}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width / 4,
                                  height: 26.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
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
                                      "Status: Minimum",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 90,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      size: 18,
                                      color: Color(0xff8C04FF),
                                    ),
                                    Text(
                                      "Invite friends",
                                      style: TextStyle(
                                        fontSize: height / 48,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff8C04FF),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.share,
                                      size: 18,
                                      color: Color(0xff8C04FF),
                                    ),
                                    Text(
                                      "Share this Event",
                                      style: TextStyle(
                                        fontSize: height / 48,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff8C04FF),
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.people,
                                      size: 18,
                                      color: Color(0xff8C04FF),
                                    ),
                                    Text(
                                      '${event.list_participants.length}',
                                      style: TextStyle(
                                        fontSize: height / 48,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff8C04FF),
                                      ),
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
                      ),
                    ),
                    SizedBox(
                      height: height / 60,
                    ),
                    Container(
                      height: height / 30,
//                      width: width / 1,
                      child: Text(
                        'Participants',
                        style: TextStyle(
                          fontSize: height / 38,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4f4848),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 60,
                    ),
                    Container(
                      color: Colors.purple[50],
                      height: height / ((8 / participant.length) - 1),
//                      width: width / 1,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: participant.length,
                        itemBuilder: (context, int position) {
                          return card_participants(
                              width: width,
                              participant: participant[position],
                              height: height);
                        },
                      ),
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
