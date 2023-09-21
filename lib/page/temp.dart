import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jsonString = '''
      [
        {
          "name": "Fule - SSMBW",
          "value": 100.0
        },
        {
          "name": "Food - SSMBW",
          "value": 37401.0
        }
      ]
    ''';

    final List<Map<String, dynamic>> data = jsonDecode(jsonString);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('LineChart Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          
          
           LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: data
                      .map(
                        (entry) => FlSpot(
                          data.indexOf(entry).toDouble(),
                          entry['value'].toDouble(),
                        ),
                      )
                      .toList(),
                  isCurved: false,
                  dotData: FlDotData(show: false),
                  // Use an array of colors for multiple lines if needed
                ),
              ],
              borderData: FlBorderData(
                border: Border(
                  bottom: BorderSide(),
                  left: BorderSide(),
                ),
              ),
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  // getTextStyles: (value) => const TextStyle(
                  //   color: Colors.black,
                  //   fontWeight: FontWeight.bold,
                  //   fontSize: 12,
                  // ),
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return data[0]['name'];
                      case 1:
                        return data[1]['name'];
                      default:
                        return data[0][''];
                    }
                  },
                )),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
