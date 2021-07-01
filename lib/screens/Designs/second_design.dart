import 'package:flutter/material.dart';

class SecondDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: ListView.builder(
        itemExtent: 120,
        itemCount: UserList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Center(
                child: ListTile(
                  onTap: (){ print("tapped"); },
                  leading: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.red,
                    backgroundImage: AssetImage("images/${UserList[index].image}.png"),
                  ),
                  title: Text(UserList[index].userName, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  trailing: Text(UserList[index].duration, style: TextStyle(fontSize: 20),),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}

class User {
  String userName, duration, image, subject, textbook;
  User(this.userName, this.duration, this.image, this.subject, this. textbook);
}

List UserList = <User>[
  User("フグ田", "6:13", "masuo", "国語", "ゴロゴ"),
  User("三宅", "2:78", "cat", "数学", "チャート式"),
  User("常田", "0:54", "fox", "英語", "ターゲット"),
  User("佐々木", "3:11", "gorilla", "数学", "チャート式"),
  User("大吉", "3:53", "raccoon", "物理", "良問の風"),
  User("鳩山", "1:42", "bird", "英語", "ぽれぽれ"),
  User("椎名", "2:13", "apple", "数学", "過去問"),
  User("越後", "4:34", "rice", "日本史", "一問一答"),
  User("鹿島", "1:12", "pig", "倫政", "資料集"),
];