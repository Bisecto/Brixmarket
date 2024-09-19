import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instance.dart';
import '../../../res/strings.dart';
import '../../../utils/validations.dart';
import '../../widgets/auth_side.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';

class RegBasicInfoPage extends StatelessWidget {
  const RegBasicInfoPage({Key? key}) : super(key: key);

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
                                SizedBox(height: 24),
                                CustomText(text: Str.accountBasic, size: 24, weight: FontWeight.w800),
                                SizedBox(height: 20),
                              ],
                            ),
                            const SizedBox(
                              width: 430,
                              child: Divider(
                                color: Colors.black26,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                SizedBox(
                                  width: 430,
                                  child: Center(
                                    child: Obx(() => Text(
                                          EditCtrl.image8Lists.isEmpty
                                              ? user.isUser ?? false
                                                  ? Str.uploadProfileImage
                                                  : Str.uploadProfileLogo
                                              : user.isUser ?? false
                                                  ? Str.editProfileImage
                                                  : Str.editProfileImage,
                                          style: const TextStyle(fontSize: 12),
                                        )),
                                  ),
                                ),
                                const SizedBox(width: double.infinity, height: 8),
                                SizedBox(
                                  width: 430,
                                  child: Center(
                                    child: Obx(() => EditCtrl.image8Lists.isNotEmpty
                                        ? Stack(children: [
                                            CircleAvatar(
                                              backgroundImage: MemoryImage(EditCtrl.image8Lists[0]),
                                              radius: 36,
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 6,
                                              child: InkWell(
                                                onTap: homeCtrl.selectSingleImage,
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                                                  child: const Icon(Icons.edit, color: Colors.white, size: 10),
                                                ),
                                              ),
                                            ),
                                          ])
                                        : InkWell(
                                            onTap: homeCtrl.selectSingleImage,
                                            child: Stack(
                                              children: [
                                                const CircleAvatar(
                                                  backgroundImage: AssetImage(ImgStr.avatarImg),
                                                  radius: 36,
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  bottom: 6,
                                                  child: InkWell(
                                                    onTap: homeCtrl.selectSingleImage,
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                                                      child: const Icon(Icons.add, color: Colors.white, size: 14),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ))),
                                  ),
                                ),
                                const SizedBox(width: double.infinity, height: 16),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: FormInput(
                                    controller: EditCtrl.surname,
                                    error: EditCtrl.surnameErr,
                                    validate: Val.name,
                                    label: Str.surname,
                                    hint: Str.surname,
                                    width: Utils.authInputWidth(Get.width),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: FormInput(
                                    controller: EditCtrl.firstName,
                                    error: EditCtrl.firstNameErr,
                                    validate: Val.name,
                                    label: Str.firstName,
                                    hint: Str.firstName,
                                    width: Utils.authInputWidth(Get.width),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: FormInput(
                                    inputType: TextInputType.phone,
                                    controller: EditCtrl.phone,
                                    error: EditCtrl.phoneErr,
                                    validate: Val.phone,
                                    label: Str.phoneNumber,
                                    hint: Str.phoneNumber,
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
                                            value: EditCtrl.acceptPhone.value,
                                            onChanged: (state) {
                                              EditCtrl.acceptPhone.value = state == true;
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 18),
                                      Flexible(
                                        child: TextStyles.richTexts(
                                          size: 14,
                                          color2: Colors.blueGrey[900],
                                          text1: Str.agreeProfileImage,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                FormButton(
                                  width: 430,
                                  text: 'Sign Up',
                                  onPressed: homeCtrl.regBasic,
                                ),
                              ],
                            ),
                            const SizedBox(height: 48)
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
