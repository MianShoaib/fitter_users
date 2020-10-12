import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitter_users/User_Models/fitter_user_purse.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppUser
{
  final image;
  String fullname;
  String email;
  String photourl;
  var birth_date;
  String home_town;
  String gender;
  String area;
  String workers;
  String following;
  String followers;
  String downloadURL;

  static Color loadingfrontColor = Color(0xff9847b7), loadingbackgroundColor = Color(0xff7c94b6);
  AppUser({this.image,this.email,this.photourl,this.downloadURL,this.fullname,this.home_town,this.followers,this.gender,this.area,this.birth_date,this.following,this.workers});

  Future getImageAddress(String ImageName) async
  {
    String downloadAddress = await FirebaseStorage.instance.ref().child(ImageName).getDownloadURL();
    return downloadAddress;
  }


  Future uploadImage() async
  {
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(email);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  }

  Future getImageUrl() async
  {
    String downloadAddress = await FirebaseStorage.instance.ref().child(photourl).getDownloadURL();
    print(downloadAddress);
    downloadURL = downloadAddress;
    return downloadURL;
  }

  Future storeWorker(FirebaseUser user, AppUser appUser, Purse purse, bool imageUploaded) async
  {
    if(!imageUploaded)
    {
      await uploadImage();
      await getImageUrl();
    }
    print(image);
    print(fullname);
    final firestoreInstance = Firestore.instance;
    await firestoreInstance.collection("users").document(user.email).setData(
        {
          "app_user_type" : "User",
          "fullname" : appUser.fullname,
          "email" : appUser.email,
          "photourl" : appUser.downloadURL,
          "birth_date" : appUser.birth_date,
          "home_town" : appUser.home_town,
          "gender" : appUser.gender,
          "area" : appUser.area,
          "workers" : 0,
          "friends" : 0,
          "followers" : 0,
        });
    await firestoreInstance.collection("users").document(user.email).collection("Purse").document(user.email).setData({
      "cardnumber" : purse.cardnumber,
      "name" : purse.name,
      "cv_number" : purse.cv_number,
      "M_Y" : purse.M_Y,
    });
    print("User Stored on firestore");
    await Storepref(appUser,purse);
  }

  void Storepref(AppUser worker, Purse purse) async
  {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("app_user_type","User");
    _pref.setString("fullname", worker.fullname);
    _pref.setString("email", worker.email);
    _pref.setString("photourl", worker.downloadURL);
    _pref.setString("birth_date", worker.birth_date.toString());
    _pref.setString("home_town", worker.home_town);
    _pref.setString("gender", worker.gender);
    _pref.setString("area", worker.area);
    _pref.setInt("workers", 0);
    _pref.setInt("friends" , 0);
    _pref.setInt("followers" , 0);
    bool store = await _pref.commit();
    if(store)
    {
      print("User Stored in Preferences as well");
    }
    _pref.setString("cardnumber", purse.cardnumber);
    _pref.setString("name", purse.name);
    _pref.setString("cv_number", purse.cv_number);
    _pref.setString("M_Y", purse.M_Y);
    store = await _pref.commit();
    if(store)
    {
      print("Purse Stored in Preferences as well");
    }
  }

  static UpdatePrefences(FirebaseUser firebaseUser) async
  {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print("updating Preferences");
    final firestoreInstance = Firestore.instance;
    var document = await firestoreInstance.collection('users').document(firebaseUser.email);
    QuerySnapshot friends_count = await document.collection("Friends").getDocuments();
    List<DocumentSnapshot> friends = await friends_count.documents;
    QuerySnapshot workers_count = await document.collection("Workers").getDocuments();
    List<DocumentSnapshot> workers = await workers_count.documents;
    print(friends);
    print(workers);
    document.updateData({
      "workers" : workers.length.toString(),
      "friends" : friends.length.toString(),
    });
    document.get().then((value) async
    {
      int fr, fo, wo;
      try
      {
        wo = int.parse(value.data["workers"]);
        fr = int.parse(value.data["friends"]);
        fo = int.parse(value.data["followers"]);
      }
      catch(e)
      {
      }
      _pref.setString("app_user_type","User");
      _pref.setString("fullname", value.data["fullname"]);
      _pref.setString("email", value.data["email"]);
      _pref.setString("photourl", value.data["photourl"]);
      _pref.setString("birth_date", value.data["birth_date"].toString());
      _pref.setString("home_town", value.data["home_town"]);
      _pref.setString("gender", value.data["gender"]);
      _pref.setString("area", value.data["area"]);
      _pref.setInt("workers", wo);
      _pref.setInt("friends" , fr);
      _pref.setInt("followers" , fo);
      bool store = await _pref.commit();
      if(store)
      {
        print("User Stored in Preferences as well");
      }
      print(value.data["email"]);
    });
    var purseReference = document.collection("Purse").document(firebaseUser.email);
    purseReference.get().then((value) async
    {
      _pref.setString("cardnumber", value.data["cardnumber"]);
      _pref.setString("name", value.data["name"]);
      _pref.setString("cv_number", value.data["cv_number"]);
      _pref.setString("M_Y", value.data["M_Y"]);
      bool store = await _pref.commit();
      if(store)
      {
        print("Purse Stored in Preferences as well");
      }
    });
  }

}