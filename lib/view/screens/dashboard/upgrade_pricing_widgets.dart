import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../res/states.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';
import '../../widgets/pricing_card.dart';

class UpgradePricingWidget extends StatelessWidget {
  final double? constraints;
  const UpgradePricingWidget({Key? key, this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: Scrollbar(
        controller: cPropCtrl.scrollController5,
        isAlwaysShown: true,
        interactive: true,
        child: ListView(
          shrinkWrap: true,
          controller: cPropCtrl.scrollController5,
          padding: EdgeInsets.symmetric(horizontal: (constraints! * 0.05)),
          children: [
            homeCtrl.showPremiumForm.value
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Premium upgrade',
                          color: Colors.black,
                          weight: FontWeight.bold,
                          size: 18,
                        ),
                        Container(margin: const EdgeInsets.symmetric(vertical: 20), child: const Divider()),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: 'Select the pricing plan that best suits your real estate marketing plan.',
                                color: Colors.black,
                                weight: FontWeight.w200,
                                size: 14,
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 48),
                                child: LayoutBuilder(builder: (context, constrain) {
                                  double maxWidth = constrain.maxWidth;
                                  return Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    children: [
                                      SizedBox(width: Get.width),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 24),
                                        child: DropDown(
                                          controller: EditCtrl.idType,
                                          label: 'ID Type',
                                          width: maxWidth / 2.5 < 210 ? maxWidth : maxWidth / 2.5,
                                          items: const ['National id', 'International passport', 'Voter card'],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 24),
                                        child: FormInput(
                                          controller: EditCtrl.idNumber,
                                          label: 'ID number',
                                          hint: 'ID number',
                                          width: maxWidth / 2.5 < 210 ? maxWidth : maxWidth / 2.5,
                                        ),
                                      ),
                                      SizedBox(width: Get.width),
                                      Stack(children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 24),
                                          child: FormInput(
                                            onTap: () {}, // homeCtrl.selectIdImage,
                                            controller: EditCtrl.idPhoto,
                                            label: 'Upload ID Image',
                                            hint: '--------------  Upload ID Image',
                                            width: maxWidth / 2.5 < 210 ? maxWidth : maxWidth / 1.232,
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          child: FormButton(width: 108, text: 'Browse', onPressed: () {} //homeCtrl.selectIdImage,
                                              ),
                                        )
                                      ]),
                                      SizedBox(width: Get.width),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 24),
                                        child: DropDown(
                                          controller: EditCtrl.state,
                                          label: 'State',
                                          width: maxWidth / 2.5 < 210 ? maxWidth : maxWidth / 2.5,
                                          items: ngnStates,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.only(bottom: 24),
                                          child: DropDown(
                                            controller: EditCtrl.city,
                                            label: 'Town',
                                            width: maxWidth / 2.5 < 210 ? maxWidth : maxWidth / 2.5,
                                            items: ngnLga[EditCtrl.state.value.text] ?? [],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 16,
                                        ),
                                        child: FormInput(
                                          controller: EditCtrl.address,
                                          label: 'Street address',
                                          hint: 'Street address',
                                          width: maxWidth / 2.5 < 210 ? maxWidth : maxWidth / 1.232,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 0,
                                        width: maxWidth,
                                      ),
                                      FormButton(
                                        bgColor: Colors.black38,
                                        width: 100,
                                        text: 'Cancel',
                                        onPressed: () => homeCtrl.showPremiumForm.value = false,
                                      ),
                                      const SizedBox(width: 8),
                                      FormButton(
                                        width: 128,
                                        text: 'Upgrade Now',
                                        onPressed: homeCtrl.makePayment,
                                      ),
                                      SizedBox(
                                        height: 48,
                                        width: Get.width / 1.5,
                                      ),
                                    ],
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 0)
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Pricing Plan',
                          color: Colors.black,
                          weight: FontWeight.bold,
                          size: 18,
                        ),
                        Container(margin: const EdgeInsets.symmetric(vertical: 20), child: const Divider()),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: 'Select the pricing plan that best suits your real estate marketing plan.',
                                color: Colors.black,
                                weight: FontWeight.w200,
                                size: 14,
                              ),
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 48),
                                child: LayoutBuilder(builder: (context, constrain) {
                                  double maxWidth = constrain.maxWidth;
                                  return pricingCard(maxWidth);
                                }),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 0)
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
