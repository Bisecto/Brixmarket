import 'dart:convert';

import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/core/app.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:http/http.dart' as http;

import 'package:brixmarket/view/screens/reset_password_pages/password_otp_page.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instance.dart';
import '../../../core/dialogs.dart';
import '../../../core/preloader.dart';
import '../../../res/strings.dart';
import '../../../services/provider.dart';
import '../../../utils/validations.dart';
import '../../widgets/auth_side.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

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
                                CustomText(text: Str.resetPassword, size: 32, weight: FontWeight.w800),
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
                                const SizedBox(height: 15),
                                FormButton(
                                  width: 430,
                                  text: Str.reset,
                                  onPressed: () async {

                                      print(1);
                                      EditCtrl.emailErr.value = Val.email(EditCtrl.email.text);
                                      if (EditCtrl.emailErr.value.isNotEmpty) {
                                        print(2);

                                        MSG.errorSnackBar(
                                          'Invalid email provided',
                                        );
                                      } else {
                                        Preloader.show();
                                        print(3);
                                        var url= Uri.parse('$appBaseUrl login/send-OTP/${EditCtrl.email.text}');
                                        final res =
                                        await http.get(url,headers: await formDataHeader());
                                        print(res.body);
                                        final json = await jsonDecode(res.body);
                                        print(json);
                                        if(json['status']){
                                          Preloader.hide();
                                          Get.off(() => PasswordOtpPage());
                                        } else{
                                          Preloader.hide();
                                          MSG.errorSnackBar('Something went wrong please try again');
                                        }
                                        // var response = await Provider().getData("login/send-OTP/${EditCtrl.email.text}");
                                        // print(response);
                                        // if (response != null) {
                                        //   print(4);
                                        //
                                        //   Preloader.hide();
                                        //   Get.off(() => PasswordOtpPage());
                                        // }
                                      }

                                  },
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                    width: 430,
                                    child: Center(
                                      child: TextStyles.richTexts(
                                        onPress1: () => Get.toNamed(RouteStr.login),
                                        size: 16,
                                        text1: Str.rememberedYourPasswordQ,
                                        text2: ' ' + Str.signIn,
                                      ),
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
