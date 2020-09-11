import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

class user_search extends StatefulWidget
{
  @override
  user_reviewState createState() => user_reviewState();
}

class user_reviewState extends State<user_search>
{
  FirebaseUser user;
  String name, url;
  var _downloadURL;
  final controller = PageController();
  String time;
  SharedPreferences _pref;

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  var usertype = "1";
  DropdownButton userTpe() => DropdownButton<String>(
    icon: Icon(Icons.arrow_drop_down_circle,size: 18,),
    items: [
      DropdownMenuItem<String>(
        value: "1",
        child: Text(
          "Worker",
        ),
      ),
      DropdownMenuItem<String>(
        value: "2",
        child: Text(
          "User",
        ),
      ),
    ],
    onChanged: (value) {
      setState(() {
        usertype = value;
        print(usertype);

      });
    },
    value: usertype,
  );


  TabBar tabBarlabel() => TabBar(
        tabs: <Widget>[
          Tab(
            text: "Lesson",
          ),
          Tab(
            text: "Worker",
          ),
          Tab(
            text: "Friends",
          ),
        ],

    labelColor: Color(0xff9847b7),
//    labelPadding: EdgeInsets.symmetric(vertical: 6),
    labelStyle: TextStyle(fontSize: 20),
    indicatorColor: Color(0xff9847b7),
    unselectedLabelColor: Color(0xff9847b7),
    unselectedLabelStyle: TextStyle(fontSize: 14),
    onTap: (index)
    {
      var content = "";
      switch(index){
        case 0:
          content = "Home";
          break;
          case 1:
          content = "Home";
          break;
          case 2:
          content = "Home";
          break;
      }
      print("$content");
    }
      );

  void Init() async
  {
    _pref = await SharedPreferences.getInstance();
    setState(() {
      name = _pref.getString("fullname");
      url = _pref.getString("photourl");
    });
  }

