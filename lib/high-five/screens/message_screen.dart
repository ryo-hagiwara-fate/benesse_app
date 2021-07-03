import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/ChatMessage.dart';

//FIXME constants.dartへ
const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);
const kDefaultPadding = 20.0;



class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("images/user_3.png"),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text("Hagiwara"),
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.video_call))
        ],
      ),
      body: MessageBody(),
    );
  }
}


//FIXME ファイル分ける
class MessageBody extends StatefulWidget {
  @override
  _MessageBodyState createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView.builder(
                  itemCount: demeChatMessages.length ,
                  itemBuilder: (context,index) => Message(demeChatMessages[index])
              ),
            )
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal:kDefaultPadding,
            vertical: kDefaultPadding /2
          ),
          child: SafeArea(
            child: Row(
              children: [
                // Icon(Icons.mic,color:kPrimaryColor),
                // SizedBox(width: kDefaultPadding),
                Expanded(child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color:kPrimaryColor.withOpacity(0.05),
                    borderRadius:BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: TextField(
                        decoration: InputDecoration(
                            hintText: "メッセージを入力",
                            border: InputBorder.none
                        ),
                      )),
                      FlatButton(
                          onPressed: (){},
                          child: Icon(Icons.send))
                    ],
                  )
                )
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Message extends StatelessWidget {
  Message(this.message);
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isSender ? MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top:kDefaultPadding),
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding *0.75,
            vertical: kDefaultPadding/2
          ),
            decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(30)
            ),
            child: Text(
                "Chat Text",
                style: TextStyle(color: Colors.white),
            )
        )
      ],
    );
  }
}

