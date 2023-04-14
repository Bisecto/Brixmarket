import 'package:flutter/material.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../core/preloader.dart';
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
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      SizedBox(height: 48, child: Preloader.loadingWidget()));
            }
            Insight? insight = snap.data;

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
                              child: insight?.data?.viewsByDay4Month == null
                                  ? const SizedBox.shrink()
                                  : ViewStatGraph(
                                      views: insight?.data?.viewsByDay4Month),
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
                              child: insight?.data?.savesByDay4Month == null
                                  ? const SizedBox.shrink()
                                  : ViewStatGraph(
                                      views: insight?.data?.savesByDay4Month),
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
                weight: FontWeight.w400,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
