import 'package:brixmarket/models/insight_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewStatGraph extends StatelessWidget {
  const ViewStatGraph({Key? key, required this.views}) : super(key: key);
  final dynamic views;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Monthly views analysis'),
          legend: Legend(isVisible: false),
          borderWidth: 2,
          series: <LineSeries<ViewsByDay4Month, String>>[
            LineSeries<ViewsByDay4Month, String>(
                dataSource: views,
                xValueMapper: (ViewsByDay4Month views, _) =>
                    views.day.toString(),
                yValueMapper: (ViewsByDay4Month views, _) =>
                    views.counts as int,
                xAxisName: 'Days',
                yAxisName: 'Views',
                dataLabelSettings: const DataLabelSettings(isVisible: true))
          ]),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final int sales;
}
