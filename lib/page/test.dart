import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  // Generate some dummy data for the cahrt
  // This will be used to draw the red line
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the blue line
  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 350,
            child: 
            
            
            LineChart(
              LineChartData(
                borderData: FlBorderData(
                    border:
                        const Border(bottom: BorderSide(), left: BorderSide())),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      String text = '';
                      switch (value.toInt()) {
                        case 1:
                          text = 'Jan';
                          break;
                        case 3:
                          text = 'Mar';
                          break;
                        case 5:
                          text = 'May';
                          break;
                        case 7:
                          text = 'Jul';
                          break;
                        case 9:
                          text = 'Sep';
                          break;
                        case 11:
                          text = 'Nov';
                          break;
                      }

                      return Text(
                        text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    },
                  )),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      String text = '';
                      switch (value.toInt()) {
                        case 1:
                          text = 'Jan';
                          break;
                        case 3:
                          text = 'Mar';
                          break;
                        case 5:
                          text = 'May';
                          break;
                        case 7:
                          text = 'Jul';
                          break;
                        case 9:
                          text = 'Sep';
                          break;
                        case 11:
                          text = 'Nov';
                          break;
                      }

                      return Text(
                        text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    },
                  )),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                lineBarsData: [
                  // The red line
                  LineChartBarData(
                    spots: dummyData1,
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.indigo,
                  ),
                  // The orange line
                  LineChartBarData(
                    spots: dummyData2,
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.red,
                  ),
                  // The blue line
                  LineChartBarData(
                    spots: dummyData3,
                    isCurved: false,
                    barWidth: 3,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
