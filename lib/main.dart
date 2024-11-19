import 'package:flutter/material.dart';
import 'package:pie_chart/custom_pie_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPieChart(
              data: [
                {'Hello': 50},
                {'Bye': 50}
              ],
              chartTitle: 'Testing',
              showTitle: true,
              startDegreeOffset: 250,
              barRadius: 25,
            ),
            SizedBox(
              height: 20,
            ),
            Legend(
              data: [
                {'Hello': 50},
                {'Bye': 50}
              ],
              colorRadius: 5,
            )
          ],
        )),
      ),
    );
  }
}