  @override
  void initState() {
    Init();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Image.asset("images/splash_logo.png",
            scale: 10,),
          iconTheme: IconThemeData(
            color: Color(0xff9847b7), //change your color here
          ),
          backgroundColor: Color(0xffe3e1e1),
          elevation: 0,

        ),
        drawer: SideDrawer(downloadURL: url, name: name, height: height, width: width),
        backgroundColor: Color(0xffe3e1e1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              Container(
//                  decoration: new BoxDecoration(
//                    color: Color(0xffe3e1e1),
//                    borderRadius: new BorderRadius.only(
//                        topLeft: const Radius.circular(0.0),
//                        bottomLeft: const Radius.circular(40.0),
//                        bottomRight: const Radius.circular(40.0),
//                        topRight: const Radius.circular(0.0)),
//                    boxShadow: [
//                      BoxShadow(
//                          color: Color(0xff9847b7).withOpacity(0.2),
//                          spreadRadius: 3.0,
//                          blurRadius: 5.0)
//                    ],
//                  ),
//                  //color: Colors.white,
//                  height: height / 8,
//                  width: width / 1,
//                  child: Image.asset("images/splash_logo.png",
//                  scale: 8,),
////                  )
//                  ),
              SizedBox(
                height: height/60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 280,
                    alignment: Alignment.center,
                    child: TextFormField(
                      cursorColor: Colors.grey,

//                controller: controller,
//                focusNode: focusNode,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffebe9e6),

                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Color(0xffebe9e6),
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
                  IconButton(
                    onPressed: ()
                    {
                      return showDialog(context: context,
                        builder: (context){
                          List<bool> isSelected = [true, false, false];
                          List<FocusNode> focusToggle;
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              content: Container(

                                height: height/1.2,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                  mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[


                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "Filter",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22.0,
                                            fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(width: width/6,),
                                          IconButton(
                                            onPressed: ()
                                            {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.close,
                                            color: Colors.black,
                                            size: 22,),
                                          )
                                        ],
                                      ),

                                      SizedBox(
                                        height: height/40,
                                      ),


                                      Text(
                                        "Select Time",
                                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left:18.0,top:2),
                                        child: Container(
                                          width: width/1.2,
                                          height: height/20,
                                          child: CupertinoTheme(
                                            data: CupertinoThemeData(
                                                barBackgroundColor: Colors.white,
                                                textTheme: CupertinoTextThemeData(
                                                    dateTimePickerTextStyle:
                                                    TextStyle(color: Colors.grey))),
                                            child: CupertinoDatePicker(
                                              backgroundColor: Colors.transparent,
                                              mode: CupertinoDatePickerMode.time,
                                              use24hFormat: false,
                                              onDateTimeChanged: (asleep) {
                                                time = asleep.toString();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(

                                        margin:
                                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                                        child: TextField(
                                          decoration: InputDecoration(
//                      border: InputBorder.,
                                            hintText: 'Select Location',
                                            hintStyle: TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: height/40,
                                      ),

                                      Text(
                                        "Select Date",
                                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        height: height/60,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:16.0),
                                        child: GestureDetector(
                                          onTap: (){
                                            _selectDate(context);
                                          },
                                          child: Text(
                                            "${selectedDate.toLocal()}".split(' ')[0],
                                            style: TextStyle(
                                              fontSize: height/40,
//                  decoration: TextDecoration.underline
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: width/1.2,
                                          child: Divider(
                                            thickness: 1,

                                          ),
                                        ),
                                      ),



                                      SizedBox(
                                        height: height/60,
                                      ),

                                      Text(
                                        "Type of Lesson",
                                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        height: height/90,
                                      ),
                                      Center(
                                        child: Container(
                                          width: width/1.14,
                                          height: height/18,
                                          decoration: BoxDecoration(
                                            color: Color(0xff),
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(0.5),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),




//                        color: Colors.yellow,
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:20.0,right: 18),
                                              child: userTpe(),
                                            ),
                                          ),
                                        ),
                                      ),


                                      SizedBox(
                                        height: height/40,
                                      ),
                                      Text(
                                        "Select Price Range",
                                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                                      ),
                                      Center(
                                        child: Container(
                                          width: width/1.1,
                                          child: SliderTheme(

                                            data: SliderTheme.of(context).copyWith(
                                              overlayColor: Color(0xff9847b7),
                                              activeTickMarkColor: Color(0xff9847b7),
                                              thumbColor:  Color(0xff9847b7),
                                              activeTrackColor:  Color(0xff9847b7),

                                            ),
                                            child: frs.RangeSlider(
                                              min: 0.0,
                                              max: 100.0,
                                              lowerValue: _lowerValue,
                                              upperValue: _upperValue,
                                              divisions: 100,
                                              showValueIndicator: true,
                                              valueIndicatorMaxDecimals: 1,
                                              onChanged: (double newLowerValue, double newUpperValue) {
                                                setState(() {
                                                  _lowerValue = newLowerValue;
                                                  _upperValue = newUpperValue;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: width/1.2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                  "Min: $_lowerValue"
                                              ),
                                              Text(
                                                  "Max: $_upperValue"
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height/40,
                                      ),
                                      Text(
                                        "Participants",
                                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                                      ),
                                      Center(
                                        child: Container(
                                          width: width/1.1,
                                          child: SliderTheme(

                                            data: SliderTheme.of(context).copyWith(
                                              overlayColor: Color(0xff9847b7),
                                              activeTickMarkColor: Color(0xff9847b7),
                                              thumbColor:  Color(0xff9847b7),
                                              activeTrackColor:  Color(0xff9847b7),

                                            ),
                                            child: frs.RangeSlider(
                                              min: 0.0,
                                              max: 100.0,
                                              lowerValue: _lowerValue,
                                              upperValue: _upperValue,
                                              divisions: 100,
                                              showValueIndicator: true,
                                              valueIndicatorMaxDecimals: 1,
                                              onChanged: (double newLowerValue, double newUpperValue) {
                                                setState(() {
                                                  _lowerValue = newLowerValue;
                                                  _upperValue = newUpperValue;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: width/1.2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                  "Min: $_lowerValue"
                                              ),
                                              Text(
                                                  "Max: $_upperValue"
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: height/40,),
                                      Container(
                                        height: height/20,
//                                        width: width/1,
                                        child: Center(
                                          child: ToggleButtons(

                                            color: Color(0xff9847b7),
                                            selectedColor: Colors.white,
                                            selectedBorderColor: Color(0xff9847b7),
                                            fillColor: Color(0xff9847b7),
                                            splashColor: Colors.lightBlue,
                                            highlightColor: Colors.lightBlue,
//                                            borderColor: Color(0xffefefef),
                                            borderWidth: 4,
                                            renderBorder: true,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                bottomRight: Radius.circular(25)),
                                            disabledColor: Colors.blueGrey,
                                            disabledBorderColor: Colors.blueGrey,
                                            focusColor: Colors.red,
                                            focusNodes: focusToggle,
                                            children: <Widget>[
                                              Text("All"),
                                              Text("Reset"),
                                              Text("Apply"),
                                            ],
                                            isSelected: isSelected,
                                            onPressed: (int index) {
                                              setState(() {
                                                isSelected[index] = !isSelected[index];
                                              });
                                            },
                                          ),
                                        ),
                                      ),



                                    ],
                                  ),
                                ),
                              )

                          );
                        },
                      );

                    },
                    icon: Icon(Icons.tune,
                      color: Color(0xff9847b7),),
                  ),
                ],
              ),


              Container(
                height: height/1.36,
                width: width/1,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: tabBarlabel(),
                      ),
                      Expanded(
                        child: Container(
                          child: TabBarView(
                            children: <Widget>[
                              Container(
//                              color: Colors.red,
                                child: lesson_container(),
                              ),
                              Container(
                                child: worker_conatiner(),
                              ),
                              Container(
                                child: friends_conatiner(),
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height / 40,
              ),
            ],
          ),
        ),
      ),
    );
  }


  double _lowerValue = 20.0;
  double _upperValue = 80.0;
  double _lowerValueFormatter = 20.0;
  double _upperValueFormatter = 20.0;

  List lesson = [
    lessonlistItems(
      description:"The Story behind the space X",
      title: "Sohail khan",
      imageUrl: "images/user/pic1.JPG",
    ),

    lessonlistItems(
      description:"The Story behind the space X",
      title: "Ali Talib",
      imageUrl: "images/user/pic1.JPG",
    ),
    lessonlistItems(
      description:"The Story behind the space X",
      title: "Luqman",
      imageUrl: "images/user/pic1.JPG",
    ),
    lessonlistItems(
      description:"The Story behind the space X",
      title: "Talha",
      imageUrl: "images/user/pic1.JPG",
    ),

  ];

  Widget lesson_container()
  {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return SingleChildScrollView(
      child: Container(
//              color: Colors.red,
        height: height/2,
//                      width: width / 1,
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: lesson.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: (){
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => book_event()));
                print("Hell");
              },



              leading:Container(
                width: 50,
                height: 50,
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    image: new  AssetImage(lesson[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.blue,
////                       minRadius: 25,
////                       maxRadius: 26,
//                         backgroundImage:
//                         AssetImage(workersyoulove[index].imageUrl),
//                         radius: 24,
//                       ),
                ),
              ),

              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(
                    lesson[index].title,
                    style: TextStyle(
                        fontSize: height / 50,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff413564)),
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    lesson[index].description,
                    style: TextStyle(
                        fontSize: height / 60,
//                                fontWeight: FontWeight.bold,
                        color: Color(0xff4f4848)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    //textAlign: TextAlign.center,
                  ),
                ],
              ),



            );
          },
//                        separatorBuilder: (context, index)
//                        {
//                          return Divider();
//                        },
        ),
      ),
    );
  }

  Map<String, bool> values = {
    'Worker You Loved': false,
    'Worker High Rated': false,
    'Worker recommended for you': false,
  };



  List workersyoulove = [
    listItems(
      description:"The Story behind the space X",
      title: "Sohail khan",
      imageUrl: "images/user/pic1.JPG",
    ),

    listItems(
      description:"The Story behind the space X",
      title: "Ali Talib",
      imageUrl: "images/user/pic1.JPG",
    ),

  ];

  List recommendedforyou = [
    recomendlistItems(
      description:"The Story behind the space X",
      title: "Sohail khan",
      imageUrl: "images/user/pic1.JPG",
    ),

    recomendlistItems(
      description:"The Story behind the space X",
      title: "Ali Talib",
      imageUrl: "images/user/pic1.JPG",
    ),

  ];

  List highrated = [
    highratedlistItems(
      description:"The Story behind the space X",
      title: "Sohail khan",
      imageUrl: "images/user/pic1.JPG",
    ),

    highratedlistItems(
      description:"The Story behind the space X",
      title: "Ali Talib",
      imageUrl: "images/user/pic1.JPG",
    ),
  highratedlistItems(
      description:"The Story behind the space X",
      title: "Luqman",
      imageUrl: "images/user/pic1.JPG",
    ),

  ];





  Widget worker_conatiner()
  {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
//      color: Colors.pinkAccent,
//      height: height/1.1,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[


            Padding(
              padding: const EdgeInsets.only(left:10.0,top: 8),
              child: Text(
                "Workers You Loved",
                style: TextStyle(
                    fontSize: height / 38,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff9847b7)),
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                //textAlign: TextAlign.center,
              ),
            ),
            Container(
//              color: Colors.red,
              height: height/6,
//                      width: width / 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: workersyoulove.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => book_event()));
                      print("Hell");
                    },



                     leading:Container(
                       width: 50,
                     height: 50,
                     decoration: new BoxDecoration(
                     color: const Color(0xff7c94b6),
                     image: new DecorationImage(
                     image: new  AssetImage(workersyoulove[index].imageUrl),
                     fit: BoxFit.cover,
                     ),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                  color: Colors.blue,
                  width: 2.0,
                  ),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.blue,
////                       minRadius: 25,
////                       maxRadius: 26,
//                         backgroundImage:
//                         AssetImage(workersyoulove[index].imageUrl),
//                         radius: 24,
//                       ),
                     ),
                     ),

                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          workersyoulove[index].title,
                          style: TextStyle(
                              fontSize: height / 50,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff413564)),
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          workersyoulove[index].description,
                          style: TextStyle(
                              fontSize: height / 60,
//                                fontWeight: FontWeight.bold,
                              color: Color(0xff4f4848)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.center,
                        ),
                      ],
                    ),



                  );
                },
