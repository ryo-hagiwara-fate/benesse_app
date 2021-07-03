import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:template_app/components/rounded_button.dart';
import 'package:template_app/high-five/screens/home_screen.dart';

late User? loggedInUser;
final _firestore = FirebaseFirestore.instance;

class AddUserDetailsScreen extends StatefulWidget {
  static String id = "add_user_details_screen";
  @override
  _AddUserDetailsScreenState createState() => _AddUserDetailsScreenState();
}

class _AddUserDetailsScreenState extends State<AddUserDetailsScreen> {
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
              _firestore.collection("userDetails").doc(loggedInUser!.email).set({
                // "uid": loggedInUser!.uid,
                "userName": userName,
                "universityName": universityName,
                "comment" : comment,
              });
              // Navigator.pushNamed(context, UserDetails.id);
              Navigator.pushNamed(context, HomeScreen.id);
            })
          ],
        ),
      ),
    );
  }
}
