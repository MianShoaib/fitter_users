import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitter_users/User_Models/fitter_friend_model.dart';
import 'package:fitter_users/User_Models/fitter_lesson_model.dart';
import 'package:fitter_users/User_Models/fitter_worker_model.dart';
import 'package:fitter_users/User_UI/user_findfriends.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

class user_search extends StatefulWidget {
  @override
  user_reviewState createState() => user_reviewState();
}

class user_reviewState extends State<user_search> {
  FirebaseUser user;
  String name, url, email;
  List<Lesson> lessons_list = List();
  List<Worker> loved_list = List();
  List<Worker> recommended_list = List();
  List<Worker> highrated_list = List();
  List<Friends> friends_list = List();
  final controller = PageController();
  String time;
  bool lessonchoosed = true;
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
//    labelPadding: EdgeInsets.symmetric(vertical: 6),
          labelStyle: TextStyle(fontSize: 20),
          indicatorColor: Color(0xff9847b7),
          unselectedLabelColor: Color(0xff9847b7),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          onTap: (index) {
            var content = "";
            switch (index) {
              case 0:
                setState(() {
                  lessonchoosed = true;
                });
                content = "Home";
                break;
              case 1:
                setState(() {
                  lessonchoosed = false;
                });
                content = "Home";
                break;
              case 2:
                setState(() {
                  lessonchoosed = false;
                });
                content = "Home";
                break;
            }
            print("$content");
          });

  void Init() async {
    _pref = await SharedPreferences.getInstance();
    setState(() {
      name = _pref.getString("fullname");
      url = _pref.getString("photourl");
      email = _pref.getString("email");
    });
    ////////////////////////////////////////////////////////////////////
    ////////////////               LESSONS     /////////////////////////
    ////////////////////////////////////////////////////////////////////
    Firestore firestore = Firestore.instance;
    QuerySnapshot collectionReference =
        await firestore.collection("lessons").getDocuments();
    List<DocumentSnapshot> totalDocuments = await collectionReference.documents;
    for (var each in totalDocuments) {
      print(each.data["status"]);
      if (each.data["status"] == "1") {
        String Name, Title, Url;
        Title = each.data["name"];
        String email = each.data["worker"];
        DocumentReference worker_docs =
            await firestore.collection("workers").document(email);
        await worker_docs.get().then((value) {
          Name = value.data["fullname"].toString();
          Url = value.data["photourl"];
        });
        Lesson lesson =
            new Lesson(description: Title, title: Name, imageUrl: Url);
        lessons_list.add(lesson);
        setState(() {});
      }
    }
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
        name: each.data["name"],
        description: each.data["self"],
        imageUrl: each.data["photourl"],
      );
      loved_list.add(worker);
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
      print("Email--->>>" + email);
      DocumentReference user_recommended_worker_documents =
          await firestore.collection("workers").document(email);
      user_recommended_worker_documents.get().then((value) {
        Worker worker = new Worker(
            name: value.data["fullname"],
            description: value.data["self"],
            imageUrl: value.data["photourl"],
            rating: value.data["rating"]);
        recommended_list.add(worker);
        setState(() {});
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
      Worker worker = new Worker(
          name: each.data["fullname"],
          description: each.data["self"],
          imageUrl: each.data["photourl"],
          rating: each.data["rating"]);
      highrated_list.add(worker);
      setState(() {});
    }
    Worker temp = new Worker();
    for (int i = 1; i < highrated_list.length; i++) {
      for (int j = i; j > 0; j--) {
        if (int.parse(highrated_list[j].rating.toString()) >
            int.parse(highrated_list[j - 1].rating.toString())) {
          temp = highrated_list[j];
          highrated_list[j] = highrated_list[j - 1];
          highrated_list[j - 1] = temp;
        }
      }
    }
    setState(() {});

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
  Widget build(BuildContext context) {
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

  Widget lesson_container() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
//              color: Colors.red,
        height: height / 2,
//                      width: width / 1,
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: lessons_list.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => book_event()));
                print("Hell");
              },
              leading: Container(
                width: 50,
                height: 50,
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    image: lessons_list[index].imageUrl == null
                        ? new AssetImage('images/user/pic1.JPG')
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
    );
  }

  Widget worker_conatiner() {
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
                //textAlign: TextAlign.center,
              ),
            ),
            Container(
//              color: Colors.red,
              height: height / (12 / loved_list.length),
//                      width: width / 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: loved_list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => book_event()));
                      print("Hell");
                    },
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image: loved_list[index].imageUrl == null
                              ? new AssetImage('images/user/pic1.JPG')
                              : new NetworkImage(loved_list[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
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
                          loved_list[index].name,
                          style: TextStyle(
                              fontSize: height / 50,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff413564)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          loved_list[index].description,
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
              padding: const EdgeInsets.only(left: 10.0, top: 8),
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
              height: height / (12 / recommended_list.length),
//                      width: width / 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: recommended_list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => book_event()));
                      print("Hell");
                    },
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image: recommended_list[index].imageUrl == null
                              ? new AssetImage('images/user/pic1.JPG')
                              : new NetworkImage(
                                  recommended_list[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
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
                          recommended_list[index].name,
                          style: TextStyle(
                              fontSize: height / 50,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff413564)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          recommended_list[index].description,
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
                //textAlign: TextAlign.center,
              ),
            ),
            Container(
//            color: Colors.red,
              height: height / (12 / highrated_list.length),
//                      width: width / 1,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: highrated_list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => book_event()));
                      print("Hell");
                    },
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
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
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

  Widget friends_conatiner() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: friends_list.length == null
          ? Container(
//              color: Colors.red,
              height: height / 2,
//                      width: width / 1,
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 18.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: friends_list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => book_event()));
                      print("Hell");
                    },
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
            )
          :
      Container(
        padding: EdgeInsets.only(top: height/ 5),
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
                  children:
                  [
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
                      onPressed: ()
                      {
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