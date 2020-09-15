import 'package:fitter_users/User_Models/fitter_event_model.dart';
import 'package:fitter_users/User_Models/fitter_participants_model.dart';
import 'package:fitter_users/User_UI/user_book_event.dart';
import 'package:fitter_users/User_UI/user_eventPage.dart';
import 'package:flutter/material.dart';

class Event_Card extends StatelessWidget
{
  final Event event;
  const Event_Card({
    Key key,
    @required this.width,
    this.event,
    @required this.height,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context)
  {
    return Card(
      color: Color(0xffebe9e6),
      elevation: 1,
      child: Padding(
        padding:
        const EdgeInsets.only(top: 10, bottom: 10),
        child: ListTile(
          onTap: ()
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => user_event(event: event, participant: event.list_participants,)));
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                //color: Colors.yellow,
                width: width / 4.4,
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: <Widget>[
                    event.Worker_url == null ?
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          'images/user/pic1.JPG'),
                      radius: 26,
                    )
                        :
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          event.Worker_url),
                      radius: 26,
                    ),
                    event.Worker_name == null ?
                    Text(
                      'Invalid User',
                      style: TextStyle(
                          fontSize: height / 50,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff413564)),
                      textAlign: TextAlign.center,
                    )
                    :
                    Text(
                      event.Worker_name,
                      style: TextStyle(
                          fontSize: height / 50,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff413564)),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: height / 120,
                    ),
                    Container(
                      width: width / 7.6,
                      height: 26.0,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(100.0),
                        gradient: LinearGradient(
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 1.0),
                          colors: [
                            const Color(0xff9847b7),
                            const Color(0xffbc5dff)
                          ],
                          stops: [0.0, 1.0],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "\$" +
                              event.user_price,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width / 60,
              ),
              Column(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
//                                  color: Colors.black87,
                    width: width / 2.8,
                    child: Text(
                      event.title,
                      style: TextStyle(
                          fontSize: height / 46,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4f4848)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: height / 90,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.bookmark_border,
                        size: 14,
                      ),
                      Text(
                        event.type,
                        style: TextStyle(
                            fontSize: height / 56,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4f4848)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        //textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 90,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 14,
                      ),
                      Text(
                          '${event.time1.toString().split(" ")[1].substring(0, 5)} TO ${event.time2.toString().split(" ")[1].substring(0, 5)}',
                        style: TextStyle(
                            fontSize: height / 56,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4f4848)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        //textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 90,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 14,
                      ),
                      Text(
                        event.location,
                        style: TextStyle(
                            fontSize: height / 56,
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
          trailing: Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Container(
              width: width / 7,
              height: 28.0,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius:
                BorderRadius.circular(100.0),
                gradient: LinearGradient(
                  begin: Alignment(0.0, -1.0),
                  end: Alignment(0.0, 1.0),
                  colors: [
                    const Color(0xff9847b7),
                    const Color(0xffbc5dff)
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Center(
                child: Text(
                  "Open",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}