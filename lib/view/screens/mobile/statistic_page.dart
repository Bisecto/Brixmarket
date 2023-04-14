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
  String propertyListed = '0';
  String totalViews = '0';
  String totalImpressions = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'Analytics',
        ),
        actions: const [
          AppBarMenu(
            logout: true,
            myAccount: true,
            propertyIDS: [],
          )
        ],
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
                const SizedBox(height: 30),
                Center(
                  child: CustomText(
                    color: Pallet.secondaryColor,
                    size: 18,
                    text: 'your insights'.toUpperCase(),
                    maxLines: 2,
                    weight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15.5),
                const Divider(),
                const SizedBox(height: 20.5),
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          statSummary('Properties\n Listed', propertyListed),
                          statSummary('Total Views\n', totalViews),
                          statSummary('Total \nImpressions', totalImpressions),
                        ],
                      ),
                const SizedBox(height: 20.5),
                const Divider(),
                const SizedBox(height: 20.5),
                const Center(
                  child: CustomText(
                    text: 'Property views (this month)',
                    color: Colors.black,
                    weight: FontWeight.w700,
                    size: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Material(
                      elevation: 2,
                      type: MaterialType.card,
                      child: Container(
                        height: 270,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 30),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 230, 228, 228),
                                width: 0.4)),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: insight!.viewsByDay == null
                                  ? const SizedBox.shrink()
                                  : ViewStatGraph(views: insight.viewsByDay!),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(height: 20.5),
                const Divider(),
                const SizedBox(height: 20.5),
                const Center(
                  child: CustomText(
                    text: 'Saves (this month)',
                    color: Colors.black,
                    weight: FontWeight.w700,
                    size: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Material(
                      elevation: 2,
                      type: MaterialType.card,
                      child: Container(
                        height: 270,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 30),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 230, 228, 228),
                                width: 0.4)),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: insight.viewsByDay == null
                                  ? const SizedBox.shrink()
                                  : ViewStatGraph(views: insight.viewsByDay!),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
    );
  }

  graphSummary(String durationText,
      {required int? count, required int? change}) {
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
                      color: (change ?? 0) > 0
                          ? const Color.fromARGB(255, 42, 106, 44)
                          : Colors.red,
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

  statSummary(String title, String value) {
    return Column(
      children: [
        CustomText(
          text: title,
          color: Colors.black,
          weight: FontWeight.w600,
          maxLines: 2,
          size: 14,
        ),
        const SizedBox(
          height: 10,
        ),
        Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(8),
          type: MaterialType.card,
          color: Pallet.secondaryColor,
          child: Container(
            height: 65,
            width: 112,
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: CustomText(
                text: value,
                color: Colors.white,
                weight: FontWeight.w700,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
