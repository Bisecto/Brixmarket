import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instance.dart';
import '../../../res/strings.dart';
import '../../../utils/utils.dart';
import '../../../utils/validations.dart';
import '../../widgets/auth_side.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';
import '../mobile/help_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                        margin: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                CustomText(text: Str.signUp, size: 32, weight: FontWeight.w800),
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
                                const SizedBox(height: 24),
                                FormInput(
                                  controller: EditCtrl.password,
                                  error: EditCtrl.passwordErr,
                                  validate: Val.password,
                                  label: 'Password',
                                  hint: 'Password',
                                  width: 430, isobscure: true,
                                ),
                                const SizedBox(height: 28),
                                SizedBox(
                                  width: 430,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 4),
                                        height: 16,
                                        width: 16,
                                        child: Obx(
                                          () => Checkbox(
                                            splashRadius: 30,
                                            activeColor: Pallet.secondaryColor,
                                            checkColor: Colors.white,
                                            side: const BorderSide(color: Colors.grey),
                                            value: EditCtrl.acceptTerms.value,
                                            onChanged: (state) {
                                              EditCtrl.acceptTerms.value = state == true;
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 18),
                                      Flexible(
                                        child: TextStyles.richTexts(
                                          onPress1: Utils.isMobileApp ? () => Get.dialog(const TermsPage()) : () => Get.toNamed(RouteStr.webTerms),
                                          size: 14,
                                          color2: Pallet.secondaryColor,
                                          text1: Str.youAgree,
                                          text2: ' ' + Str.tersAndCon,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                FormButton(
                                  width: 430,
                                  text: 'Sign Up',
                                  onPressed: homeCtrl.register,
                                ),
                                const SizedBox(height: 24),
                                const SizedBox(height: 35),
                                SizedBox(
                                    width: 430,
                                    child: Center(
                                      child: TextStyles.richTexts(
                                        onPress1: () => Get.offNamed(RouteStr.login),
                                        size: 16,
                                        text1: Str.haveAccountQ,
                                        text2: Str.signIn,
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 48),
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
