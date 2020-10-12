import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter_users/User_Models/fitter_friend_model.dart';
import 'package:fitter_users/User_Models/fitter_lesson_model.dart';
import 'package:fitter_users/User_Models/fitter_user_model.dart';
import 'package:fitter_users/User_Models/fitter_worker_model.dart';
import 'package:fitter_users/User_UI/user_findfriends.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

class user_search extends StatefulWidget {
  @override
  user_reviewState createState() => user_reviewState();
}

class user_reviewState extends State<user_search>
{
  FirebaseUser user;
  Firestore firestore;
  String name, url, email;
  //-------------------------------------//
  List<Lesson> lessons_list = List();
  //-------------------------------------//
  List<Worker> all_Workers = List();
  List<Worker> loved_list = List();
  List<Worker> recommended_list = List();
  List<Worker> highrated_list = List();
  //-------------------------------------//
  List<Friends> friends_list = List();
  //-------------------------------------//
  List<String> list_of_lessons = List();
  List<String> list_of_workers = List();
  List<String> list_of_friends = List();
  //-------------------------------------//
  bool lesson_load = false, worker_load = false, friend_load = false;

  final controller = PageController();
  String time, selectedTab = "lesson";
  bool lessonchoosed = true;
  SharedPreferences _pref;

  void ShowToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.purple.shade300,
        textColor: Colors.white);
  }

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

  Widget loading(double height)
  {
    if (!lesson_load)
    {
      return Center(
        child: Container(
          padding: EdgeInsets.only(top: height / 3),
          child: CircularProgressIndicator(
            strokeWidth: 5.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppUser.loadingfrontColor,
            ),
            backgroundColor: AppUser.loadingbackgroundColor,
          ),
        ),
      );
    }
    return SizedBox();
  }

  Widget loading2(double height)
  {
    if (!worker_load)
    {
      return Center(
        child: Container(
          padding: EdgeInsets.only(top: height / 3),
          child: CircularProgressIndicator(
            strokeWidth: 5.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppUser.loadingfrontColor,
            ),
            backgroundColor: AppUser.loadingbackgroundColor,
          ),
        ),
      );
    }
    return SizedBox();
  }

  Widget loading3(double height)
  {
    if (!friend_load)
    {
      return Center(
        child: Container(
          padding: EdgeInsets.only(top: height / 3),
          child: CircularProgressIndicator(
            strokeWidth: 5.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppUser.loadingfrontColor,
            ),
            backgroundColor: AppUser.loadingbackgroundColor,
          ),
        ),
      );
    }
    return SizedBox();
  }

  var usertype = "1";
  DropdownButton userTpe() => DropdownButton<String>(
        icon: Icon(
          Icons.arrow_drop_down_circle,
          size: 18,
        ),
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
          labelStyle: TextStyle(fontSize: 20),
          indicatorColor: Color(0xff9847b7),
          unselectedLabelColor: Color(0xff9847b7),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          onTap: (index) async
          {
            await clearAll();
            switch (index)
            {
              case 0:
                lesson_load = false;
                setState(()
                {
                  lessonchoosed = true;
                });
                selectedTab = "lesson";
                await getLessons();
                lesson_load = true;
                setState(() {});
                break;
              case 1:
                worker_load = false;
                setState(() {
                  lessonchoosed = false;
                });
                selectedTab = "worker";
                await getWorkers();
                worker_load = true;
                setState(() {});
                break;
              case 2:
                friend_load = false;
                setState(() {
                  lessonchoosed = false;
                });
                selectedTab = "friend";
                await getFriends();
                friend_load = true;
                setState(() {});
                break;
            }
          });

  clearAll() async
  {
    lessons_list = new List();
    //-------------------------------------//
    all_Workers = new List();
    loved_list = new List();
    recommended_list = new List();
    highrated_list = new List();
    //-------------------------------------//
    friends_list = new List();
    //-------------------------------------//
    list_of_lessons = new List();
    list_of_workers = new List();
    list_of_friends= new List();
  }

  bool isExist(List<Worker> list, String worker, String type)
  {
    for (var each in list) {
      if (each.mail == worker) {
        return true;
      } else {
        continue;
      }
    }
    print('return false');
    return false;
  }

  void Init() async
  {
    firestore = Firestore.instance;
    _pref = await SharedPreferences.getInstance();
    setState(() {
      name = _pref.getString("fullname");
      url = _pref.getString("photourl");
      email = _pref.getString("email");
    });
    await getLessons();
    lesson_load = true;
    setState(() {});
  }

  void getLessons() async
  {
    ////////////////////////////////////////////////////////////////////
    ////////////////               LESSONS     /////////////////////////
    ////////////////////////////////////////////////////////////////////

    QuerySnapshot collectionReference =
    await firestore.collection("lessons").getDocuments();
    List<DocumentSnapshot> totalDocuments = await collectionReference.documents;
    for (var each in totalDocuments) {
      if (each.data["status"] == "1" && each.data["worker"] != "admin") {
        String Name, Title, Url;
        Title = each.data["name"];
        String email = each.data["worker"];
        DocumentReference worker_docs =
        await firestore.collection("workers").document(email);
        await worker_docs.get().then((value) {
          Name = value.data["fullname"].toString();
          Url = value.data["photourl"];
        });
        Lesson lesson = new Lesson(description: Title, title: Name, imageUrl: Url);
        lessons_list.add(lesson);
        list_of_lessons.add(lesson.description);
        setState(() {});
      } else {
        String Title = each.data["name"];
        Lesson lesson = new Lesson(
            description: Title, title: "Admin", imageUrl: "images/admin.gif");
        lessons_list.add(lesson);
        list_of_lessons.add(lesson.description);
        setState(() {});
      }
    }
  }

  void getWorkers() async {
    ////////////////////////////////////////////////////////////////////
    ////////////////             WORKERS       /////////////////////////
    ////////////////////////////////////////////////////////////////////

    QuerySnapshot user_worker_documents = await firestore
        .collection("users")
        .document(email)
        .collection("Workers")
        .getDocuments();
    List<DocumentSnapshot> user_worker_docs =
    await user_worker_documents.documents;
    for (var each in user_worker_docs) {
      Worker worker = new Worker(
        status: "Follow",
        mail: each.data["email"],
        name: each.data["name"],
        description: each.data["description"],
        rating: each.data["rating"],
        imageUrl: each.data["imageUrl"],
      );
      loved_list.add(worker);
      all_Workers.add(worker);
      list_of_workers.add(worker.name);
      setState(() {});
    }



    ////////////////////////////////////////////////////////////////////
    ////////////////        RECOMMENDED   WORKERS      /////////////////
    ////////////////////////////////////////////////////////////////////
    QuerySnapshot user_events_documents = await firestore
        .collection("users")
        .document(email)
        .collection("Events")
        .getDocuments();
    List<DocumentSnapshot> user_events_docs =
    await user_events_documents.documents;
    for (var each in user_events_docs) {
      String email = each.data["worker"];
      DocumentReference user_recommended_worker_documents =
      await firestore.collection("workers").document(email);
      await user_recommended_worker_documents.get().then((value) {
        if (!isExist(loved_list, email, "loved") &&
            !isExist(recommended_list, email, "recommended") &&
            !isExist(highrated_list, email, "highrated")) {
          Worker worker = new Worker(
              status: "Follow",
              mail: email,
              name: value.data["fullname"],
              description: value.data["self"],
              imageUrl: value.data["photourl"],
              rating: value.data["rating"]);
          recommended_list.add(worker);
          all_Workers.add(worker);
          list_of_workers.add(worker.name);
          setState(() {});
        }
      });
    }

    ////////////////////////////////////////////////////////////////////
    ////////////////          HIGH RATED WORKERS      /////////////////
    ////////////////////////////////////////////////////////////////////

    QuerySnapshot user_highrated_worker_documents =
    await firestore.collection("workers").getDocuments();
    List<DocumentSnapshot> user__highrated_worker_docs =
    await user_highrated_worker_documents.documents;
    for (var each in user__highrated_worker_docs) {
      String mail = each.data["email"];
      if (!isExist(loved_list, mail, "loved") &&
          !isExist(recommended_list, mail, "recommended") &&
          !isExist(highrated_list, mail, "highrated")) {
        Worker worker = new Worker(
            status: "Follow",
            mail: each.data["email"],
            name: each.data["fullname"],
            description: each.data["self"],
            imageUrl: each.data["photourl"],
            rating: each.data["rating"]);
        highrated_list.add(worker);
        all_Workers.add(worker);
        list_of_workers.add(worker.name);
      }
      setState(() {});
    }
    Worker temp = new Worker();
    for (int i = 1; i < highrated_list.length; i++) {
      for (int j = i; j > 0; j--) {
        if (highrated_list[j].rating > highrated_list[j - 1].rating) {
          temp = highrated_list[j];
          highrated_list[j] = highrated_list[j - 1];
          highrated_list[j - 1] = temp;
        }
      }
    }
    setState(() {});
  }

  void getFriends() async {
    firestore = Firestore.instance;
    QuerySnapshot user_requests_documents = await firestore
        .collection("users")
        .document(email)
        .collection("Friends")
        .getDocuments();
    List<DocumentSnapshot> user_requests_docs =
    await user_requests_documents.documents;
    for (var each in user_requests_docs) {
      String status = each.data["status"];
      if (status == "1") {
        Friends request = new Friends(
            personname: each.data["name"],
            imageUrl: each.data["photourl"],
            email: each.data["email"]);
        friends_list.add(request);
        list_of_friends.add(request.personname);
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    Init();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            "images/splash_logo.png",
            scale: 10,
          ),
          iconTheme: IconThemeData(
            color: Color(0xff9847b7), //change your color here
          ),
          backgroundColor: Color(0xffe3e1e1),
          elevation: 0,
        ),
        drawer: SideDrawer(
            downloadURL: url, name: name, height: height, width: width),
        backgroundColor: Color(0xffe3e1e1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: height / 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 280,
                    alignment: Alignment.center,
                    child: TextFormField(
                      onTap: () {
                        switch (selectedTab) {
                          case "lesson":
                            {
                              showSearch(
                                  context: context,
                                  delegate: Search(
                                      all_lessons: lessons_list,
                                      type: "lesson",
                                      listExample: list_of_lessons));
                              break;
                            }
                          case "worker":
                            {
                              showSearch(
                                  context: context,
                                  delegate: Search(
                                      all_workers: all_Workers,
                                      type: "worker",
                                      listExample: list_of_workers));
                              break;
                            }
                          case "friend":
                            {
                              showSearch(
                                  context: context,
                                  delegate: Search(
                                      all_friends: friends_list,
                                      type: "friend",
                                      listExample: list_of_friends));
                              break;
                            }
                          default:
                            showSearch(
                                context: context,
                                delegate: Search(
                                    all_lessons: lessons_list,
                                    listExample: list_of_lessons));
                            break;
                        }
                      },
                      cursorColor: Colors.grey,
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
                  lessonchoosed == true
                      ? IconButton(
                          onPressed: () {
                            return showDialog(
                              context: context,
                              builder: (context) {
                                List<bool> isSelected = [true, false, false];
                                List<FocusNode> focusToggle;
                                return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    content: Container(
                                      height: height / 1.2,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
//                                  mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  "Filter",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  width: width / 6,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                    size: 22,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: height / 40,
                                            ),
                                            Text(
                                              "Select Time",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.0),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18.0, top: 2),
                                              child: Container(
                                                width: width / 1.2,
                                                height: height / 20,
                                                child: CupertinoTheme(
                                                  data: CupertinoThemeData(
                                                      barBackgroundColor:
                                                          Colors.white,
                                                      textTheme: CupertinoTextThemeData(
                                                          dateTimePickerTextStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey))),
                                                  child: CupertinoDatePicker(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    mode:
                                                        CupertinoDatePickerMode
                                                            .time,
                                                    use24hFormat: false,
                                                    onDateTimeChanged:
                                                        (asleep) {
                                                      time = asleep.toString();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 0.0),
                                              child: TextField(
                                                decoration: InputDecoration(
//                      border: InputBorder.,
                                                  hintText: 'Select Location',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 40,
                                            ),
                                            Text(
                                              "Select Date",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.0),
                                            ),
                                            SizedBox(
                                              height: height / 60,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _selectDate(context);
                                                },
                                                child: Text(
                                                  "${selectedDate.toLocal()}"
                                                      .split(' ')[0],
                                                  style: TextStyle(
                                                    fontSize: height / 40,
//                  decoration: TextDecoration.underline
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                width: width / 1.2,
                                                child: Divider(
                                                  thickness: 1,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 60,
                                            ),
                                            Text(
                                              "Type of Lesson",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.0),
                                            ),
                                            SizedBox(
                                              height: height / 90,
                                            ),
                                            Center(
                                              child: Container(
                                                width: width / 1.14,
                                                height: height / 18,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff),
                                                  border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),

//                        color: Colors.yellow,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            right: 18),
                                                    child: userTpe(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 40,
                                            ),
                                            Text(
                                              "Select Price Range",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.0),
                                            ),
                                            Center(
                                              child: Container(
                                                width: width / 1.1,
                                                child: SliderTheme(
                                                  data: SliderTheme.of(context)
                                                      .copyWith(
                                                    overlayColor:
                                                        Color(0xff9847b7),
                                                    activeTickMarkColor:
                                                        Color(0xff9847b7),
                                                    thumbColor:
                                                        Color(0xff9847b7),
                                                    activeTrackColor:
                                                        Color(0xff9847b7),
                                                  ),
                                                  child: frs.RangeSlider(
                                                    min: 0.0,
                                                    max: 100.0,
                                                    lowerValue: _lowerValue,
                                                    upperValue: _upperValue,
                                                    divisions: 100,
                                                    showValueIndicator: true,
                                                    valueIndicatorMaxDecimals:
                                                        1,
                                                    onChanged: (double
                                                            newLowerValue,
                                                        double newUpperValue) {
                                                      setState(() {
                                                        _lowerValue =
                                                            newLowerValue;
                                                        _upperValue =
                                                            newUpperValue;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                width: width / 1.2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text("Min: $_lowerValue"),
                                                    Text("Max: $_upperValue"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 40,
                                            ),
                                            Text(
                                              "Participants",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.0),
                                            ),
                                            Center(
                                              child: Container(
                                                width: width / 1.1,
                                                child: SliderTheme(
                                                  data: SliderTheme.of(context)
                                                      .copyWith(
                                                    overlayColor:
                                                        Color(0xff9847b7),
                                                    activeTickMarkColor:
                                                        Color(0xff9847b7),
                                                    thumbColor:
                                                        Color(0xff9847b7),
                                                    activeTrackColor:
                                                        Color(0xff9847b7),
                                                  ),
                                                  child: frs.RangeSlider(
                                                    min: 0.0,
                                                    max: 100.0,
                                                    lowerValue: _lowerValue,
                                                    upperValue: _upperValue,
                                                    divisions: 100,
                                                    showValueIndicator: true,
                                                    valueIndicatorMaxDecimals:
                                                        1,
                                                    onChanged: (double
                                                            newLowerValue,
                                                        double newUpperValue) {
                                                      setState(() {
                                                        _lowerValue =
                                                            newLowerValue;
                                                        _upperValue =
                                                            newUpperValue;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                width: width / 1.2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text("Min: $_lowerValue"),
                                                    Text("Max: $_upperValue"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height / 40,
                                            ),
                                            Container(
                                              height: height / 20,
//                                        width: width/1,
                                              child: Center(
                                                child: ToggleButtons(
                                                  color: Color(0xff9847b7),
                                                  selectedColor: Colors.white,
                                                  selectedBorderColor:
                                                      Color(0xff9847b7),
                                                  fillColor: Color(0xff9847b7),
                                                  splashColor: Colors.lightBlue,
                                                  highlightColor:
                                                      Colors.lightBlue,
//                                            borderColor: Color(0xffefefef),
                                                  borderWidth: 4,
                                                  renderBorder: true,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25)),
                                                  disabledColor:
                                                      Colors.blueGrey,
                                                  disabledBorderColor:
                                                      Colors.blueGrey,
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
                                                      isSelected[index] =
                                                          !isSelected[index];
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            );
                          },
                          icon: Icon(
                            Icons.tune,
                            color: Color(0xff9847b7),
                          ),
                        )
                      : Text(''),
                ],
              ),
              Container(
                height: height / 1.36,
                width: width / 1,
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
                            //physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              Container(
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

  Widget lesson_container()
  {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            height: lessons_list.length != null || lessons_list.length != 0
                ? height / (12 / lessons_list.length)
                : height / 10,
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: lessons_list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        image: lessons_list[index].imageUrl == null ||
                                lessons_list[index].title == "Admin"
                            ? new AssetImage(lessons_list[index].imageUrl)
                            : new NetworkImage(lessons_list[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                      border: new Border.all(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        lessons_list[index].title,
                        style: TextStyle(
                            fontSize: height / 50,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff413564)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        lessons_list[index].description,
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
            ),
          ),
          loading(height),
        ],
      ),
    );
  }

  Widget worker_conatiner() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                  child: Text(
                    "Workers You Loved",
                    style: TextStyle(
                        fontSize: height / 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9847b7)),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  height: loved_list.length != null || loved_list.length != 0
                      ? height / (12 / loved_list.length)
                      : height / 10,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: loved_list.length,
                    itemBuilder: (context, int l_index)
                    {
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: new BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: new DecorationImage(
                              image: loved_list[l_index].imageUrl == null
                                  ? new AssetImage('images/user/pic1.JPG')
                                  : new NetworkImage(loved_list[l_index].imageUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(50.0)),
                            border: new Border.all(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              loved_list[l_index].name,
                              style: TextStyle(
                                  fontSize: height / 50,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff413564)),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              loved_list[l_index].description,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                  child: Text(
                    "Recommended for You",
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
                  color: Colors.red,
                  height: recommended_list.length != null ||
                          recommended_list.length != 0
                      ? height / (12 / recommended_list.length)
                      : height / 10,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recommended_list.length,
                    itemBuilder: (context, int index1) {
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: new BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: new DecorationImage(
                              image: recommended_list[index1].imageUrl == null
                                  ? new AssetImage('images/user/pic1.JPG')
                                  : new NetworkImage(
                                      recommended_list[index1].imageUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(50.0)),
                            border: new Border.all(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              recommended_list[index1].name,
                              style: TextStyle(
                                  fontSize: height / 50,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff413564)),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              recommended_list[index1].description,
                              style: TextStyle(
                                  fontSize: height / 60, color: Color(0xff4f4848)),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () async {
                            Firestore firestore = Firestore.instance;
                            DocumentReference ref = await firestore
                                .collection("users")
                                .document(email)
                                .collection("Workers")
                                .document(recommended_list[index1].mail);
                            DocumentReference worker_ref = await firestore.collection("recommended_list").document(recommended_list[index1].mail).collection("Followers").document(email);
                            ref.get().then((value) async
                            {
                              if (value.exists)
                              {
                                ShowToast('Already Following');
                              } else
                                {
                                ref.setData({
                                  "email": recommended_list[index1].mail,
                                  "name": recommended_list[index1].name,
                                  "description": recommended_list[index1].description,
                                  "imageUrl": recommended_list[index1].imageUrl,
                                  "rating": recommended_list[index1].rating,
                                });
                                worker_ref.setData({
                                  "email": email,
                                  "name": name,
                                  "photourl": url,
                                });
                                DocumentReference worker_noti_ref = await firestore.collection("workers").document(recommended_list[index1].mail).collection("notifications").document();
                                worker_noti_ref.setData({
                                  "desc": "Started Following You",
                                  "name": name,
                                  "url": url,
                                });
                                recommended_list[index1].status = "Following";
                                setState(() {});
                                FirebaseUser user = await FirebaseAuth.instance.currentUser();
                                AppUser.UpdatePrefences(user);
                              }
                            });
                          },
                          child: Container(
                            width: width / 5,
                            height: 30.0,
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
                                "Follow",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                  child: Text(
                    "High rated",
                    style: TextStyle(
                        fontSize: height / 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff9847b7)),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
//            color: Colors.red,
                  height:
                      highrated_list.length != null || highrated_list.length != 0
                          ? height / (12 / highrated_list.length)
                          : height / 10,
                  child: (highrated_list.length != null ||
                          highrated_list.length != 0)
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: highrated_list.length,
                          itemBuilder: (context, index)
                          {
                            return ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  image: new DecorationImage(
                                    image: highrated_list[index].imageUrl == null
                                        ? new AssetImage('images/user/pic1.JPG')
                                        : new NetworkImage(
                                            highrated_list[index].imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(50.0)),
                                  border: new Border.all(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    highrated_list[index].name,
                                    style: TextStyle(
                                        fontSize: height / 50,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff413564)),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    highrated_list[index].description,
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
                              trailing: GestureDetector(
                                onTap: () async {
                                  Firestore firestore = Firestore.instance;
                                  DocumentReference ref = await firestore
                                      .collection("users")
                                      .document(email)
                                      .collection("Workers")
                                      .document(highrated_list[index].mail);
                                  DocumentReference worker_ref = await firestore
                                      .collection("workers")
                                      .document(highrated_list[index].mail)
                                      .collection("Followers")
                                      .document(email);
                                  ref.get().then((value) async {
                                    if (value.exists) {
                                      ShowToast('Already Following');
                                    } else {
                                      ref.setData({
                                        "email": highrated_list[index].mail,
                                        "name": highrated_list[index].name,
                                        "description":
                                            highrated_list[index].description,
                                        "imageUrl": highrated_list[index].imageUrl,
                                        "rating": highrated_list[index].rating,
                                      });
                                      worker_ref.setData({
                                        "email": email,
                                        "name": name,
                                        "photourl": url,
                                      });
                                      DocumentReference worker_noti_ref = await firestore.collection("workers").document(highrated_list[index].mail).collection("notifications").document();
                                      worker_noti_ref.setData({
                                        "desc": "Started Following You",
                                        "name": name,
                                        "url": url,
                                      });
                                      highrated_list[index].status = "Following";
                                      setState(() {});
                                      FirebaseUser user =
                                          await FirebaseAuth.instance.currentUser();
                                      AppUser.UpdatePrefences(user);
                                    }
                                  });
                                },
                                child: Container(
                                  width: width / 5,
                                  height: 30.0,
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
                                      '${highrated_list[index].status}',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Text(''),
                ),
              ],
            ),
          ),
          loading2(height),
        ],
      ),
    );
  }

  Widget friends_conatiner()
  {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: friends_list.length != null || friends_list.length != 0
          ? Stack(
            children: <Widget>[
              Container(height: friends_list.length != null || friends_list.length != 0
                ? height / (5 / friends_list.length)
                : height / 10,
                  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: friends_list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: new BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: new DecorationImage(
                              image: friends_list[index].imageUrl == null
                                  ? new AssetImage('images/user/pic1.JPG')
                                  : new NetworkImage(friends_list[index].imageUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(50.0)),
                            border: new Border.all(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              friends_list[index].personname,
                              style: TextStyle(
                                  fontSize: height / 50,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff413564)),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              friends_list[index].email,
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
                  ),
                ),
              loading3(height),
            ],
          )
          : Container(
              padding: EdgeInsets.only(top: height / 5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Friends List Empty",
                      style: TextStyle(
                          fontSize: height / 38,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff9847b7)),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: width / 50,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Click to add new Friends",
                            style: TextStyle(
                                fontSize: height / 38,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff9847b7)),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            //textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: width / 50,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.purple[400],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          user_find_friends()));
                            },
                            iconSize: height / 20,
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

class Search extends SearchDelegate
{
  final List<String> listExample;
  final List<Worker> all_workers;
  final List<Lesson> all_lessons;
  final List<Friends> all_friends;
  final String type;
  List<String> recentList = List();

  Search(
      {this.listExample,
      this.all_workers,
      this.all_lessons,
      this.all_friends,
      this.type});
  String selectedResult = "";
  List<Worker> workers = List();
  List<Lesson> lessons = List();
  List<Friends> friends = List();

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context)
  {
    double height = MediaQuery.of(context).size.height;

    switch (type)
    {
      case "lesson":
        {
          for (var each in all_lessons)
          {
            if (each.description == selectedResult)
            {
              lessons.add(each);
              break;
            }
          }
          if (lessons != null)
          {
            return Container(
              height: height / lessons.length * 5,
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image: lessons[index].imageUrl == null ||
                                  lessons[index].title == "Admin"
                              ? new AssetImage(lessons[index].imageUrl)
                              : new NetworkImage(lessons[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
                        border: new Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          lessons[index].title,
                          style: TextStyle(
                              fontSize: height / 50,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff413564)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          lessons[index].description,
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
              ),
            );
          } else {
            return Container(
              child: Center(
                child: Text("No Result"),
              ),
            );
          }
          break;
        }
      case "worker":
        {
          for (var each in all_workers) {
            if (each.name == selectedResult)
            {
              workers.add(each);
              break;
            }
          }
          if (workers != null) {
            return Container(
              height: workers.length != null ||
                  workers.length != 0
                  ? height / (12 / workers.length)
                  : height / 10,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: workers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image: workers[index].imageUrl == null
                              ? new AssetImage('images/user/pic1.JPG')
                              : new NetworkImage(
                              workers[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                        new BorderRadius.all(new Radius.circular(50.0)),
                        border: new Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          workers[index].name,
                          style: TextStyle(
                              fontSize: height / 50,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff413564)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          workers[index].description,
                          style: TextStyle(
                              fontSize: height / 60, color: Color(0xff4f4848)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return Container(
              child: Center(
                child: Text("No Result"),
              ),
            );
          }
          break;
        }
      case "friend":
        {
          for (var each in all_friends) {
            if (each.personname == selectedResult) {
              print("Friend Matched");
              friends.add(each);
              break;
            }
          }
          if (friends != null) {
            return Container(
//              color: Colors.red,
              height: height / 2,
//                      width: width / 1,
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image: friends[index].imageUrl == null
                              ? new AssetImage('images/user/pic1.JPG')
                              : new NetworkImage(friends[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
                        border: new Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          friends[index].personname,
                          style: TextStyle(
                              fontSize: height / 50,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff413564)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          friends[index].email,
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
              ),
            );
          } else {
            return Container(
              child: Center(
                child: Text("No Result"),
              ),
            );
          }
          break;
        }
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            recentList.add(selectedResult);
            showResults(context);
          },
        );
      },
    );
  }
}