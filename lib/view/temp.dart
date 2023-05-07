import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyChart extends StatefulWidget {
  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 280.0,
                child: AspectRatio(
                  aspectRatio: 1.4,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 12,
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 10,
                          barRods: [
                            BarChartRodData(
                              toY: 10,
                              color: Colors.red,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 5,
                              color: Colors.green,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 3,
                              color: Colors.orange,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: 2,
                              color: Colors.blue,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: 6,
                              color: Colors.pink,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 1,
                              color: Colors.red,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 5,
                              color: Colors.green,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 3,
                              color: Colors.orange,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: 2,
                              color: Colors.blue,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: 6,
                              color: Colors.pink,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 1,
                              color: Colors.red,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 5,
                              color: Colors.green,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 3,
                              color: Colors.orange,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: 2,
                              color: Colors.blue,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: 6,
                              color: Colors.pink,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 1,
                              color: Colors.red,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 5,
                              color: Colors.green,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 3,
                              color: Colors.orange,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: 2,
                              color: Colors.blue,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: 6,
                              color: Colors.pink,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 1,
                              color: Colors.red,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 5,
                              color: Colors.green,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 3,
                              color: Colors.orange,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: 2,
                              color: Colors.blue,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: 6,
                              color: Colors.pink,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 1,
                              color: Colors.red,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 5,
                              color: Colors.green,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 3,
                              color: Colors.orange,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: 2,
                              color: Colors.blue,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: 6,
                              color: Colors.pink,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 7,
                          barRods: [
                            BarChartRodData(
                              toY: 12,
                              color: Colors.greenAccent,
                              width: 16,
                              backDrawRodData: BackgroundBarChartRodData(
                                show: true,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                      ],
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
