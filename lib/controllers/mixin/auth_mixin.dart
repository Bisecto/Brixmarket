import 'package:get/get.dart';

import '../../core/dialogs.dart';
import '../../core/preloader.dart';
import '../../libs/payments.dart';
import '../../models/upgrade_plans.dart';
import '../../models/user_model.dart';
import '../../res/strings.dart';
import '../../services/provider.dart';
import '../../utils/utils.dart';
import '../../utils/validations.dart';
import '../../view/screens/mobile/sub_payment.dart';
import '../edit_controller.dart';
import '../home_controller.dart';
import '../instance.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

mixin Auth {
  var loading = false;
  var showPassword = false.obs;

  gotoSignUpPage(userType) {
    EditCtrl.userType.value = userType;
    Get.toNamed(RouteStr.register);
  }

  Future register() async {
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    // String? token = await messaging.getToken(
    //   vapidKey: "BGpdLRs......",
    // );

    EditCtrl.emailErr.value = Val.email(EditCtrl.email.text);
    EditCtrl.passwordErr.value = Val.password(EditCtrl.password.text);
    if (EditCtrl.emailErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        EditCtrl.emailErr.value,
      );
    } else if (EditCtrl.passwordErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        EditCtrl.passwordErr.value,
      );
    } else if (!EditCtrl.acceptTerms.value) {
      MSG.errorSnackBar(
        Str.notAcceptedOurTerms,
      );
    } else {
      Preloader.show();

      var data = User.map(
        email: EditCtrl.email.text,
        password: EditCtrl.password.text,
        isAgency: EditCtrl.userType.value == 'Agency' ? '1' : '0',
        isAgent: EditCtrl.userType.value == 'Agent' ? '1' : '0',
        isUser: EditCtrl.userType.value == 'User' ? '1' : '0',
      );
      var response = await Provider().postData("register", data);
      Preloader.hide();
      if (response != null) {
        var userObj = User.fromJson(response);
        await homeCtrl.tmpLogin(userObj);
        EditCtrl.disposeControllers();
        Get.offAndToNamed(RouteStr.verityOtp);
      }
    }
  }

  Future resendOTP() async {
    Preloader.show();

    var data = User.map(userId: HomeController.tmpUserId);
    var response = await Provider().postData("register/send-OTP", data);
    if (response != null) {
      var userObj = User.fromJson(response);
      await homeCtrl.tmpLogin(userObj);
      Preloader.hide();
    }
  }

  Future verifyOTP() async {
    Preloader.show();

    var data = User.map(otp: EditCtrl.otp.text, userId: HomeController.tmpUserId);
    var response = await Provider().postData("register/verify-OTP", data);
    EditCtrl.otp.text = '';
    if (response != null) {
      var userObj = User.fromJson(response);
      await homeCtrl.loginUser(userObj);
      Preloader.hide();
      EditCtrl.disposeControllers();
      Get.offAndToNamed(RouteStr.regBasic);
    }
  }

  Future login() async {
    try {
      EditCtrl.emailErr.value = Val.email(EditCtrl.email.text);
      if (EditCtrl.emailErr.isNotEmpty) {
        MSG.errorSnackBar(EditCtrl.emailErr.value);
      } else {
        Preloader.show();
        var data = User.map(email: EditCtrl.email.text, password: EditCtrl.password.text);
        var response = await Provider().postData("login", data);

        if (response != null) {
          EditCtrl.disposeControllers();
          var userObj = User.fromJson(response);

          if (userObj.isVerified == false) {
            await homeCtrl.tmpLogin(userObj);

            Get.offAndToNamed(RouteStr.verityOtp);
          } else if (userObj.surname == '' || userObj.surname.runtimeType == Null) {
            await homeCtrl.tmpLogin(userObj);

            Preloader.hide();
            Get.offAndToNamed(RouteStr.regBasic);
          } else {
            if (userObj.isAgent == true || userObj.isAgency == true) {
              if (userObj.agency?.name == '' || userObj.agency?.name == '') {
                await homeCtrl.tmpLogin(userObj);
                Preloader.hide();
                Get.offAndToNamed(RouteStr.regAgency);
                return null;
              }
            }
            print('{{}}}}}}}}}}}{{{{{{{{}}}}}}}}PPPPPP{}}{{&&&&&******((()()))');
            await homeCtrl.loginUser(userObj);
            await propCtrl.getSavedProperties();
            Preloader.hide();
            MSG.snackBar('Login successful');
            //FirebaseMessaging.instance.subscribeToTopic(_userId);
            //print('$_userId*******00000000001231234567812345678`12345678**************');
            Utils.gotoHomePage();
          }
        }

        Preloader.hide();
      }
    } catch (e) {
      Preloader.hide();
      MSG.errorSnackBar(e.toString());
    }
  }

  Future regBasic() async {
    EditCtrl.surnameErr.value = Val.name(EditCtrl.surname.text);
    EditCtrl.firstNameErr.value = Val.name(EditCtrl.firstName.text);
    EditCtrl.phoneErr.value = Val.phone(EditCtrl.phone.text);
    if (EditCtrl.surnameErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Surname field is required',
      );
    } else if (EditCtrl.firstNameErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'First name field is required',
      );
    } else if (EditCtrl.phoneErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Phone number not valid',
      );
    } else if (!EditCtrl.acceptPhone.value && EditCtrl.image8Lists.isNotEmpty) {
      MSG.errorSnackBar(
        'You have not accepted the profile image terms',
      );
    } else {
      Preloader.show();

      var data = User.map(
        surname: EditCtrl.surname.text,
        firstName: EditCtrl.firstName.text,
        phone: EditCtrl.phone.text,
      );
      var response = await Provider().postFiles("register/user-basic", EditCtrl.image8Lists, data: data);
      if (response != null) {
        EditCtrl.disposeControllers();
        var userObj = User.fromJson(response);
        await homeCtrl.loginUser(userObj);
        Preloader.hide();
        if (!(userObj.isUser ?? false)) {
          Get.offAndToNamed(RouteStr.regAgency);
        } else {
          Utils.gotoHomePage();
        }
      }
    }
  }

  Future regAgency() async {
    Map<String, dynamic> data = {};

    EditCtrl.agencyNameErr.value = Val.name(EditCtrl.agencyName.text);
    EditCtrl.addressErr.value = Val.name(EditCtrl.address.text);

    if (EditCtrl.isRegisterAgency.value) {
      EditCtrl.legalNameErr.value = Val.name(EditCtrl.legalName.text);
      EditCtrl.rcNumberErr.value = Val.number(EditCtrl.rcNumber.text);
    }

    if (EditCtrl.agencyNameErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Agency name field is required',
      );
    } else if (EditCtrl.state.value.text.isEmpty) {
      MSG.errorSnackBar(
        'Location state of agency is required',
      );
    } else if (EditCtrl.city.value.text.isEmpty) {
      MSG.errorSnackBar(
        'Location town of agency is required',
      );
    } else if (EditCtrl.addressErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Location town of agency is required',
      );
    } else if (EditCtrl.isRegisterAgency.value) {
      if (EditCtrl.legalNameErr.value.isNotEmpty) {
        MSG.errorSnackBar(
          'Registered name field is required',
        );
      } else if (EditCtrl.rcNumberErr.value.isNotEmpty) {
        MSG.errorSnackBar(
          'RC number of agency is required',
        );
      } else if (EditCtrl.image8Lists.isEmpty) {
        MSG.errorSnackBar(
          'CAC Certificate upload is required',
        );
      } else {
        data = User.map(
          agencyName: EditCtrl.agencyName.text,
          state: EditCtrl.state.value.text,
          city: EditCtrl.city.value.text,
          address: EditCtrl.address.text,
          legalName: EditCtrl.legalName.text,
          rcNumber: EditCtrl.rcNumber.text,
          legalStatus: 'Registered',
        );
      }
    } else {
      data = User.map(
        agencyName: EditCtrl.agencyName.text,
        state: EditCtrl.state.value.text,
        city: EditCtrl.city.value.text,
        address: EditCtrl.address.text,
        legalStatus: 'Not Registered',
      );
    }

    if (data.isNotEmpty) {
      Preloader.show();
      var response = await Provider().postFiles("register/register-agency", EditCtrl.image8Lists, data: data);
      if (response != null) {
        EditCtrl.disposeControllers();
        MSG.snackBar('Registration completed!!');
        var userObj = User.fromJson(response);
        await homeCtrl.loginUser(userObj);
        Preloader.hide();
        Utils.gotoHomePage();
      }
    }
  }

  Future premiumUpgrade({bool updateId = false, bool updateLocation = false}) async {
    Map<String, dynamic> data = {};
    if (updateLocation) {
      if (EditCtrl.state.value.text.isEmpty) {
        MSG.errorSnackBar(
          'Location state of agency is required',
        );
      } else if (EditCtrl.city.value.text.isEmpty) {
        MSG.errorSnackBar(
          'Location town of agency is required',
        );
      } else if (EditCtrl.address.text.isEmpty) {
        MSG.errorSnackBar(
          'Registered name field is required',
        );
      } else {
        Preloader.show();
        data = User.map(
          state: EditCtrl.state.value.text,
          city: EditCtrl.city.value.text,
          address: EditCtrl.address.text,
        );
      }
    }
    if (updateId) {
      if (EditCtrl.idType.value.text.isEmpty) {
        MSG.errorSnackBar(
          'Identification type is not selected',
        );
      } else if (EditCtrl.idNumber.text.isEmpty) {
        MSG.errorSnackBar(
          'Identification card number is required',
        );
      } else if (EditCtrl.image8Lists.isEmpty && updateLocation == true) {
        MSG.errorSnackBar(
          'Identification image upload is required',
        );
      } else {
        Preloader.show();
        data = User.map(idType: EditCtrl.idType.value.text, idNumber: EditCtrl.idNumber.text);
      }
    }
    dynamic response;
    if (updateId && EditCtrl.image8Lists.isNotEmpty) {
      response = await Provider().postFiles("register/user-premium-upgrade", EditCtrl.image8Lists, data: data);
    } else {
      response = await Provider().postData("register/user-premium-upgrade", data);
    }
    if (response != null) {
      EditCtrl.disposeControllers();
      var userObj = User.fromJson(response);
      await homeCtrl.loginUser(userObj);
      Preloader.hide();
      if (updateId && updateLocation) {
        Utils.gotoHomePage();
      } else {
        MSG.snackBar('Updated successfully');
      }
    }
  }

  // selectIdImage() async {
  //   EditCtrl.imageFile = await Utils.filePicker();
  //   EditCtrl.idPhoto.text = EditCtrl.imageFile != null ? EditCtrl.imageFile!.path : '';
  // }

  // selectCacImage() async {
  //   EditCtrl.imageFile = await Utils.filePicker();
  //   EditCtrl.agencyCacCert.text = EditCtrl.imageFile != null ? EditCtrl.imageFile!.path : '';
  // }

  makePayment({context, email, amount, ref}) async {
    // return paymentSuccess('reference');
    UpgradePlan plan = homeCtrl.selectedUpgradePlan!;
    var map = <String, String>{'plan': plan.id!, 'userId': user.id!};
    ///Had to commet this out becase its not been used currently.And it gives error to the android
    // await Payments.paystackPayment(
    //   Get.context!,
    //   email: user.emailAddress!,
    //   amount: plan.amount!,
    //   meta: map,
    //   successCallBack: paymentSuccess,
    //   failedCallBack: paymentFailed,
    // );
  }

  paymentSuccess(reference) async {
    Preloader.show();

    var data = User.map();
    var response = await Provider().postData("user/verify-payment/$reference", data);
    if (response != null) {
      // var userObj = User.fromJson(response);
      // await homeCtrl.loginUser(userObj);
      Preloader.hide();
      Get.back();
      Get.back();
      Get.dialog(paymentSuccessDialog());
    }
  }

  paymentFailed(response) {}

  updateSettings() async {
    Preloader.show();

    var data = user.settings?.toJson();

    var response = await Provider().postData("user/update-setting", data!);
    if (response != null) {
      var userObj = User.fromJson(response);
      await homeCtrl.loginUser(userObj);
      Preloader.hide();
      MSG.snackBar('Updated successfully');
    }
  }

  submitChangePassword() async {
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
        passwordOld: EditCtrl.passwordOld.text,
      );
      var response = await Provider().postData("user/change-password", data);
      if (response != null) {
        EditCtrl.disposeControllers();
        Preloader.hide();
        MSG.snackBar('Updated successfully');
      }
    }
  }

  submitUpdateProfile() async {
    EditCtrl.surnameErr.value = Val.name(EditCtrl.surname.text);
    EditCtrl.firstNameErr.value = Val.name(EditCtrl.firstName.text);
    EditCtrl.phoneErr.value = Val.phone(EditCtrl.phone.text);
    if (EditCtrl.surnameErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Surname field is required',
      );
    } else if (EditCtrl.firstNameErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'First name field is required',
      );
    } else if (EditCtrl.phoneErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Phone number not valid',
      );
    } else {
      Preloader.show();

      var data = User.map(
        surname: EditCtrl.surname.text,
        firstName: EditCtrl.firstName.text,
        phone: EditCtrl.phone.text,
      );
      var response = await Provider().postFiles("user/update", EditCtrl.image8Lists, data: data);
      if (response != null) {
        //EditCtrl.disposeControllers();
        var userObj = User.fromJson(response);
        await homeCtrl.loginUser(userObj);
        Preloader.hide();
        MSG.snackBar('Updated successfully');
      }
    }
  }

  updateAgencyDetails() async {
    EditCtrl.agencyNameErr.value = Val.name(EditCtrl.agencyName.text);
    EditCtrl.addressErr.value = Val.name(EditCtrl.address.text);

    if (EditCtrl.agencyNameErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Agency name field is required',
      );
    } else if (EditCtrl.state.value.text.isEmpty) {
      MSG.errorSnackBar(
        'Location state of agency is required',
      );
    } else if (EditCtrl.city.value.text.isEmpty) {
      MSG.errorSnackBar(
        'Location town of agency is required',
      );
    } else if (EditCtrl.addressErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Location town of agency is required',
      );
    } else {
      Map<String, dynamic> data = User.map(
        agencyName: EditCtrl.agencyName.text,
        state: EditCtrl.state.value.text,
        city: EditCtrl.city.value.text,
        address: EditCtrl.address.text,
      );
      Preloader.show();
      var response = await Provider().postData("user/update-agent", data);
      if (response != null) {
        EditCtrl.disposeControllers();
        var userObj = User.fromJson(response);
        await homeCtrl.loginUser(userObj);
        Preloader.hide();
        MSG.snackBar('Updated successfully!!!');
      }
    }
  }

  updateAgencyDocument() async {
    Map<String, dynamic> data = {};

    EditCtrl.legalNameErr.value = Val.name(EditCtrl.legalName.text);
    EditCtrl.rcNumberErr.value = Val.number(EditCtrl.rcNumber.text);

    if (EditCtrl.legalNameErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'Registered name field is required',
      );
    } else if (EditCtrl.rcNumberErr.value.isNotEmpty) {
      MSG.errorSnackBar(
        'RC number of agency is required',
      );
    } else {
      Preloader.show();
      data = User.map(
        legalName: EditCtrl.legalName.text,
        rcNumber: EditCtrl.rcNumber.text,
      );
      dynamic response;
      if (EditCtrl.image8Lists.isEmpty) {
        response = await Provider().postData("user/update-agency-document", data);
      } else {
        response = await Provider().postFiles("user/update-agency-document", EditCtrl.image8Lists, data: data);
      }
      if (response != null) {
        EditCtrl.disposeControllers();
        var userObj = User.fromJson(response);
        await homeCtrl.loginUser(userObj);
        Preloader.hide();
        MSG.snackBar('Updated successfully!!!');
      }
    }
  }
}
