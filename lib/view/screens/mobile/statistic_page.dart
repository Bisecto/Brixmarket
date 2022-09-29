import 'package:flutter/material.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../models/insight_model.dart';
import '../../../utils/utils.dart';
import '../../widgets/appbar_menus.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/stat_graph.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  bool isStat = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'Analytics',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: FutureBuilder(
          future: cPropCtrl.getInsight(),
          builder: (context, AsyncSnapshot snap) {
            Insight? insight = snap.data;
            dnd(insight.toString() + '------------------ 0');
            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: [
                const SizedBox(height: 20),
                const CustomText(
                  color: Colors.black,
                  size: 16,
                  text: 'See real time progression of your ads',
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 30),
                insight == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isStat = true;
                              });
                            },
                            child: const SizedBox(
                              height: 190,
                              child: Material(
                                  elevation: 3,
                                  type: MaterialType.card,
                                  child: Center(
                                    child: CustomText(
                                      text: 'No data is captured yet',
                                      color: Colors.blueGrey,
                                      weight: FontWeight.bold,
                                      size: 16,
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 400,
                            child: Material(
                                elevation: 3,
                                type: MaterialType.card,
                                child: Center(
                                  child: CustomText(
                                    text: 'No records',
                                    color: Colors.blueGrey,
                                    weight: FontWeight.bold,
                                    size: 16,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                         // InkWell(onTap: () => cPropCtrl.sideNavIndex.value = 4, child: Image.asset('assets/images/proplan.png')),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: 'Unique Views',
                            color: Colors.black,
                            weight: FontWeight.w700,
                            size: 16,
                          ),
                          SizedBox(
                              height: 170,
                              width: double.infinity,
                              child: Material(
                                  elevation: 35,
                                  type: MaterialType.card,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            statSummary('Last 24 Hrs', count: insight.today, change: insight.dayChange, percent: insight.dayPercent),
                                            Container(color: Colors.grey.shade300, height: 60, width: 2),
                                            statSummary('Last 7 Days', count: insight.thisWeek, change: insight.weekChange, percent: insight.weekPercent),
                                            Container(color: Colors.grey.shade300, height: 60, width: 2),
                                            statSummary('Last 30 Days', count: insight.thisMonth, change: insight.monthChange, percent: insight.monthPercent),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )))
                        ],
                      ),
                const SizedBox(height: 30),
                insight == null
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CustomText(
                            text: 'Activity Progression',
                            color: Colors.black,
                            weight: FontWeight.w700,
                            size: 16,
                          ),
                          SizedBox(height: 5),
                          CustomText(
                            text: 'Nam dapibus finibus nisl',
                            color: Colors.blueGrey,
                            weight: FontWeight.w500,
                            size: 14,
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                insight == null
                    ? const SizedBox.shrink()
                    : SizedBox(
                        height: 550,
                        width: double.infinity,
                        child: Material(
                            elevation: 30,
                            type: MaterialType.card,
                            child: Container(
                              height: 270,
                              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 230, 228, 228), width: 0.4)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      graphSummary('DAILY', count: insight.today, change: insight.dayChange),
                                      graphSummary('WEEKLY', count: insight.thisWeek, change: insight.weekChange),
                                      graphSummary('MONTHLY', count: insight.thisMonth, change: insight.monthChange),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 300,
                                    width: double.infinity,
                                    child: insight.viewsByDay == null ? const SizedBox.shrink() : ViewStatGraph(views: insight.viewsByDay!),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: const [
                                          CustomText(
                                            text: 'monthly',
                                            color: Color.fromARGB(255, 16, 17, 16),
                                            weight: FontWeight.bold,
                                            size: 16,
                                          ),
                                          SizedBox(width: 5),
                                          Icon(Icons.expand_more, size: 22)
                                        ],
                                      ),
                                      Row(
                                        children: const [
                                          CustomText(
                                            text: 'view details',
                                            color: Color.fromARGB(255, 34, 59, 72),
                                            weight: FontWeight.bold,
                                            size: 16,
                                          ),
                                          SizedBox(width: 5),
                                          Icon(Icons.arrow_forward_ios, size: 14)
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                const SizedBox(
                  height: 20,
                ),
                // insight == null
                //     ? const SizedBox.shrink()
                //     : Stack(
                //         children: [
                //           // Container(
                //           //   height: 150,
                //           //   width: double.infinity,
                //           //   alignment: Alignment.center,
                //           //   decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/pro_plan.png'), fit: BoxFit.contain)),
                //           // ),
                //           const Positioned(
                //             top: 30,
                //             right: 38,
                //             child: CustomText(
                //               text: 'Upgrade to PRO Plan',
                //               color: Colors.white,
                //               weight: FontWeight.bold,
                //               size: 16,
                //             ),
                //           ),
                //           const Positioned(
                //             top: 55,
                //             right: 20,
                //             child: CustomText(
                //               text: 'For better views and engagements',
                //               color: Colors.white,
                //               weight: FontWeight.w400,
                //               size: 11,
                //             ),
                //           ),
                //         ],
                //       ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
    );
  }

  graphSummary(String durationText, {required int? count, required int? change}) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: (change ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: durationText,
                    color: Colors.blueGrey,
                    weight: FontWeight.w500,
                    size: 14,
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                    text: '${count ?? '0'}',
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: 14,
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  statSummary(String durationText, {int? count, int? change, double? percent}) {
    return Column(
      children: [
        CustomText(
          text: (count ?? 0).toString(),
          color: Colors.black,
          weight: FontWeight.w700,
          size: 18,
        ),
        const SizedBox(height: 16),
        CustomText(text: durationText, color: Colors.black, weight: FontWeight.w500, size: 14),
        const SizedBox(width: 10),
        Icon(
          (change ?? 0) > 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          color: (change ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
          size: 36,
        ),
        const SizedBox(width: 5),
        CustomText(
          text: '${percent ?? 0.0}%',
          color: (change ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
          weight: FontWeight.w700,
          size: 14,
        ),
      ],
    );
  }
}
