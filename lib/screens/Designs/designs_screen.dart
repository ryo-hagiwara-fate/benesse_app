import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'first_design.dart';
import 'second_design.dart';
import 'third_design.dart';
import 'fourth_design.dart';
import 'fifth_design.dart';

class DesignsScreen extends StatefulWidget {

  static String id = "design_screen";
  @override
  _DesignsScreenState createState() => _DesignsScreenState();
}

class _DesignsScreenState extends State<DesignsScreen> {

  int _currentIndex = 0;
  final _pageWidgets = [
    FirstDesign(),
    SecondDesign(),
    ThirdDesign(),
    FourthDesign(),
    FifthDesign()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('デザインサンプル'),
        centerTitle: true,
      ),
      body: _pageWidgets.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavyBar(
        items: [
          BottomNavyBarItem(icon: Icon(Icons.home), title: Text("GridView", style: TextStyle(fontSize: 18),), activeColor: Colors.lightBlueAccent, textAlign: TextAlign.center),
          BottomNavyBarItem(icon: Icon(Icons.cake), title: Text("ListView", style: TextStyle(fontSize: 18),), activeColor: Colors.deepPurple, textAlign: TextAlign.center),
          BottomNavyBarItem(icon: Icon(Icons.catching_pokemon), title: Text("First", style: TextStyle(fontSize: 18),), activeColor: Colors.deepOrange, textAlign: TextAlign.center),
          BottomNavyBarItem(icon: Icon(Icons.local_drink), title: Text("First", style: TextStyle(fontSize: 18),), activeColor: Colors.blueGrey, textAlign: TextAlign.center),
          BottomNavyBarItem(icon: Icon(Icons.handyman), title: Text("First", style: TextStyle(fontSize: 18),), activeColor: Colors.brown, textAlign: TextAlign.center),
        ],
        selectedIndex: _currentIndex,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        itemCornerRadius: 24,
        showElevation: true,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'First'),
      //     BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: 'Second'),
      //   ],
      //   currentIndex: _currentIndex,
      //   fixedColor: Colors.blueAccent,
      //   onTap: _onItemTapped,
      //   type: BottomNavigationBarType.fixed,
      // ),
    );
  }
  // void _onItemTapped(int index) => setState(() => _currentIndex = index );
}
