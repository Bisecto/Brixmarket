import 'package:brixmarket/models/upgrade_plans.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../utils/utils.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/form_button.dart';

class SubPayment extends StatefulWidget {
  const SubPayment({Key? key}) : super(key: key);

  @override
  State<SubPayment> createState() => _SubPaymentState();
}

class _SubPaymentState extends State<SubPayment> {
  bool isSub = false;

  @override
  Widget build(BuildContext context) {
    UpgradePlan plan = homeCtrl.selectedUpgradePlan!;
    return Scaffold(
        backgroundColor: Pallet.homeBackground,
        appBar: AppBar(
          backgroundColor: Pallet.secondaryColor,
          automaticallyImplyLeading: !homeCtrl.showPremiumForm.value,
          title: const CustomText(
            color: Colors.white,
            size: 18,
            text: 'Subscription',
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        body: ListView(shrinkWrap: true, padding: const EdgeInsets.symmetric(horizontal: 0), children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Get.dialog(paymentSuccessDialog()),
                  child: const Text(
                    'Premium upgrade Pricing',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(margin: const EdgeInsets.symmetric(vertical: 4), child: const Divider()),
                const Text(
                  'Select the pricing plan that best suits your real estate marketing plan.',
                ),
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(minHeight: 380, maxHeight: 390),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                CustomText(
                  text: plan.title,
                  color: Pallet.secondaryColor,
                  weight: FontWeight.bold,
                  size: 18,
                ),
                const SizedBox(height: 16),
                CustomText(
                  text: Utils.amount(plan.amount),
                  color: Colors.black,
                  weight: FontWeight.bold,
                  size: 24,
                ),
                const SizedBox(height: 20),
                CustomText(
                  maxLines: 5,
                  text: plan.description,
                  color: Colors.grey,
                  weight: FontWeight.w100,
                  size: 16,
                ),
                const SizedBox(height: 20),
                ...(plan.features as List)
                    .map((feature) => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Align(alignment: Alignment.centerLeft, child: Icon(Icons.check, size: 18)),
                            ),
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                                child: CustomText(
                                  text: feature,
                                  color: Colors.black,
                                  maxLines: 2,
                                  weight: FontWeight.normal,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ))
                    .toList(),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FormIconButton(
                      width: double.infinity,
                      height: 42,
                      fontSize: 16,
                      hasIcon: false,
                      bgColor: Pallet.secondaryColor,
                      onPressed: homeCtrl.makePayment,
                      text: 'Pay ${Utils.amount(plan.amount)}',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]));
  }
}

paymentSuccessDialog() {
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: true,
      title: const Text(
        'Payment Confirmation',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    ),
    body: Container(
      color: Colors.white,
      width: Get.width,
      height: Get.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 48),
          const Text(
            'Success!',
            style: TextStyle(fontSize: 36),
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'Your To use this class, make sure you set uses-material-design true in your',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: FormIconButton(
              width: 120,
              height: 42,
              fontSize: 16,
              hasIcon: false,
              bgColor: Pallet.secondaryColor,
              onPressed: () => Utils.isMobileApp ? Get.offAndToNamed(RouteStr.mobileLanding) : Get.toNamed(RouteStr.webDashboard),
              text: 'Continue',
            ),
          )
        ],
      ),
    ),
  );
}
