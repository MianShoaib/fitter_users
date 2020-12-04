import 'package:fitter_users/User_Models/fitter_event_model.dart';
import 'package:fitter_users/User_UI/user_book_event.dart';
import 'package:flutter/material.dart';

class card_event_horizontal extends StatelessWidget {
  const card_event_horizontal({
    Key key,
    this.event,
    @required this.width,
    @required this.height,
  }) : super(key: key);
  final Event event;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffebe9e6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width / 4.4,
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
//                                        crossAxisAslignment: CrossAxisAlignment.center,
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
                        fontSize: height / 54,
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

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: <Widget>[
                Container(
//                                  color: Colors.black87,
                  width: width / 2.4,
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
                  height: height / 90,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 14,
                    ),
                    Text(
                      '${event.time1.toString().split(" ")[1].substring(0,5)} TO ${event.time2.toString().split(" ")[1].substring(0,5)}',
                      style: TextStyle(
                          fontSize: height / 58,
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ButtonTheme(
                minWidth: 18,
                height: 26,
                child: RaisedButton(
                  onPressed: ()
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => book_event(event: event)));
                  },
                  color: Color(0xff9847b7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xffbc5dff))
                  ),
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
          ],
        ),
      ),
    );
  }
}