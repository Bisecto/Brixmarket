import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/res/states.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:brixmarket/view/widgets/dash_border.dart';
import 'package:brixmarket/view/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instance.dart';
import '../../../res/strings.dart';
import '../../../utils/validations.dart';
import '../../widgets/auth_side.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';

class RegAgencyPage extends StatelessWidget {
  RegAgencyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      dnd(Get.width);
      return Scaffold(
          backgroundColor: Pallet.primaryBackground,
          appBar: Utils.isMobileApp
              ? AppBar(
                  backgroundColor: Pallet.primaryBackground,
                  elevation: 0,
                  foregroundColor: Colors.black54,
                  automaticallyImplyLeading: true,
                )
              : null,
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
                                CustomText(
                                  text: 'Agent/Agency \nRegistration',
                                  size: 32,
                                  weight: FontWeight.w800,
                                  maxLines: 2,
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                            const Divider(endIndent: 120),
                            const SizedBox(height: 16),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: FormInput(
                                    controller: EditCtrl.agencyName,
                                    error: EditCtrl.agencyNameErr,
                                    validate: Val.name,
                                    label: '${Str.agent} / ${Str.agencyName}',
                                    hint: Str.agencyName,
                                    width: 430,
                                  ),
                                ),
                                SizedBox(width: Get.width),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: DropDown(
                                    controller: EditCtrl.state,
                                    label: Str.state,
                                    width: Utils.authInputWidth(Get.width),
                                    items: ngnStates,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Obx(() => Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: DropDown(
                                        controller: EditCtrl.city,
                                        label: Str.town,
                                        width: Utils.authInputWidth(Get.width),
                                        items: ngnLga[EditCtrl.state.value.text] ?? [],
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: FormInput(
                                    controller: EditCtrl.address,
                                    error: EditCtrl.addressErr,
                                    validate: Val.name,
                                    label: Str.streetAddress,
                                    hint: Str.streetAddress,
                                    width: 430,
                                  ),
                                ),
                                const SizedBox(height: 28),
                                SizedBox(
                                  width: 430,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 4),
                                        height: 10,
                                        width: 10,
                                        child: Obx(
                                          () => Checkbox(
                                            activeColor: Pallet.secondaryColor,
                                            checkColor: Colors.white,
                                            side: const BorderSide(color: Colors.grey),
                                            value: EditCtrl.isRegisterAgency.value,
                                            onChanged: (state) {
                                              EditCtrl.isRegisterAgency.value = state == true;
                                              print(EditCtrl.isRegisterAgency.value);
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: TextStyles.richTexts(
                                          size: 14,
                                          color2: Colors.blueGrey[900],
                                          text1: Str.registeredWithCAC,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(() => Visibility(
                                      visible: EditCtrl.isRegisterAgency.value,
                                      child: Wrap(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16, top: 16),
                                            child: FormInput(
                                              controller: EditCtrl.legalName,
                                              error: EditCtrl.legalNameErr,
                                              validate: Val.name,
                                              label: '${Str.registeredName} (${Str.legalName})',
                                              hint: Str.registeredName,
                                              width: 430,
                                            ),
                                          ),
                                          SizedBox(width: Get.width),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16),
                                            child: FormInput(
                                              inputType: TextInputType.number,
                                              controller: EditCtrl.rcNumber,
                                              error: EditCtrl.rcNumberErr,
                                              validate: Val.number,
                                              label: 'RC number',
                                              hint: 'RC number',
                                              width: 430,
                                              maxLength: 12,
                                            ),
                                          ),
                                          const SizedBox(width: 24),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 260,
                                            child: InkWell(
                                                onTap: homeCtrl.selectSingleImage,
                                                child: Stack(
                                                  children: [
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 240,
                                                      child: DashedBorder(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              SizedBox(
                                                                height: 180,
                                                                child: Obx(
                                                                  () => EditCtrl.image8Lists.isNotEmpty
                                                                      ? Image.memory(
                                                                          EditCtrl.image8Lists[0],
                                                                          fit: BoxFit.contain,
                                                                        )
                                                                      : Image.asset(ImgStr.certImg, height: 180),
                                                                ),
                                                              ),
                                                              const SizedBox(height: 16),
                                                              EditCtrl.image8Lists.isNotEmpty
                                                                  ? const Text(Str.changeCACCert, style: TextStyle(color: Pallet.secondaryColor))
                                                                  : const Text(Str.uploadCACCert),
                                                            ],
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
                                                )),
                                          ),
                                        ],
                                      ),
                                    )),
                                FormButton(
                                  width: 430,
                                  text: Str.submit,
                                  onPressed: homeCtrl.regAgency,
                                ),
                                SizedBox(
                                  height: 48,
                                  width: Get.width / 1.5,
                                ),
                              ],
                            ),
                            const SizedBox(height: 54),
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
