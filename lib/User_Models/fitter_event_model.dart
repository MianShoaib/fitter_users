import 'package:fitter_users/User_Models/fitter_participants_model.dart';

class Event
{
  final String worker,
      eventID1,
      eventID2,
      repeat,
      title,
      type,
      location,
      duration,
      status,
      user_price,
      no_of_people,
      Worker_name,
      Worker_url,
      note;
  final DateTime time1,
      time2,
      start_date,
      end_date;
  final weekdays;
  final int no_of_weeks;

  final List<Participants> list_participants;

  Event({this.eventID2,this.eventID1,this.Worker_name,this.Worker_url,this.list_participants,this.no_of_weeks,this.weekdays,this.worker, this.time2, this.time1, this.start_date,this.end_date, this.title, this.type, this.location, this.duration, this.repeat, this.user_price, this.no_of_people, this.status, this.note});

}