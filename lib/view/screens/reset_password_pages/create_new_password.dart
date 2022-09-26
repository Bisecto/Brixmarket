import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:brixmarket/utils/validations.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instance.dart';
import '../../../res/strings.dart';
import '../../widgets/auth_side.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
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
                        margin: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, bottom: Utils.isMobileApp ? Get.width * 0.2 : 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                CustomText(text: Str.createNewPassword, size: 24, weight: FontWeight.w800),
                                SizedBox(height: 20),
                              ],
                            ),
                            const Divider(endIndent: 120),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormInput(
                                  controller: EditCtrl.password,
                                  label: Str.password,
                                  validate: Val.password,
                                  error: EditCtrl.passwordErr,
                                  hint: Str.password,
                                  width: 430, isobscure: true,
                                ),
                                const SizedBox(height: 30),
                                FormInput(
                                  controller: EditCtrl.password2,
                                  label: Str.confirmNewPassword,
                                  validate: Val.password,
                                  error: EditCtrl.password2Err,
                                  hint: Str.confirmNewPassword,
                                  width: 430, isobscure: true,
                                ),
                                const SizedBox(height: 15),
                                FormButton(
                                  width: 430,
                                  text: Str.createNewPassword,
                                  onPressed: homeCtrl.createNewPassword,
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                    width: 430,
                                    child: Center(
                                      child: TextStyles.richTexts(
                                          onPress1: () => Get.offNamed(RouteStr.login),
                                          onPress2: () {},
                                          size: 16,
                                          text1: Str.rememberedYourPasswordQ,
                                          text2: ' ' + Str.signIn,
                                          text3: Str.noText,
                                          text4: Str.noText),
                                    )),
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
