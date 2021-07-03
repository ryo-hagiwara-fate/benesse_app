import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:template_app/high-five/screens/dummy_screen1.dart';
import 'package:template_app/high-five/screens/firends_list_screen.dart';
import 'package:template_app/high-five/screens/question_post_screen.dart';
import 'package:template_app/high-five/screens/study_post_screen.dart';
import 'package:template_app/high-five/screens/your_info_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = "design_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  final _pageWidgets = [
    YourInfoScreen(),
    FriendsListScreen(),
    QuestionPostScreen(),
    StudyPostScreen(),
    DummyScreen1()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   leading: IconButton(onPressed: () { Navigator.pushNamed(context, HomeScreen.id); }, icon: Icon(Icons.home),),
      //   title: Text("user details"),
      //   centerTitle: true,
      // ),
      body: SafeArea(child: _pageWidgets.elementAt(_currentIndex)),
      bottomNavigationBar: BottomNavyBar(
        items: [
          BottomNavyBarItem(icon: Icon(Icons.home), title: Text("GridView", style: TextStyle(fontSize: 18),), activeColor: Colors.lightBlueAccent, textAlign: TextAlign.center),
          BottomNavyBarItem(icon: Icon(Icons.chat_outlined), title: Text("Chat", style: TextStyle(fontSize: 18),), activeColor: Colors.deepPurple, textAlign: TextAlign.center),
          BottomNavyBarItem(icon: Icon(Icons.catching_pokemon), title: Text("PieChart1", style: TextStyle(fontSize: 18),), activeColor: Colors.deepOrange, textAlign: TextAlign.center),
          BottomNavyBarItem(icon: Icon(Icons.local_drink), title: Text("fl_charts", style: TextStyle(fontSize: 18),), activeColor: Colors.blueGrey, textAlign: TextAlign.center),
          BottomNavyBarItem(icon: Icon(Icons.handyman), title: Text("First", style: TextStyle(fontSize: 18),), activeColor: Colors.brown, textAlign: TextAlign.center),
        ],
        selectedIndex: _currentIndex,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        itemCornerRadius: 24,
        showElevation: true,
      ),
    );
  }
}
