import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../userControl/add_user_details_screen.dart';
// import 'package:template_app/components/rounded_button.dart';
// import 'package:template_app/high-five/userControl/edit_user_details.dart';

import 'home_screen.dart';


final _firestore = FirebaseFirestore.instance;
late User? loggedInUser;

class FriendInfoScreen extends StatefulWidget {
  static String id = "user_details_screen";
  @override
  _FriendInfoScreen createState() => _FriendInfoScreen();
}

class _FriendInfoScreen extends State<FriendInfoScreen> {
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
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("${snapshot.data!["userName"]}がやってきた！");
              return Container(
                width: screen.width,
                height: screen.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      Color(0xffeeee00),
                      Color(0xffee0000)
                    ], // red to yellow
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: screen.height*0.3,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 60.0),
                                  child: Center(child: Text(snapshot.data!["userName"], style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30,
                                  ),)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      UserStatusDesign(snapshot.data!["universityName"], "志望大学"),
                                      UserStatusDesign(snapshot.data!["sex"], "性別"),
                                      UserStatusDesign(snapshot.data!["hobby"], "趣味"),
                                      UserStatusDesign(snapshot.data!["circle"], "入りたいサークル"),
                                    ],
                                  ),
                                ),
                                // IconButton(
                                //     onPressed: (){
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(builder: (context)=> AddUserDetailsScreen())
                                //       );
                                //     },
                                //     icon: Icon(Icons.edit)
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){ Navigator.pop(context); },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 280),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all( Radius.circular(60.0)),
                                border: Border.all(
                                  color: Colors.red, // ５パターンの色で回す
                                  width: 3.0,
                                ),
                                image: DecorationImage(
                                    image: ExactAssetImage("images/user_3.png"), //ユーザーアバター
                                    fit: BoxFit.contain
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
              //   Center(child: Column(
              //   children: [
              //     Text(snapshot.data!["userName"], style: TextStyle(fontSize: 30),),
              //     Text(snapshot.data!["universityName"], style: TextStyle(fontSize: 30),),
              //     Text(snapshot.data!["comment"], style: TextStyle(fontSize: 30),),
              //     RoundedButton(
              //       buttonColor: Colors.blueAccent,
              //       buttonTitle: "プロフィール修正！",
              //       onPressed: () =>
              //       {Navigator.pushNamed(context, EditUserDetailsScreen.id)},
              //     ),
              //   ],
              // ));
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
}

class UserStatusDesign extends StatelessWidget {
  final String data;
  final String listTitle;
  UserStatusDesign(this.data, this.listTitle);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(listTitle, style: TextStyle(fontSize: 20),),
      trailing: Text(data, style: TextStyle(fontSize: 20),),
    );
  }
}