import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("user details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // ★3 `List<DocumentSnapshot>`をsnapshotから取り出す。
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return Center(child: Text(documents[0]["userName"]));
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
  Future<QuerySnapshot> getUserData() async {
    String currentUid = FirebaseAuth.instance.currentUser!.uid;
    // print("今のユーザーIDは、$currentUid です");
    var querySnapshot = await FirebaseFirestore.instance
        .collection("userDetails")
        .where('uid', isEqualTo: currentUid)
        .get();
    return querySnapshot; //QuerySnapshot(条件に一致したdocumentsの集まり)
  }
}