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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: getUserData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("科目"),
                  TextField(
                    onChanged: (value) {
                      subject = value;
                    },
                  ),
                  Text("単元"),
                  TextField(
                    onChanged: (value) {
                      unitName = value;
                    },
                  ),
                  Text("質問内容"),
                  TextField(
                    maxLines: 3,
                    onChanged: (value) {
                      questionText = value;
                    },
                  ),
                  RoundedButton(
                      buttonColor: Colors.red, buttonTitle: "質問！！", onPressed: () {
                    // print("${loggedInUser!.uid}");
                    _firestore.collection("test-questionPosts").add({
                      // "uid": loggedInUser!.uid,
                      "subject": subject,
                      "unitName": unitName,
                      "questionText": questionText,
                      "email": loggedInUser!.email,
                      "likes": 0,
                      "time": DateTime.now(),
                      "userName": snapshot.data!["userName"],
                    });
                    // Navigator.pushNamed(context, UserDetails.id);
                    Navigator.pop(context);
                  })
                ],
              );
            } else if (snapshot.hasError) {
            return Text('エラーだよ！');
            }else{
            return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
  Future<DocumentSnapshot> getUserData() async {
    var currentUserEmail = loggedInUser!.email;
    // print("今のユーザーIDは、$currentUid です");
    var querySnapshot = await FirebaseFirestore.instance
        .collection("userDetails")
        .doc(currentUserEmail)
        .get();
    print(querySnapshot);
    return querySnapshot; //QuerySnapshot(条件に一致したdocumentsの集まり)
  }
}
