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

class StudyPostScreen extends StatefulWidget {
  static String id = "study_post_screen";
  @override
  _StudyPostScreenState createState() => _StudyPostScreenState();
}

class _StudyPostScreenState extends State<StudyPostScreen> {
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
    String textbook = "";
    String comment = "";

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("勉強した教科"),
            TextField(
              onChanged: (value){
                subject = value;
              },
            ),
            Text("教材"),
            TextField(
              onChanged: (value){
                textbook = value;
              },
            ),
            // https://stackoverflow.com/questions/57754745/how-to-keep-cupertinodatepicker-at-the-bottom-of-the-screen-instead-of-the-whole
            ListTile(
              title: Text('時間入力！'),
              // title: Text('$durationHour : $durationMinute'),
              onTap: () {
                // showCupertinoModalPopup<void>(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return _buildBottomPicker(
                //       CupertinoTimerPicker(
                //           mode: CupertinoTimerPickerMode.hm,
                //           onTimerDurationChanged: (duration){
                //             print("${duration.inHours.remainder(60)} : ${duration.inMinutes.remainder(60)}");
                //             // durationHour = duration.inHours.remainder(60);
                //             // durationMinute = duration.inMinutes.remainder(60);
                //             setState(() {
                //               durationHour = duration.inHours.remainder(60);
                //               durationMinute = duration.inMinutes.remainder(60);
                //             });
                //       }),
                //     );
                //   },
                // );
                showPickerNumber(context);
              },
            ),
            Text("コメント！"),
            TextField(
              onChanged: (value){
                comment = value;
              },
            ),
            RoundedButton(buttonColor: Colors.red, buttonTitle: "登録！！", onPressed: (){
              // print("$userName : $universityName : $comment : ${loggedInUser!.uid}");
              _firestore.collection("test-studyPosts").add({
                // "uid": loggedInUser!.uid,
                "subject": subject,
                "textbook": textbook,
                "durationHour": durationHour,
                "durationMinute": durationMinute,
                "comment" : comment,
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
  double _kPickerSheetHeight = 216.0;
  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
//
showPickerNumber(BuildContext context) {
  new Picker(
      adapter: NumberPickerAdapter(data: [
        NumberPickerColumn(begin: 0, end: 24),
        NumberPickerColumn(begin: 0, end: 59),
      ]),
      delimiter: [
        PickerDelimiter(child: Container(
          width: 30.0,
          alignment: Alignment.center,
          child: Icon(Icons.more_vert),
        ))
      ],
      hideHeader: true,
      title: new Text("Please Select"),
      onConfirm: (Picker picker, List value) {
        print(value.toString());
        print(picker.getSelectedValues());
        print(value[0]);
        durationHour = value[0];
        durationMinute = value[1];
      }
  ).showDialog(context);
}