//                        separatorBuilder: (context, index)
//                        {
//                          return Divider();
//                        },
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left:10.0,top: 8),
              child: Text(
                "recommended for You",
                style: TextStyle(
                    fontSize: height / 38,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff9847b7)),
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                //textAlign: TextAlign.center,
              ),
            ),
            Container(
//            color: Colors.red,
              height: height/6,
//                      width: width / 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: recommendedforyou.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => book_event()));
                      print("Hell");
                    },



                    leading:Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image: new  AssetImage(recommendedforyou[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                        border: new Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.blue,
////                       minRadius: 25,
////                       maxRadius: 26,
//                         backgroundImage:
//                         AssetImage(workersyoulove[index].imageUrl),
//                         radius: 24,
//                       ),
                      ),
                    ),

                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          recommendedforyou[index].title,
                          style: TextStyle(
                              fontSize: height / 50,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff413564)),
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          recommendedforyou[index].description,
                          style: TextStyle(
                              fontSize: height / 60,
//                                fontWeight: FontWeight.bold,
                              color: Color(0xff4f4848)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.center,
                        ),
                      ],
                    ),



                  );
                },
//                        separatorBuilder: (context, index)
//                        {
//                          return Divider();
//                        },
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left:10.0,top: 8),
              child: Text(
                "Hight rated",
                style: TextStyle(
                    fontSize: height / 38,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff9847b7)),
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                //textAlign: TextAlign.center,
              ),
            ),
            Container(
//            color: Colors.red,
              height: height/4,
//                      width: width / 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: highrated.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => book_event()));
                      print("Hell");
                    },



                    leading:Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image: new  AssetImage(highrated[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                        border: new Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
//                       child: CircleAvatar(
//                         backgroundColor: Colors.blue,
////                       minRadius: 25,
////                       maxRadius: 26,
//                         backgroundImage:
//                         AssetImage(workersyoulove[index].imageUrl),
//                         radius: 24,
//                       ),
                      ),
                    ),

                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          highrated[index].title,
                          style: TextStyle(
                              fontSize: height / 50,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff413564)),
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          highrated[index].description,
                          style: TextStyle(
                              fontSize: height / 60,
//                                fontWeight: FontWeight.bold,
                              color: Color(0xff4f4848)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.center,
                        ),
                      ],
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
        )

      ),
    );
  }


  Widget friends_conatiner()
  {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
//      color: Colors.pinkAccent,
//      height: height/1.6,

      child: null,

    );
  }


}




class listItems {

  String title;
  String imageUrl;
  String description;

  listItems({
    this.description,
    this.title,
    this.imageUrl,
  });
}
class lessonlistItems {

  String title;
  String imageUrl;
  String description;

  lessonlistItems({
    this.description,
    this.title,
    this.imageUrl,
  });
}

class recomendlistItems {

  String title;
  String imageUrl;
  String description;

  recomendlistItems({
    this.description,
    this.title,
    this.imageUrl,
  });
}

class highratedlistItems {

  String title;
  String imageUrl;
  String description;

  highratedlistItems({
    this.description,
    this.title,
    this.imageUrl,
  });
}






