import 'package:brixmarket/models/insight_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ViewStatGraph extends StatelessWidget {
  const ViewStatGraph({
    Key? key,
    required this.views,
    required this.title,
  }) : super(key: key);
  final List<ViewsByDay4Month>? views;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 1000,
        height: 330.0,
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 4),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 10,
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false, interval: 10),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false, interval: 10),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, interval: 10),
              ),
            ),
            borderData: FlBorderData(
              show: true,
            ),
            barGroups: views!
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
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;
}
