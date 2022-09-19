import 'package:brixmarket/models/insight_model.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class ViewStatGraph extends StatelessWidget {
  const ViewStatGraph({Key? key, required this.views}) : super(key: key);
  final dynamic views;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Chart(
      data: views,
      variables: {
        'Day': Variable(
          accessor: (ViewData viewData) => viewData.createdAt,
        ),
        'Views': Variable(
          accessor: (ViewData viewData) => viewData.views as num,
        ),
      },
      elements: [IntervalElement(color: ColorAttr(value: Colors.red))],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
    ));
  }
}
