import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: UserList.length,
          itemBuilder: (BuildContext context, int index) {
            final userData = UserList[index];
            return Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all( Radius.circular(50.0)),
                            border: Border.all(
                              color: BorderColors[index%5], // ５パターンの色で回す
                              width: 3.0,
                            ),
                            image: DecorationImage(
                              image: ExactAssetImage("images/${userData.image}.png"),
                              fit: BoxFit.contain
                            )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(userData.userName, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all( Radius.circular(10.0)),
                                  color: Colors.red,
                                ),
                                child: Text(userData.subject, style: TextStyle(fontSize: 20),)
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8,),
                    Text("「${userData.textbook}」", style: TextStyle(fontSize: 17),),
                    SizedBox(height: 10,),
                    Text(userData.duration, style: TextStyle(fontSize: 37),)
                  ],
                ),
              ),
            );
          },
        ),
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

List BorderColors = [
  Colors.purple,
  Colors.lightBlue,
  Colors.greenAccent,
  Colors.yellow,
  Colors.deepOrange,
];