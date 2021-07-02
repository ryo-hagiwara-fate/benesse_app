import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

//参考↓
//https://pub.dev/packages/fl_chart

class FourthDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: ListView(
        itemExtent: 330,
        children: <Widget>[
          Card(
            color: Color(0xff2c4260),
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 0.0,
                pieTouchData: PieTouchData(enabled: true),
                sections: [
                  MyPieData(10, "英語", Colors.deepOrange),
                  MyPieData(13, "数学", Colors.blue),
                  MyPieData(15, "国語", Colors.green),
                  MyPieData(8, "化学", Colors.purpleAccent),
                  MyPieData(17, "日本史", Colors.blueGrey),
                ],
              ),
              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Color(0xff2c4260),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
                barTouchData: BarTouchData(
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.transparent,
                    tooltipPadding: const EdgeInsets.all(0),
                    tooltipMargin: 8,
                    getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                        ) {
                      return BarTooltipItem(
                        rod.y.round().toString(),
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (value) => const TextStyle(
                        color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                    margin: 20,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return 'Mn';
                        case 1:
                          return 'Te';
                        case 2:
                          return 'Wd';
                        case 3:
                          return 'Tu';
                        case 4:
                          return 'Fr';
                        case 5:
                          return 'St';
                        case 6:
                          return 'Sn';
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(showTitles: false),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(y: 8, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(y: 14, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(y: 15, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(y: 13, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PieChartCategory extends StatelessWidget {
  final String categoryName;
  PieChartCategory(this.categoryName);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        padding: EdgeInsets.all(3),
        child: Text(categoryName, style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

PieChartSectionData MyPieData(double figure, String categoryTitle, pieColor) {
  return PieChartSectionData(value: figure, showTitle: true, color: pieColor, radius: 150,
    title: figure.toString(), titleStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    badgeWidget: PieChartCategory(categoryTitle), badgePositionPercentageOffset: .98,
  );
}