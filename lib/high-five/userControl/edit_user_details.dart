import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:template_app/components/rounded_button.dart';
import 'user_details.dart';




import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:template_app/components/rounded_button.dart';
import 'package:template_app/high-five/screens/home_screen.dart';

late User? loggedInUser;
final _firestore = FirebaseFirestore.instance;

class EAddUserDetailsScreen extends StatefulWidget {
  static String id = "add_user_details_screen";

  EAddUserDetailsScreen(this.userName,this.universityName,this.sex,this.hobby,this.circle);
  String userName = "";
  String universityName = "";
  late String sex;
  late String hobby;
  late String circle;

  @override
  _EAddUserDetailsScreenState createState() => _EAddUserDetailsScreenState();
}

class _EAddUserDetailsScreenState extends State<EAddUserDetailsScreen> {

  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      loggedInUser = user;
      // print(loggedInUser!.email);
      // print(loggedInUser!.uid);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    String userName = widget.userName;
    String universityName = widget.universityName;
    String sex = widget.sex;
    String hobby = widget.hobby;
    String circle = widget.circle;

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.lightBlueAccent,
          title: Center(
            child: Text(
              "Setting",
              style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
      ),
      body: SafeArea(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "お名前",
                  ),
                  onChanged: (value){
                    userName = value;
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "志望大学",
                  ),
                  onChanged: (value){
                    value = universityName;
                    universityName = value;
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "性別",
                  ),
                  onChanged: (value){
                    sex = value;
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "趣味",
                  ),
                  onChanged: (value){
                    hobby = value;
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "入りたいサークル",
                  ),
                  onChanged: (value){
                    circle = value;
                  },
                ),
              ),
              Expanded(
                child: RoundedButton(buttonColor: Colors.red, buttonTitle: "登録！！", onPressed: (){
                  _firestore.collection("userDetails").doc(loggedInUser!.email).set({
                    // "uid": loggedInUser!.uid,
                    "userName": userName,
                    "universityName": universityName,
                    "sex": sex,
                    "hobby": hobby,
                    "circle": circle
                  });
                  // Navigator.pushNamed(context, UserDetails.id);
                  Navigator.pushNamed(context, HomeScreen.id);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}


//
// late User? loggedInUser;
// final _firestore = FirebaseFirestore.instance;

class EditUserDetailsScreen extends StatefulWidget {
  static String id = "edit_user_details_screen";
  @override
  _EditUserDetailsScreenState createState() => _EditUserDetailsScreenState();
}

class _EditUserDetailsScreenState extends State<EditUserDetailsScreen> {
  final _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      loggedInUser = user;
      // print(loggedInUser!.email);
      // print(loggedInUser!.uid);
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    String userName = "";
    String universityName = "";
    String comment = "";
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("ニックネーム"),
            TextField(
              onChanged: (value){
                userName = value;
              },
            ),
            Text("志望大学"),
            TextField(
              onChanged: (value){
                universityName = value;
              },
            ),
            Text("ひとこと！"),
            TextField(
              onChanged: (value){
                comment = value;
              },
            ),
            RoundedButton(buttonColor: Colors.red, buttonTitle: "登録！！", onPressed: (){
              print("$userName : $universityName : $comment : ${loggedInUser!.uid}");
              _firestore.collection("userDetails").doc(loggedInUser!.email).update({
                // "uid": loggedInUser!.uid,
                "userName": userName,
                "universityName": universityName,
                "comment" : comment,
              });
              // Navigator.pushNamed(context, UserDetails.id);
              Navigator.pushNamed(context, UserDetails.id);
            })
          ],
        ),
      ),
    );
  }
}