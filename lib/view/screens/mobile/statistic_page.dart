import 'package:brixmarket/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../core/preloader.dart';
import '../../../models/insight_model.dart';

import '../../../utils/shared_preferences.dart';
import '../../temp.dart';
import '../../widgets/appbar_menus.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/stat_graph.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  var insight;
  bool isStat = false;
  String propertyListed = '0';
  String totalViews = '0';
  String totalImpressions = '0';

  String userMail = '';
  String userPassword = '';

  userDetails() async {
    userMail = await SharedPref.getString('user_email');
    userPassword = await SharedPref.getString('user_password');

    if (userMail.isNotEmpty &&
        userPassword.isNotEmpty &&
        HomeController.isLogin.value) {
      await homeCtrl.login();
      await cPropCtrl.getInsight().then((value) => {
            if (insight != null)
              {
                insight = value,
                propertyListed = insight?.totalProperties.toString() ?? '0',
                totalViews = insight?.totalViews.toString() ?? '0',
                totalImpressions = insight?.totalImpressions.toString() ?? '0',
              }
          });
    }
  }

  @override
  void initState() {
    userDetails();

    super.initState();
  }

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
        body: (insight == null)
            ? Center(
                child: SizedBox(height: 48, child: Preloader.loadingWidget()))
            : ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                children: [
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: CustomText(
                        color: Pallet.secondaryColor,
                        size: 18,
                        text: 'your insights'.toUpperCase(),
                        maxLines: 2,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.5),
                  const Divider(),
                  const SizedBox(height: 20.5),
                  Row(
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
                      text: 'Property Views (this month)',
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
                        elevation: 1,
                        type: MaterialType.card,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            insight?.viewsByDay4Month == null
                                ? const Center(
                                    child: CustomText(
                                      text: 'Nothing to see here yet.',
                                      color: Colors.blueGrey,
                                      weight: FontWeight.w400,
                                      size: 16,
                                    ),
                                  )
                                : ViewStatGraph(
                                    views: insight?.viewsByDay4Month,
                                    title: 'Monthly Views Analysis',
                                  ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 30.5),
                  const Divider(),
                  const SizedBox(height: 30.5),
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
                      elevation: 1,
                      type: MaterialType.card,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          insight?.savesByDay4Month == null
                              ? const Center(
                                  child: CustomText(
                                    text: 'Nothing to see here yet.',
                                    color: Colors.blueGrey,
                                    weight: FontWeight.w400,
                                    size: 16,
                                  ),
                                )
                              : ViewStatGraph(
                                  views: insight?.savesByDay4Month,
                                  title: 'Monthly Saved Analysis',
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ));
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
