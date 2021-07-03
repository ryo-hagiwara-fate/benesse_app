import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:template_app/components/rounded_button.dart';
import 'package:template_app/high-five/userControl/login_screen.dart';
import 'userControl/registration_screen.dart';



class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen"; // static宣言された変数は、宣言されたクラスに紐づいていることになる。。はず。。
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  } //initState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: "logo",
                    child: Container(
                      // color: Colors.white,
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                    ),
                  ),
                  Text("はいふぁいぶ！", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),)
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundedButton(
                buttonColor: Colors.lightBlueAccent,
                buttonTitle: "Log In",
                onPressed: () => {Navigator.pushNamed(context, LoginScreen.id)},
              ),
              RoundedButton(
                buttonColor: Colors.blueAccent,
                buttonTitle: "Register",
                onPressed: () =>
                {Navigator.pushNamed(context, RegistrationScreen.id)},
              ),
            ]),
      ),
    );
  }
}