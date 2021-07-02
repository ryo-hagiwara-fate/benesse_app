import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:template_app/components/rounded_button.dart';
import 'package:template_app/screens/users_control/edit_user_details.dart';

import '../chat_screen.dart';

// 参考 : https://qiita.com/kazuhideoki/items/ffe1b92aa17565ef8e4c


final _firestore = FirebaseFirestore.instance;
late User? loggedInUser;

class UserDetails extends StatefulWidget {
  static String id = "user_details_screen";
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _auth = FirebaseAuth.instance;
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () { Navigator.pushNamed(context, ChatScreen.id); }, icon: Icon(Icons.chat_bubble),),
        title: Text("user details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("${snapshot.data!["userName"]}がやってきた！");
              return Center(child: Column(
                children: [
                  Text(snapshot.data!["userName"], style: TextStyle(fontSize: 30),),
                  Text(snapshot.data!["universityName"], style: TextStyle(fontSize: 30),),
                  Text(snapshot.data!["comment"], style: TextStyle(fontSize: 30),),
                  RoundedButton(
                    buttonColor: Colors.blueAccent,
                    buttonTitle: "プロフィール修正！",
                    onPressed: () =>
                    {Navigator.pushNamed(context, EditUserDetailsScreen.id)},
                  ),
                ],
              ));
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
    return querySnapshot; //QuerySnapshot(条件に一致したdocumentsの集まり)
  }

  //id指定ではなくwhereで取り出す場合
  // Future<QuerySnapshot> getUserData() async {
  //   String currentUid = FirebaseAuth.instance.currentUser!.uid;
  //   // print("今のユーザーIDは、$currentUid です");
  //   var querySnapshot = await FirebaseFirestore.instance
  //       .collection("userDetails")
  //       .where('uid', isEqualTo: currentUid)
  //       .get();
  //   return querySnapshot; //QuerySnapshot(条件に一致したdocumentsの集まり)
  // }
}