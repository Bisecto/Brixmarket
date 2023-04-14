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
          accessor: (SByDay4Month viewData) => viewData.counts,
        ),
        'Views': Variable(
          accessor: (SByDay4Month viewData) => viewData.day as int,
        ),
      },
      marks: [
        IntervalMark(
          elevation: ElevationEncode(value: 0, updaters: {
            'tap': {true: (_) => 5}
          }),
          color: ColorEncode(value: Colors.blue[300], updaters: {
            'tap': {false: (color) => color.withAlpha(100)}
          }),
        )
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      selections: {'tap': PointSelection(dim: Dim.x)},
      tooltip: TooltipGuide(),
      crosshair: CrosshairGuide(),
    ));
  }
}
