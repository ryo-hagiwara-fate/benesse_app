import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:template_app/components/rounded_button.dart';
import 'package:template_app/high-five/screens/home_screen.dart';
import 'package:flutter_picker/flutter_picker.dart';


int durationHour = 0;
int durationMinute = 0;
late User? loggedInUser;
final _firestore = FirebaseFirestore.instance;

class QuestionPostScreen extends StatefulWidget {
  static String id = "question_post_screen";
  @override
  _QuestionPostScreenState createState() => _QuestionPostScreenState();
}

class _QuestionPostScreenState extends State<QuestionPostScreen> {
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      loggedInUser = user;
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
    String subject = "";
    String unitName = "";
    String questionText = "";

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("科目"),
            TextField(
              onChanged: (value){
                subject = value;
              },
            ),
            Text("単元"),
            TextField(
              onChanged: (value){
                unitName = value;
              },
            ),
            Text("質問内容"),
            TextField(
              maxLines: 8,
              onChanged: (value){
                questionText = value;
              },
            ),
            RoundedButton(buttonColor: Colors.red, buttonTitle: "質問！！", onPressed: (){
              // print("$userName : $universityName : $questionText : ${loggedInUser!.uid}");
              _firestore.collection("test-questionPosts").add({
                // "uid": loggedInUser!.uid,
                "subject": subject,
                "unitName": unitName,
                "questionText" : questionText,
                "email": loggedInUser!.email,
                "likes": 0,
                "time": DateTime.now(),
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
