import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/insight_model.dart';

class MyChart extends StatefulWidget {
  final List<ViewsByDay4Month>? views;

  const MyChart({Key? key, required this.views}) : super(key: key);

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                child: AspectRatio(
                  aspectRatio: 1.4,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 20,
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles:
                              SideTitles(showTitles: true, interval: 10),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                      ),
                      barGroups: widget.views!
                          .map(
                            (view) => BarChartGroupData(
                              x: int.parse(view.day.toString()),
                              barsSpace: 3,
                              groupVertically: true,
                              barRods: [
                                BarChartRodData(
                                  toY: double.parse(view.counts.toString()),
                                  color: Colors.pink,
                                  width: 16,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(3),
                                      topRight: Radius.circular(3)),
                                  backDrawRodData: BackgroundBarChartRodData(
                                    show: true,
                                    color: Colors.grey[200],
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
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
