import 'package:flutter/material.dart';

import 'user_book_event.dart';
import 'user_calendar.dart';
import 'user_eventPage.dart';
import 'user_friendProfile.dart';
import 'user_friends.dart';
import 'user_home.dart';
import 'user_notification.dart';
import 'user_profile.dart';
import 'user_requests.dart';
import 'user_review.dart';
import 'user_search.dart';

class user_navigation_bar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavigationBar();
  }
}
class NavigationBar extends State<user_navigation_bar>
{
  int _selectedTab = 0;
  final _pageOptions = [

    user_home(),
    user_search(),
    user_Calender(),
    user_notification(),
    user_profile(),

  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.grey),
          )),
      home: Scaffold(
        body: _pageOptions[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedTab,
          selectedItemColor: Color(0xff9847b7),
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,size: 28,),
              title: Text('Home',style: TextStyle(fontSize: height/60),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,size: 28),
              title: Text('Search',style: TextStyle(fontSize: height/60),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today,size: 28),
              title: Text('Calender',style: TextStyle(fontSize: height/60),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications,size: 28),
              title: Text('Notification',style: TextStyle(fontSize: height/60),),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,size: 28),
              title: Text('Profile',style: TextStyle(fontSize: height/60),),
            ),
          ],
        ),
      ),
    );
  }}