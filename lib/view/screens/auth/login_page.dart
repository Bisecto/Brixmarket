import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../res/strings.dart';
import '../../../utils/validations.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/form_inputs.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    EditCtrl.email.text = '';
    EditCtrl.password.text = '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        backgroundColor: Pallet.primaryBackground,
        appBar: AppBar(
          backgroundColor: Pallet.primaryBackground,
          elevation: 0,
          foregroundColor: Colors.black54,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    left: Get.width * 0.05,
                    right: Get.width * 0.05,
                    bottom: Get.width * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
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
                          //bgColor: Colors.blueAccent,
                          onPressed: homeCtrl.mainlLogin,
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
        ));
  }
}
