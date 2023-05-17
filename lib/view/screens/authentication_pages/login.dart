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

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EditCtrl.email.text = '';
    EditCtrl.password.text = '';
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
                  width:
                      constraints.maxWidth >= 600 ? Get.width * 0.6 : Get.width,
                  color: Colors.white,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Get.width * 0.05,
                            right: Get.width * 0.05,
                            bottom: Utils.isMobileApp ? Get.width * 0.2 : 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                CustomText(
                                    text: Str.signIn,
                                    size: 32,
                                    weight: FontWeight.w800),
                                SizedBox(height: 20),
                              ],
                            ),
                            const Divider(endIndent: 120),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormInput(
                                  inputType: TextInputType.emailAddress,
                                  controller: EditCtrl.email,
                                  error: EditCtrl.emailErr,
                                  validate: Val.email,
                                  label: Str.email,
                                  hint: Str.email,
                                  width: 430,
                                ),
                                const SizedBox(height: 30),
                                FormInput(
                                  isobscure: true,
                                  inputType: TextInputType.visiblePassword,
                                  controller: EditCtrl.password,
                                  label: Str.password,
                                  hint: Str.password,
                                  width: 430,
                                ),
                                const SizedBox(height: 15),
                                FormButton(
                                  width: 430,
                                  text: Str.signIn,
                                  onPressed: homeCtrl.login,
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                    width: 430,
                                    child: TextStyles.richTexts(
                                      onPress1: () =>
                                          Get.toNamed(RouteStr.recoverPassword),
                                      size: 16,
                                      text1: Str.forgotPasswordQ,
                                      text2: ' ' + Str.reset,
                                    )),
                                SizedBox(height: Get.height * 0.07),
                                SizedBox(
                                    width: 430,
                                    child: Center(
                                      child: TextStyles.richTexts(
                                          onPress1: () => Get.offNamed(
                                              RouteStr.registerHome),
                                          onPress2: () {},
                                          size: 16,
                                          text1: Str.donTHaveAccountQ,
                                          text2: ' ' + Str.signUp,
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
