import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

//https://pub.dev/packages/pie_chart

class ThirdDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: PieChart(
          dataMap: dataMap,
        )
      ),
    );
  }
}

Map<String, double> dataMap = {
  "Flutter": 5,
  "React": 3,
  "Xamarin": 2,
  "Ionic": 2,
};
