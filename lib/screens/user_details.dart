import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User? loggedInUser;

class UserDetails extends StatefulWidget {
  static String id = "user_details_screen";
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _auth = FirebaseAuth.instance;
  // late Stream<QuerySnapshot> currentUserDetails;
  // List<DocumentSnapshot> userDetailsList = [];
  // Stream<QuerySnapshot> getStreamSnapshots(String collection) {
  //   return _firestore
  //       .collection(collection)
  //       .where("uid", isEqualTo: "${loggedInUser!.uid}")
  //       .orderBy('createdAt', descending: true) //後で消す
  //       .snapshots();
  // }
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      loggedInUser = user;
      print(loggedInUser!.email);
      print(loggedInUser!.uid);
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // currentUserDetails = getStreamSnapshots("userDetails");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UserDetailsDisplay(),
      ),
    );
  }
}

class UserDetailsDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("userDetails")
          .where("uid", isEqualTo: "${loggedInUser!.uid}")
          .orderBy('createdAt', descending: true) //後で消す
          .snapshots(),
      builder: (context, snapshot){
        print(loggedInUser);
        if(snapshot.hasData){
          final userDetails = snapshot.data!.docs;
          final currentUser = loggedInUser!.email;
          // for (var userDetail in userDetails) {
          //   final userName = userDetail.get('userName'); //このdataはFirebaseからのDocumentSnapshot
          // }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(userDetails[0].get("userName"))
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
