import 'package:fitter_users/User_Models/fiter_user_participants_model.dart';
import 'package:flutter/material.dart';


class card_participants extends StatelessWidget {
  const card_participants({
    Key key,
    this.participant,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  final Participants participant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: height / 50,
        ),
        Container(
          width: width / 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: width / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    participant.photourl == null
                        ? CircleAvatar(
                      backgroundImage:
                      AssetImage("images/user/heart.png"),
                      radius: 32,
                    )
                        : CircleAvatar(
                      backgroundImage: NetworkImage(participant.photourl),
                      radius: 32,
                    ),
                    SizedBox(
                      height: height / 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        Text(
                          participant.rating == null
                              ? '0.0'
                              : '${participant.rating.toDouble()}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: width / 1.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      participant.name == null ? 'Bo Name' : participant.name,
                      style: TextStyle(
                          fontSize: height / 42,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                    ),
                    Text(
                      participant.desc == null ? 'Nothing' : participant.desc,
                      style: TextStyle(
                          fontSize: height / 60,
                          fontWeight: FontWeight.w400,
                          color: Colors.black45),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.black54,
        ),
      ],
    );
  }
}