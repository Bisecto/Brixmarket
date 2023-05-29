import 'package:brixmarket/res/strings.dart';
import 'package:brixmarket/view/screens/reset_password_pages/password_otp_page.dart';
import 'package:get/get.dart';

import '../../core/dialogs.dart';
import '../../core/preloader.dart';
import '../../models/user_model.dart';
import '../../services/provider.dart';
import '../../utils/validations.dart';
import '../../view/screens/reset_password_pages/create_new_password.dart';
import '../edit_controller.dart';

mixin ResetPassword {
  Future sendPasswordOTP() async {
    print(1);
    EditCtrl.emailErr.value = Val.email(EditCtrl.email.text);
    if (EditCtrl.emailErr.value.isNotEmpty) {
      print(2);

      MSG.errorSnackBar(
        EditCtrl.emailErr.value,
      );
    } else {
      Preloader.show();
      print(3);

      var response = await Provider().getData("login/send-OTP/${EditCtrl.email.text}");
      if (response != null) {
        print(4);

        Preloader.hide();
        Get.off(() => PasswordOtpPage());
      }
    }
  }

  Future verifyPasswordOTP() async {
    Preloader.show();

    var data = User.map(otp: EditCtrl.otp.text, email: EditCtrl.email.text);
    var response = await Provider().postData("login/verify-OTP", data);
    EditCtrl.otp.text = '';
    if (response != null) {
      Preloader.hide();
      Get.off(() => const CreateNewPassword());
    }
  }

  Future createNewPassword() async {
    EditCtrl.passwordErr.value = Val.password(EditCtrl.password.text);
    EditCtrl.password2Err.value = Val.password(EditCtrl.password2.text);
    if (EditCtrl.passwordErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        EditCtrl.passwordErr.value,
      );
    } else if (EditCtrl.password2Err.value.isNotEmpty) {
      MSG.errorSnackBar(
        EditCtrl.password2Err.value,
      );
    } else if (EditCtrl.password.text != EditCtrl.password2.text) {
      EditCtrl.password2Err.value = 'Password does not match';
      MSG.errorSnackBar(EditCtrl.password2Err.value);
    } else {
      Preloader.show();

      var data = User.map(
        password: EditCtrl.password.text,
        password2: EditCtrl.password2.text,
        email: EditCtrl.email.text,
      );
      var response = await Provider().postData("login/change-password", data);
      if (response != null) {
        Preloader.hide();
        MSG.snackBar('Password Changed successfully');
        Get.offNamed(RouteStr.login);
      }
    }
  }
}
