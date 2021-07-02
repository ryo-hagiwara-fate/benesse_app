import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'first_design.dart';

class UserDetailsInDesignScreen extends StatelessWidget {
  static String id = "user_details_in_design_screen";
  final User userData;
  UserDetailsInDesignScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
            // tileMode: TileMode.repeated, // repeats the gradient over the canvas
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
                          child: Center(child: Text(userData.userName, style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30,
                          ),)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              UserStatusDesign(userData.subject, "教科"),
                              UserStatusDesign(userData.textbook, "教材"),
                              UserStatusDesign(userData.duration, "学習時間")
                            ],
                          ),
                        ),
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
                            image: ExactAssetImage("images/${userData.image}.png"),
                            fit: BoxFit.contain
                        )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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