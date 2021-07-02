import 'package:flutter/material.dart';
import 'package:template_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:template_app/screens/users_control/user_details.dart';
import 'package:template_app/screens/welcome_screen.dart';


final _firestore =
    FirebaseFirestore.instance; //MessageStreamをRefactorするために外に出した
late User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController =
      TextEditingController(); // テキスト入力に関するアクションを設定できるコントローラー
  // final _firestore = FirebaseFirestore.instance;
  // late User? loggedInUser; // どのクラス内でもUserが使えるようんグローバル変数にした。
  late String messageText;

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () { Navigator.pushNamed(context, WelcomeScreen.id); }, icon: Icon(Icons.home),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushNamed(context, UserDetails.id);
                // _auth.signOut();
                // Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller:
                          messageTextController, // TextEditingController呼び出し
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      // messageText + loggedInUser
                      messageTextController.clear(); // ボタンを押した後に文字が消える
                      _firestore.collection("messages").add({
                        "text": messageText,
                        "sender": loggedInUser!.email,
                        "time": DateTime.now() // 投稿順に並ぶようにタイムスタンプを追加
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //firebaseから受け取るのがQuerySnapshot型のデータのため
      stream: _firestore
          .collection("messages")
          .orderBy('time', descending: true)
          .snapshots(), //timeの降順になる
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs; //このdataはflutterからのasyncsnapshot
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            // final data = Map<String, String>.from(message.data);
            final messageText =
                message.get('text'); //このdataはFirebaseからのDocumentSnapshot
            final messageSender = message.get('sender');
            final currentUser = loggedInUser!.email;
            // if(currentUser == messageSender){ //このようにif分岐してもいいけど、、、
            //   final messageBubble = MessageBubble(sender: messageSender, text: messageText, isMe: true);
            //   messageBubbles.add(messageBubble);
            // }else{
            //   final messageBubble = MessageBubble(sender: messageSender, text: messageText, isMe: false);
            //   messageBubbles.add(messageBubble);
            // }
            final messageBubble = MessageBubble(
                sender: messageSender,
                text: messageText,
                isMe: currentUser == messageSender); //この方がきれい
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true, // 常に最新のメッセージが下に固定されるようになる
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
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

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key, required this.sender, required this.text, required this.isMe})
      : super(key: key);
  final String sender, text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          Material(
            elevation: 5.0,
            // borderRadius: BorderRadius.circular(25),
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(30) : Radius.circular(0),
              topRight: !isMe ? Radius.circular(30) : Radius.circular(0),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "$text",
                style: TextStyle(
                    fontSize: 15, color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
