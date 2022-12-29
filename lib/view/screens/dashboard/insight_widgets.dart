import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../core/preloader.dart';
import '../../../models/insight_model.dart';
import '../../../utils/utils.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/stat_graph.dart';

class InsightWidget extends StatelessWidget {
  const InsightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dashPadding = Get.width * 0.04;
    return Container(
      height: Get.height,
      child: Scrollbar(
        controller: cPropCtrl.scrollController2,
        isAlwaysShown: true,
        interactive: true,
        child: FutureBuilder(
            initialData: cPropCtrl.insight,
            future: cPropCtrl.getInsight(),
            builder: (context, AsyncSnapshot snap) {
              Insight? insight = snap.data;
              return ListView(
                shrinkWrap: true,
                controller: cPropCtrl.scrollController2,
                padding: EdgeInsets.fromLTRB(dashPadding, 0, dashPadding, 0),
                children: [
                  const SizedBox(height: 40),
                  const CustomText(text: 'Insight', color: Colors.black, weight: FontWeight.bold, size: 18),
                  const SizedBox(height: 40),
                  snap.connectionState == ConnectionState.waiting && !snap.hasData
                      ? SizedBox(
                          height: 400,
                          child: Material(
                              elevation: 3,
                              type: MaterialType.card,
                              child: Center(
                                child: Preloader.loadingWidget(),
                              )),
                        )
                      : insight == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 190,
                                  child: Material(
                                      elevation: 3,
                                      type: MaterialType.card,
                                      child: Center(
                                        child: CustomText(
                                          text: 'No data is captured yet',
                                          color: Colors.blueGrey,
                                          weight: FontWeight.w100,
                                          size: 14,
                                        ),
                                      )),
                                ),
                                const SizedBox(height: 20),
                                const SizedBox(
                                  height: 400,
                                  child: Material(
                                      elevation: 3,
                                      type: MaterialType.card,
                                      child: Center(
                                        child: CustomText(
                                          text: 'No records',
                                          color: Colors.blueGrey,
                                          weight: FontWeight.w100,
                                          size: 14,
                                        ),
                                      )),
                                ),
                                const SizedBox(height: 98),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LayoutBuilder(builder: (context, constraints) {
                                  double boxWidth = constraints.maxWidth;
                                  return SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        spacing: 16,
                                        runSpacing: 16,
                                        children: [
                                          SizedBox(
                                            width: isTabletDown() ? boxWidth : boxWidth * 0.5 - 8,
                                            child: FittedBox(
                                              child: Row(children: [
                                                Material(
                                                  elevation: 3,
                                                  type: MaterialType.card,
                                                  // borderRadius: 4,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: SizedBox(
                                                        width: boxWidth * 0.2,
                                                        height: isNotDeskTop() ? Get.width * 0.138 : Get.width * 0.103,
                                                        child: FittedBox(
                                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                const CustomText(
                                                                  text: 'Total Properties',
                                                                  color: Colors.black38,
                                                                  weight: FontWeight.bold,
                                                                  size: 10,
                                                                ),
                                                                const SizedBox(height: 16),
                                                                CustomText(
                                                                  text: insight.allProperties.toString(),
                                                                  color: Colors.black87,
                                                                  weight: FontWeight.bold,
                                                                  size: 18,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(width: 16),
                                                            const Icon(Icons.house, size: 28, color: Pallet.secondaryColor),
                                                          ]),
                                                        )),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Material(
                                                  elevation: 3,
                                                  type: MaterialType.card,
                                                  // borderRadius: 4,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: SizedBox(
                                                        width: boxWidth * 0.2,
                                                        height: isNotDeskTop() ? Get.width * 0.138 : Get.width * 0.103,
                                                        child: FittedBox(
                                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                const CustomText(
                                                                  text: 'Sold Properties',
                                                                  color: Colors.black38,
                                                                  weight: FontWeight.bold,
                                                                  size: 10,
                                                                ),
                                                                const SizedBox(height: 16),
                                                                CustomText(
                                                                  text: insight.soldProperties.toString(),
                                                                  color: Colors.black87,
                                                                  weight: FontWeight.bold,
                                                                  size: 18,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(width: 16),
                                                            SizedBox(
                                                              width: 48,
                                                              height: 48,
                                                              child: Stack(
                                                                children: [
                                                                  Center(
                                                                      child: CircularProgressIndicator(
                                                                          value: insight.allProperties == 0
                                                                              ? 0
                                                                              : (insight.soldProperties ?? 0) / (insight.allProperties ?? 1),
                                                                          backgroundColor: Colors.black.withOpacity(0.05),
                                                                          strokeWidth: 8)),
                                                                  const Center(child: Icon(Icons.house, size: 12, color: Pallet.secondaryColor)),
                                                                ],
                                                              ),
                                                            ),
                                                          ]),
                                                        )),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),
                                          SizedBox(
                                            width: isTabletDown() ? boxWidth : boxWidth * 0.5 - 8,
                                            child: FittedBox(
                                              child: Material(
                                                elevation: 3,
                                                type: MaterialType.card,
                                                child: SizedBox(
                                                  height: 420,
                                                  child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          const CustomText(
                                                            text: 'Listing Views',
                                                            color: Colors.black,
                                                            weight: FontWeight.bold,
                                                            size: 48,
                                                          ),
                                                          const SizedBox(height: 72),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  CustomText(
                                                                    text: (insight.today ?? 0).toString(),
                                                                    color: Colors.black,
                                                                    weight: FontWeight.bold,
                                                                    size: 48,
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  const CustomText(text: 'Last 24 hrs', color: Colors.black, weight: FontWeight.w500, size: 36),
                                                                ],
                                                              ),
                                                              const SizedBox(width: 10),
                                                              Icon(
                                                                (insight.weekChange ?? 0) > 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                                                color: (insight.dayChange ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
                                                                size: 54,
                                                              ),
                                                              const SizedBox(width: 5),
                                                              CustomText(
                                                                text: '${insight.dayPercent}%',
                                                                color: (insight.dayChange ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
                                                                weight: FontWeight.w500,
                                                                size: 36,
                                                              ),
                                                              const SizedBox(width: 30),
                                                              Container(color: Colors.grey.shade400, height: 120, width: 1.2),
                                                              const SizedBox(width: 30),
                                                              Column(
                                                                children: [
                                                                  CustomText(
                                                                    text: (insight.thisWeek ?? 0).toString(),
                                                                    color: Colors.black,
                                                                    weight: FontWeight.bold,
                                                                    size: 48,
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  const CustomText(text: 'Last 7 days', color: Colors.black, weight: FontWeight.w500, size: 36),
                                                                ],
                                                              ),
                                                              const SizedBox(width: 10),
                                                              Icon(
                                                                (insight.weekChange ?? 0) > 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                                                color: (insight.dayChange ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
                                                                size: 54,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              CustomText(
                                                                text: '${insight.weekPercent}%',
                                                                color: (insight.weekChange ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
                                                                weight: FontWeight.w500,
                                                                size: 36,
                                                              ),
                                                              const SizedBox(width: 30),
                                                              Container(color: Colors.grey.shade400, height: 120, width: 1.2),
                                                              const SizedBox(width: 30),
                                                              Column(
                                                                children: [
                                                                  CustomText(
                                                                    text: '${insight.thisMonth}',
                                                                    color: Colors.black,
                                                                    weight: FontWeight.bold,
                                                                    size: 48,
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  const CustomText(text: 'LAST 30 Days', color: Colors.black, weight: FontWeight.w500, size: 36),
                                                                ],
                                                              ),
                                                              const SizedBox(width: 10),
                                                              Icon(
                                                                (insight.weekChange ?? 0) > 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                                                color: (insight.dayChange ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
                                                                size: 54,
                                                              ),
                                                              const SizedBox(width: 5),
                                                              CustomText(
                                                                text: '${insight.monthPercent}%',
                                                                color: (insight.monthChange ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
                                                                weight: FontWeight.w500,
                                                                size: 36,
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 24,
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                                }),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: Material(
                                      elevation: 3,
                                      type: MaterialType.card,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: 30),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const CustomText(
                                                      text: 'Activity Progression',
                                                      color: Colors.black,
                                                      weight: FontWeight.bold,
                                                      size: 16,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width: isMobile() ? Get.width * 0.7 : Get.width * 0.4,
                                                      child: const CustomText(
                                                        text: 'Graphical representation of view for the last 30 days',
                                                        color: Colors.blueGrey,
                                                        weight: FontWeight.w500,
                                                        maxLines: 3,
                                                        size: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isTabletDown()
                                                    ? const SizedBox.shrink()
                                                    : Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 60,
                                                            child: Column(
                                                              children: [
                                                                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                  Container(
                                                                    height: 6,
                                                                    width: 6,
                                                                    decoration: BoxDecoration(
                                                                        color: (insight.dayChange ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
                                                                        shape: BoxShape.circle),
                                                                  ),
                                                                  const SizedBox(width: 12),
                                                                  Flexible(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        const CustomText(
                                                                          text: 'Daily',
                                                                          color: Colors.blueGrey,
                                                                          weight: FontWeight.w500,
                                                                          size: 12,
                                                                        ),
                                                                        const SizedBox(
                                                                          height: 10,
                                                                        ),
                                                                        CustomText(
                                                                          text: '${insight.today}',
                                                                          color: Colors.black,
                                                                          weight: FontWeight.bold,
                                                                          size: 12,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ]),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 70,
                                                            child: Column(
                                                              children: [
                                                                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                  Container(
                                                                    height: 6,
                                                                    width: 6,
                                                                    decoration: BoxDecoration(
                                                                        color: (insight.weekChange ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
                                                                        shape: BoxShape.circle),
                                                                  ),
                                                                  const SizedBox(width: 12),
                                                                  Flexible(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        const CustomText(
                                                                          text: 'WEEKLY',
                                                                          color: Colors.blueGrey,
                                                                          weight: FontWeight.w500,
                                                                          size: 12,
                                                                        ),
                                                                        const SizedBox(height: 10),
                                                                        CustomText(
                                                                          text: '${insight.thisWeek}',
                                                                          color: Colors.black,
                                                                          weight: FontWeight.bold,
                                                                          size: 12,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ]),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 80,
                                                            child: Column(
                                                              children: [
                                                                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                  Container(
                                                                    height: 6,
                                                                    width: 6,
                                                                    decoration: BoxDecoration(
                                                                        color: (insight.monthChange ?? 0) > 0 ? const Color.fromARGB(255, 42, 106, 44) : Colors.red,
                                                                        shape: BoxShape.circle),
                                                                  ),
                                                                  const SizedBox(width: 12),
                                                                  Flexible(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        const CustomText(
                                                                          text: 'MONTHLY',
                                                                          color: Colors.blueGrey,
                                                                          weight: FontWeight.w500,
                                                                          size: 12,
                                                                        ),
                                                                        const SizedBox(height: 10),
                                                                        CustomText(
                                                                          text: '${insight.thisMonth}',
                                                                          color: Colors.black,
                                                                          weight: FontWeight.bold,
                                                                          size: 12,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ]),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 32,
                                            ),
                                            SizedBox(
                                              height: 280,
                                              width: double.infinity,
                                              child: insight.viewsByDay == null ? const SizedBox.shrink() : ViewStatGraph(views: insight.viewsByDay!),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                const SizedBox(height: 98)
                              ],
                            ),
                ],
              );
            }),
      ),
    );
  }
}
