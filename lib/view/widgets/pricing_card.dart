import 'package:brixmarket/controllers/instance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme/color.dart';
import '../../utils/utils.dart';
import '../screens/mobile/sub_payment.dart';
import 'custom_text.dart';
import 'form_button.dart';

Widget pricingCard(maxWidth) {
  return Wrap(
    alignment: WrapAlignment.spaceAround,
    children: homeCtrl.upgradePlans
        .map((plan) => Container(
              width: maxWidth / 3.5 < 154 ? maxWidth * 0.97 : maxWidth / 2.2,
              margin: const EdgeInsets.only(left: 2, right: 8, bottom: 48),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                type: MaterialType.card,
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 260, maxHeight: 400),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SizedBox(height: 12),
                    CustomText(
                      text: plan.title?.toUpperCase(),
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
                      color: Colors.grey[900],
                      weight: FontWeight.w600,
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
                          bgColor: plan.amount == 0 ? Colors.red[100] : Pallet.secondaryColor,
                          text: plan.amount == 0 ? 'Current Plan' : 'Upgrade Plan',
                          hasIcon: plan.amount != 0,
                          onPressed: plan.amount == 0
                              ? () {}
                              : () {
                                  homeCtrl.selectedUpgradePlan = plan;
                                  if (user.isAgent == true || user.isAgency == true || (user.premiumDetails?.address != null && user.premiumDetails?.idNumber != null)) {
                                    Get.to(() => const SubPayment());
                                  } else {
                                    homeCtrl.showPremiumForm.value = true;
                                  }
                                },
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ))
        .toList(),
  );
}
