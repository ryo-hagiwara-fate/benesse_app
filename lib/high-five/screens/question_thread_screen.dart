import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_button/like_button.dart';
import 'package:template_app/high-five/screens/question_details_screen.dart';
import 'package:template_app/high-five/screens/question_post_screen.dart';
import 'package:template_app/high-five/screens/study_post_screen.dart';

// 参考 : https://qiita.com/kazuhideoki/items/ffe1b92aa17565ef8e4c
// イイネボタンhttps://pub.dev/packages/like_button#like_button


final _firestore = FirebaseFirestore.instance;
late User? loggedInUser;

class QuestionThreadScreen extends StatefulWidget {
  static String id = "study_thread_screen";
  @override
  _QuestionThreadScreenState createState() => _QuestionThreadScreenState();
}

class _QuestionThreadScreenState extends State<QuestionThreadScreen> {
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      loggedInUser = user;
      print(loggedInUser!.email);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.pushNamed(context, QuestionPostScreen.id); },
        child: Icon(Icons.contact_support, size: 38,),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StudyThread(),
          ],
        ),
      ),
    );
  }
}

class StudyThread extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //firebaseから受け取るのがQuerySnapshot型のデータのため
      stream: _firestore
          .collection("test-questionPosts")
          .orderBy('time', descending: true)
          .snapshots(), //timeの降順になる
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final posts = snapshot.data!.docs; //このdataはflutterからのasyncsnapshot
          List<PostCard> postCards = [];
          for (var studyData in posts) {
            final currentUser = loggedInUser!.email;
            final postCard = PostCard(
                sender: studyData.get('email'),
                subject: studyData.get('subject'),
                unitName: studyData.get('unitName'),
                questionText: studyData.get('questionText'),
                isMe: currentUser == studyData.get('email'),
                likes: studyData.get('likes'),
                documentId: studyData.id,
                userName: studyData.get('userName'),
                // userName: studyData.get(''),
            ); //この方がきれい
            postCards.add(postCard);
          }
          return Expanded(
            child: ListView(
              reverse: false, // 常に最新のメッセージが下に固定されるようになる
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: postCards,
            ),
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

class PostCard extends StatelessWidget {
  const PostCard(
      {Key? key, required this.sender, required this.subject, required this.isMe, required this.unitName, required this.likes, required this.documentId, required this.questionText, required this.userName})
      : super(key: key);
  final String sender, subject, unitName, documentId, questionText, userName;
  final int likes;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){ Navigator.push(context,
          MaterialPageRoute(builder: (context)=>QuestionDetailsScreen(userName: userName, subject: subject, unitName: unitName, questionText: questionText, likes: likes))); },
      child: Card(
        color: Color(0xffCDFFCE),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      border: Border.all(
                        color: Colors.black, // ５パターンの色で回す
                        width: 1,
                      ),
                      image: DecorationImage(
                          image: ExactAssetImage("images/masuo.png"),
                          fit: BoxFit.contain
                      )
                  ),
                ),
                Container(
                    child: Center(child: Text(userName)),
                  width: 70,
                ),
              ],
            ),
            SizedBox(width: 5,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: screen.width*0.68,
                  child: Column(
                    children: <Widget>[
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(subject, style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),),
                            decoration: BoxDecoration(
                              color: Color(0xff69DBFF),
                              borderRadius: BorderRadius.all( Radius.circular(8.0)),
                          ),),
                          SizedBox(width: 10,),
                          Text(unitName, style: TextStyle(fontSize: 18),),
                        ],
                      ),
                      Divider(color: Colors.grey, thickness: 1,),
                      Text(questionText),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  // color: Colors.red,
                  alignment: Alignment.topLeft,
                  child: LikeButton(
                    // onTap: onLikeButtonTapped,
                    size: 30,
                    circleColor:
                    CircleColor(start: Colors.redAccent, end: Colors.red),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Colors.redAccent,
                      dotSecondaryColor: Colors.red,
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.redAccent : Colors.grey,
                        size: 25,
                      );
                    },
                    likeCount: likes,
                    countBuilder: (int? count, bool isLiked, String text) {
                      var color = isLiked ? Colors.redAccent : Colors.grey;
                      Widget result;
                      if (count == 0) {
                        result = Text(
                          "love",
                          style: TextStyle(color: color),
                        );
                      } else
                        result = Text(
                          text,
                          style: TextStyle(color: color),
                        );
                      return result;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.all(10.0),
    //   child: Column(
    //     crossAxisAlignment:
    //         isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Text(
    //         sender,
    //         style: TextStyle(
    //           fontSize: 12,
    //           color: Colors.black54,
    //         ),
    //       ),
    //       Material(
    //         elevation: 5.0,
    //         // borderRadius: BorderRadius.circular(25),
    //         borderRadius: BorderRadius.only(
    //           topLeft: isMe ? Radius.circular(30) : Radius.circular(0),
    //           topRight: !isMe ? Radius.circular(30) : Radius.circular(0),
    //           bottomLeft: Radius.circular(30),
    //           bottomRight: Radius.circular(30),
    //         ),
    //         color: isMe ? Colors.lightBlueAccent : Colors.white,
    //         child: Padding(
    //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    //           child: Text(
    //             "$subject",
    //             style: TextStyle(
    //                 fontSize: 15, color: isMe ? Colors.white : Colors.black),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    // }
  }
// Future<bool> onLikeButtonTapped(bool isLiked) async{
//   if(isLiked){
//     _firestore.collection("test-studyPosts").doc(documentId).update({
//       "likes": likes-1
//     });
//     return !isLiked;
//   }else{
//     _firestore.collection("test-studyPosts").doc(documentId).update({
//       "likes": likes+1
//     });
//     return !isLiked;
//   }
// }
}