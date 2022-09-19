import 'package:brixmarket/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../utils/utils.dart';
import '../../../utils/validations.dart';
import '../../widgets/appbar_menus.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';
import '../../widgets/image_widgets.dart';

class PrivacySecurityPage extends StatelessWidget {
  const PrivacySecurityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'Privacy and Security',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true)],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        children: [
          profileImgAndBasicInfo(),
          const CustomText(
            color: Colors.black,
            size: 16,
            text: 'PRIVACY AND SECURITY',
            weight: FontWeight.w400,
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile(
              onTap: () {
                Get.toNamed(RouteStr.mobileChangePassword);
              },
              title: 'Change Password'),
        ],
      ),
    );
  }

  buildListTile({String title = '', required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 0.8))),
        child: ListTile(
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blueGrey[500],
            size: 20,
          ),
          leading: CustomText(
            color: Colors.blueGrey[500],
            size: 16,
            text: title,
            weight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'Change Password',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true)],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          profileImgAndRefId(),
          const SizedBox(
            height: 20,
          ),
          const Divider(thickness: 1),
          const SizedBox(
            height: 20,
          ),
          changePassword(),
        ],
      ),
    );
  }
}

changePassword() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    child: Column(
      children: [
        PasswordInput(
          maxLines: 1,
          width: double.infinity,
          controller: EditCtrl.passwordOld,
          label: Str.oldPassword,
          hint: 'x x x x x x x x',
        ),
        const SizedBox(
          height: 40,
        ),
        PasswordInput(
          maxLines: 1,
          width: double.infinity,
          controller: EditCtrl.password,
          error: EditCtrl.passwordErr,
          validate: Val.password,
          label: Str.newPassword,
          hint: Str.newPassword,
        ),
        const SizedBox(
          height: 20,
        ),
        PasswordInput(
          maxLines: 1,
          width: double.infinity,
          controller: EditCtrl.password2,
          error: EditCtrl.password2Err,
          validate: Val.password,
          label: Str.confirmNewPassword,
          hint: Str.confirmNewPassword,
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FormBorderButton(
              width: 86,
              bgColor: Colors.white,
              txtColor: Colors.black,
              text: Str.cancel,
              onPressed: () => Utils.isMobileApp ? Get.back() : cPropCtrl.accountIndex.value = 0,
            ),
            const SizedBox(
              width: 10,
            ),
            FormButton(
              width: 86,
              textSize: 14,
              weight: FontWeight.w600,
              text: Str.save,
              disableButton: false,
              onPressed: homeCtrl.submitChangePassword,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}
