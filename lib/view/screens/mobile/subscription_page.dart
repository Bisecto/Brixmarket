import 'package:brixmarket/res/lists.dart';
import 'package:brixmarket/view/screens/mobile/sub_payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../core/app.dart';
import '../../../res/states.dart';
import '../../../res/strings.dart';
import '../../../utils/validations.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/dash_border.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/form_button.dart' as form;
import '../../widgets/form_inputs.dart';
import '../../widgets/pricing_card.dart';

class SubScriptionPage extends StatefulWidget {
  SubScriptionPage({Key? key}) : super(key: key);

  @override
  State<SubScriptionPage> createState() => _SubScriptionPageState();
}

class _SubScriptionPageState extends State<SubScriptionPage> {
  bool isSub = false;

  @override
  Widget build(BuildContext context) {
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
        body: Obx(() => homeCtrl.showPremiumForm.value
            ? ListView(shrinkWrap: true, padding: const EdgeInsets.symmetric(horizontal: 0), children: [
                Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: 'Location',
                              color: Colors.black,
                              weight: FontWeight.bold,
                              size: 18,
                            ),
                            const Divider(),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 16),
                              child: LayoutBuilder(builder: (context, constrain) {
                                double maxWidth = constrain.maxWidth;
                                return Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    SizedBox(width: Get.width),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 24),
                                      child: DropDown(
                                        initialValue: user.premiumDetails?.state ?? '',
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
                                          initialValue: homeCtrl.user.value.premiumDetails?.city ?? '',
                                          controller: EditCtrl.city,
                                          label: 'Town',
                                          width: maxWidth / 2.5 < 210 ? maxWidth : maxWidth / 2.5,
                                          items: ngnLga[EditCtrl.state.value.text] ?? [],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: FormInput(
                                        value: user.premiumDetails?.address ?? '',
                                        controller: EditCtrl.address,
                                        error: EditCtrl.addressErr,
                                        validate: Val.name,
                                        label: Str.streetAddress,
                                        hint: Str.streetAddress,
                                        width: maxWidth / 2.5 < 210 ? maxWidth : maxWidth / 1.232,
                                      ),
                                    ),
                                    SizedBox(width: Get.width, height: 24),
                                    const CustomText(
                                      text: 'Identification',
                                      color: Colors.black,
                                      weight: FontWeight.bold,
                                      size: 18,
                                    ),
                                    const Divider(),
                                    SizedBox(width: Get.width, height: 16),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 24),
                                      child: DropDown(
                                        initialValue: user.premiumDetails?.idType,
                                        controller: EditCtrl.idType,
                                        label: 'ID Type',
                                        width: maxWidth / 2.5 < 210 ? maxWidth : maxWidth / 2.5,
                                        items: Lst.idTypes,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 24),
                                      child: FormInput(
                                        value: user.premiumDetails?.idNumber,
                                        controller: EditCtrl.idNumber,
                                        error: EditCtrl.rcNumberErr,
                                        validate: Val.name,
                                        label: Str.idNumber,
                                        hint: Str.idNumber,
                                        maxLength: 12,
                                        width: maxWidth / 2.5 < 210 ? maxWidth : maxWidth / 2.5,
                                      ),
                                    ),
                                    SizedBox(width: Get.width),
                                    Obx(() => homeCtrl.user.value.premiumDetails?.isVerified == true
                                        ? Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black26),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Image.network('$idImgPath${user.premiumDetails?.idPhoto}'),
                                          )
                                        : SizedBox(
                                            width: double.infinity,
                                            height: 360,
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 340,
                                                  child: InkWell(
                                                    onTap: homeCtrl.selectSingleImage,
                                                    child: DashedBorder(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            SizedBox(
                                                              height: 280,
                                                              child: Obx(
                                                                () => EditCtrl.image8Lists.isNotEmpty
                                                                    ? Image.memory(
                                                                        EditCtrl.image8Lists[0],
                                                                        fit: BoxFit.contain,
                                                                      )
                                                                    : user.premiumDetails?.idPhoto != null && user.premiumDetails?.idPhoto != ''
                                                                        ? Image.network('$idImgPath${user.premiumDetails?.idPhoto}')
                                                                        : Image.asset(
                                                                            ImgStr.idImg2,
                                                                            height: 240,
                                                                            fit: BoxFit.fitWidth,
                                                                            color: Colors.black12,
                                                                          ),
                                                              ),
                                                            ),
                                                            // const Spacer(),
                                                            const Text(Str.changeCACCert, style: TextStyle(color: Pallet.secondaryColor)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 6,
                                                  bottom: 0,
                                                  child: InkWell(
                                                    onTap: homeCtrl.selectSingleImage,
                                                    child: CircleAvatar(
                                                      radius: 21,
                                                      child: Icon(Icons.add_a_photo, color: Pallet.whiteColor, size: 18),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    SizedBox(height: 0, width: maxWidth),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        form.FormBorderButton(
                                          width: 120,
                                          bgColor: Colors.white,
                                          txtColor: Colors.black,
                                          text: 'Cancel',
                                          onPressed: () => homeCtrl.showPremiumForm.value = false,
                                        ),
                                        FormButton(
                                          height: 42,
                                          txtColor: Colors.white,
                                          radius: 4,
                                          width: 128,
                                          text: 'Upgrade Now',
                                          onPressed: () => Get.to(() => const SubPayment()),
                                          // onPressed: homeCtrl.makePayment,
                                        ),
                                      ],
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
              ])
            : ListView(shrinkWrap: true, padding: const EdgeInsets.symmetric(horizontal: 0), children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Premium upgrade Pricing',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Container(margin: const EdgeInsets.symmetric(vertical: 4), child: const Divider()),
                      const Text(
                        'Select the pricing plan that best suits your real estate marketing plan.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: pricingCard(Get.width * 0.85),
                ),
                const SizedBox(
                  height: 20,
                ),
              ])));
  }

  // buttonContainer({String? text, int? index}) {
  //   return GestureDetector(
  //     onTap: () {
  //       isSelected(index: index);
  //     },
  //     child: SizedBox(
  //       height: 42,
  //       child: Container(
  //         width: 100,
  //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(4),
  //             color: selectedIndex == index ? Pallet.secondaryColor : Colors.white,
  //             border: Border.all(
  //               color: Pallet.secondaryColor,
  //               width: 1,
  //             )),
  //         child: Center(
  //           child: CustomText(
  //             color: selectedIndex == index ? Colors.white : Pallet.secondaryColor,
  //             size: 14,
  //             text: text!,
  //             weight: FontWeight.w600,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
