import 'package:flutter/material.dart';
import '../models/Chat.dart';
import '../models/ChatMessage.dart';
import 'message_screen.dart';
import 'your_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'search_friends_screen.dart';

class FriendsListScreen extends StatefulWidget {
  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {

  final _auth = FirebaseAuth.instance;
  var loggedInUser;

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser;
      loggedInUser = user;
      print(loggedInUser);
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
        backgroundColor: Colors.lightBlueAccent,
        title: Text("チャット一覧")
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: chatsData.length,
                  itemBuilder: (context,index)=> ChatCard(
                    chatsData[index],
                    (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=> MessageScreen())
                      );
                    }
                  ),
              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context)=> SearchFriendsScreen())
          );
        },
        child: Icon(Icons.person_add_alt),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  ChatCard(this.chat,this.press);

  final Chat chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding*0.75),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius:24,
                  backgroundImage: AssetImage(chat.image),
                ),
                if(chat.isActive) Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 16,
                    width: 16,
                      decoration: BoxDecoration(
                        color:Colors.pink,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: 3
                        )
                      ),
                  ),
                )
              ],
            ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.name,
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                            chat.lastMessage,
                          maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
            ),
            InkWell(
                 onTap: (){
                   Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context)=> YourInfoScreen())
                   );
                 },
                child: Icon(Icons.account_box_outlined)
            )
          ],
        ),
      ),
    );
  }
}


//FIXME constants.dartへ
const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);
const kDefaultPadding = 20.0;


//FIXME class constants.dartへ
class FillOutlineButton extends StatelessWidget {
  const FillOutlineButton({
    Key? key,
    this.isFilled = true,
    required this.press,
    required this.text,
  }) : super(key: key);

  final bool isFilled;
  final VoidCallback press;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: Colors.white),
      ),
      elevation: isFilled ? 4 : 0,
      color: isFilled ? Colors.white : Colors.transparent,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: isFilled ? kContentColorLightTheme : Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
}









