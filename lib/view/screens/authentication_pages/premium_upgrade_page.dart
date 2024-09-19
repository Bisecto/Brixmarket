import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/res/lists.dart';
import 'package:brixmarket/res/states.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:brixmarket/view/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instance.dart';
import '../../widgets/auth_side.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';

class PremiumUpgradePage extends StatelessWidget {
  PremiumUpgradePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      dnd(Get.width);
      return Scaffold(
          backgroundColor: Pallet.primaryBackground,
          body: Row(
            children: [
              const AuthSide(),
              Builder(builder: (context) {
                return Container(
                  height: Get.height,
                  width: constraints.maxWidth >= 600 ? Get.width * 0.6 : Get.width,
                  color: Colors.white,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(height: 42),
                                CustomText(text: 'Premium upgrade', size: 32, weight: FontWeight.w800),
                                SizedBox(height: 20),
                                CustomText(
                                  maxLines: 2,
                                  text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,\nsed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                                  size: 16,
                                  weight: FontWeight.w500,
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                            const Divider(endIndent: 120),
                            const SizedBox(height: 20),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                SizedBox(width: Get.width),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: DropDown(
                                    controller: EditCtrl.idType,
                                    label: 'ID Type',
                                    width: Utils.authInputWidth(Get.width),
                                    items: Lst.idTypes,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: FormInput(
                                    controller: EditCtrl.idNumber,
                                    label: 'ID number',
                                    hint: 'ID number',
                                    width: Utils.authInputWidth(Get.width),
                                  ),
                                ),
                                SizedBox(width: Get.width),
                                Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: FormInput(
                                      onTap: () {}, //homeCtrl.selectIdImage,
                                      controller: EditCtrl.idPhoto,
                                      label: 'Upload ID Image',
                                      hint: '--------------  Upload ID Image',
                                      width: 430,
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    child: FormButton(
                                      width: 108,
                                      text: 'Browse',
                                      onPressed: () {}, // homeCtrl.selectIdImage,
                                    ),
                                  )
                                ]),
                                SizedBox(width: Get.width),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: DropDown(
                                    controller: EditCtrl.state,
                                    label: 'State',
                                    width: Utils.authInputWidth(Get.width),
                                    items: ngnStates,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: DropDown(
                                      controller: EditCtrl.city,
                                      label: 'Town',
                                      width: Utils.authInputWidth(Get.width),
                                      items: ngnLga[EditCtrl.state.value.text] ?? [],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: FormInput(
                                    controller: EditCtrl.address,
                                    label: 'Street address',
                                    hint: 'Street address',
                                    width: 430,
                                  ),
                                ),
                                const SizedBox(height: 28),
                                FormButton(
                                  width: 430,
                                  text: 'Submit',
                                  onPressed: homeCtrl.premiumUpgrade,
                                ),
                                SizedBox(
                                  height: 48,
                                  width: Get.width / 1.5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
            ],
          ));
    });
  }
}
