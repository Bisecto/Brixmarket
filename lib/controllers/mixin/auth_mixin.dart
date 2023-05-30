import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app.dart';
import '../../core/dialogs.dart';
import '../../core/preloader.dart';
import '../../libs/payments.dart';
import '../../models/api_response_model.dart';
import '../../models/upgrade_plans.dart';
import '../../models/user_model.dart';
import '../../res/strings.dart';
import '../../services/provider.dart';
import '../../utils/shared_preferences.dart';
import '../../utils/utils.dart';
import '../../utils/validations.dart';
import '../../view/screens/authentication_pages/verify_reg_otp_page.dart';
import '../../view/screens/mobile/splash_screen.dart';
import '../../view/screens/mobile/sub_payment.dart';
import '../edit_controller.dart';
import '../home_controller.dart';
import '../instance.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

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
    await SharedPref.putString('user_email', EditCtrl.email.text);
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
        print(response);
        await homeCtrl.tmpLogin(userObj);
        await SharedPref.putString('user_email', EditCtrl.email.text);
        await SharedPref.putString('user_password', EditCtrl.password.text);
        //EditCtrl.disposeControllers();
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
  Future resendOTP2() async {
    Preloader.show();

    var data = User.map(userId: HomeController.tmpUserId);
    print(HomeController.tmpUserId);
    print(HomeController.tmpUserId);
    print(HomeController.tmpUserId);
    var response = await Provider().postData("register/send-OTP", data);
    if (response != null) {
      var userObj = User.fromJson(response);
      await homeCtrl.tmpLogin(userObj);
      Preloader.hide();
    }
  }

  Future verifyOTP() async {
    Preloader.show();

    var data =
        User.map(otp: EditCtrl.otp.text, userId: HomeController.tmpUserId);
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
  Future verifyOTP2() async {
    Preloader.show();
    print(EditCtrl.otp.text);
    print(HomeController.tmpUserId);
    print(EditCtrl.password.text);
    print(EditCtrl.email.text);

    var Url = Uri.parse('https://api.brixmarket.site/login/verify-OTP');
    var header = {
      'Authorization': 'Bearer ',
      'Cookie': 'PHPSESSID=iddn76vfj1indejroutud0m4ec'
    };
    var data =
    User.map(otp: EditCtrl.otp.text, userId: HomeController.tmpUserId,email: EditCtrl.email.text,password: EditCtrl.password.text);
    //var response = await Provider().postData("register/verify-OTP", data);
    final res =
    await http.post(Url,headers: header,body: {
      'email_address': EditCtrl.email.text,
      'password': EditCtrl.password.text,
      'otp': EditCtrl.otp.text
    });
    final dataBody = await jsonDecode(res.body);
    print(dataBody);
    EditCtrl.otp.text = '';
    if (dataBody['status']) {
      var userObj = User.fromJson(dataBody);
      await homeCtrl.loginUser(userObj);
      Preloader.hide();
      EditCtrl.disposeControllers();
      Get.offAndToNamed(RouteStr.regBasic);
    }else{
      MSG.errorSnackBar('Your entered an invalid Verification code');

    }
  }
    Future mainlLogin({String? email, String? password} ) async {

    try {
      EditCtrl.emailErr.value = Val.email(EditCtrl.email.text);
      if (EditCtrl.emailErr.isNotEmpty) {
        if(email != null){
          MSG.snackBar('email');

        }else{
          MSG.errorSnackBar(EditCtrl.emailErr.value);

        }
      } else {
        Preloader.show();
        var Url = Uri.parse('$appBaseUrl login');

        var data = User.map(
            email: email ??  EditCtrl.email.text, password: password ?? EditCtrl.password.text);
        final res =
        await http.post(Url,headers: headers,body: data);
        final dataBody = await jsonDecode(res.body);
        //var response = await Provider().postData("login", data);
        print(dataBody);

        if (dataBody['data'] != null) {
          await SharedPref.putString('user_email', EditCtrl.email.text);
          await SharedPref.putString('user_password', EditCtrl.password.text);
          // loginNew(
          //     email: EditCtrl.email.text, password: EditCtrl.password.text);
          User userObj = User.fromJson(dataBody['data']);
          print(userObj);
          Preloader.hide();
          if (userObj.isVerified == false) {
            print('ONENATION1');
            await homeCtrl.mainTmpLogin(userObj);
            print('ONENATION2');
            Get.offAndToNamed(RouteStr.verityOtp);

          } else if (userObj.surname == '' ||
              userObj.surname.runtimeType == Null) {
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

            await homeCtrl.loginUser(userObj);
            await propCtrl.getSavedProperties(homeCtrl.user.value.id);
            Preloader.hide();
            // MSG.snackBar('Login successful');
            if (Utils.isMobileApp) {
              FirebaseMessaging.instance
                  .subscribeToTopic(userObj.id.toString());
            }
            Utils.gotoHomePage();
          }
        } else{
          Preloader.hide();
          MSG.errorSnackBar('Invalid login combination');

        }

       // Preloader.hide();
      }
    } catch (e) {
      Preloader.hide();
      if (kDebugMode) {
        print(e.toString());
      }
      //MSG.errorSnackBar(e.toString());
    }
  }
  Future login({String? email, String? password} ) async {

    try {
      EditCtrl.emailErr.value = Val.email(EditCtrl.email.text);
      if (EditCtrl.emailErr.isNotEmpty) {
        if(email != null){
        MSG.snackBar('email');

        }else{
        MSG.errorSnackBar(EditCtrl.emailErr.value);

        }
      } else {
        Preloader.show();
        var data = User.map(
            email: email ??  EditCtrl.email.text, password: password ?? EditCtrl.password.text);
        var response = await Provider().postData("login", data);
        if (kDebugMode) {
          print(123456789);
          print(response);
          print(098765432);
        }


        if (response != null) {
          await SharedPref.putString('user_email', EditCtrl.email.text);
          await SharedPref.putString('user_password', EditCtrl.password.text);
          // loginNew(
          //     email: EditCtrl.email.text, password: EditCtrl.password.text);
          var userObj = User.fromJson(response);
          if (kDebugMode) {
            print(111111111111);
            print(userObj);
            print(111111111111);
          }
          if (userObj.isVerified == false) {
            await homeCtrl.tmpLogin(userObj);

            Get.offAndToNamed(RouteStr.verityOtp);

          } else if (userObj.surname == '' ||
              userObj.surname.runtimeType == Null) {
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

            await homeCtrl.loginUser(userObj);
            await propCtrl.getSavedProperties(homeCtrl.user.value.id);
            Preloader.hide();
            // MSG.snackBar('Login successful');
            if (Utils.isMobileApp) {
              FirebaseMessaging.instance
                  .subscribeToTopic(userObj.id.toString());
            }
            Utils.gotoHomePage();
          }
        }

        Preloader.hide();
      }
    } catch (e) {
      Preloader.hide();
      print(e.toString());
      MSG.errorSnackBar(e.toString());
    }
  }

  Future loginNew({required String email, required String password}) async {
    try {
      var data = User.map(email: email, password: password);
      var response = await Provider().postData(
        "login",
        data,
        baseUrl: 'https://api.brixmarket.site/',
      );

      if (response != null) {
        // MSG.snackBar('_token');
        EditCtrl.disposeControllers();
        var userObj = User.fromJson(response);

        String _token = userObj.token!;
        await SharedPref.putString('token', _token);
        //dnd(_token);
        //  MSG.snackBar(_token);
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
      var headers = {
        'Authorization': 'Bearer ',
        'Cookie': 'PHPSESSID=iddn76vfj1indejroutud0m4ec'
      };
      var request = http.MultipartRequest('POST', Uri.parse('https://api.brixmarket.site/register/user-basic'));
      request.fields.addAll({
        'surname': EditCtrl.surname.text,
        'first_name': EditCtrl.firstName.text,
        'phone_number': EditCtrl.phone.text,
        'email_address':  await SharedPref.getString('user_email'),
      });
      print(await SharedPref.getString('user_email'));
      print(EditCtrl.email.text);
      if(EditCtrl.image8Lists.isNotEmpty) {
        request.files.add(http.MultipartFile.fromBytes(
            'image', EditCtrl.image8Lists[0], filename: 'profileImage.jpg'));
      }
      request.headers.addAll(headers);

      http.StreamedResponse httpResponse = await request.send();
      var response = await http.Response.fromStream(httpResponse).timeout(
          timeOutDuration2,
          onTimeout: () => http.Response('Request time out', 408));
      var result=Provider().processResponse(response);
      print(123456123456);
      //print(await httpResponse.stream.bytesToString());

      print('OK8');

      ///if (response.statusCode == 200) {

        if (result!=null) {
          EditCtrl.disposeControllers();
          var userObj = User.fromJson(result);
          print(userObj.id);
          await homeCtrl.loginUser(userObj);
          Preloader.hide();
          if (!(userObj.isUser ?? false)) {
            Get.offAndToNamed(RouteStr.regAgency);
          } else {
            if (Utils.isMobileApp) {
              FirebaseMessaging.instance.subscribeToTopic(userObj.id.toString());
            }
            Navigator.pushReplacement(
              context!,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
            );
            //Utils.gotoHomePage();
          }
        }
        //print(response);
        Preloader.hide();





    }
  }

  Future regAgency() async {
    print(await SharedPref.getString('token'));
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
        print('Registered');
        data = User.map(
          agencyName: EditCtrl.agencyName.text,
          state: EditCtrl.state.value.text,
          city: EditCtrl.city.value.text,
          address: EditCtrl.address.text,
          legalName: EditCtrl.legalName.text,
          rcNumber: EditCtrl.rcNumber.text,
          legalStatus: 'Registered',
          email:await SharedPref.getString('user_email')
        );
      }
    } else {
      print('Not Registered');
      data = User.map(
        agencyName: EditCtrl.agencyName.text,
        state: EditCtrl.state.value.text,
        city: EditCtrl.city.value.text,
        address: EditCtrl.address.text,
        legalStatus: 'Not Registered',
          email:await SharedPref.getString('user_email')
      );
    }

    if (data.isNotEmpty) {
      Preloader.show();
      // var headers = {
      //   'Authorization': 'Bearer ${await SharedPref.getString('token')}',
      //   'Cookie': 'PHPSESSID=k4p9p805otjvkj5u8s7g7fl1hc'
      // };
      // var request = http.MultipartRequest('POST', Uri.parse('$appBaseUrl register/register-agency'));
      // request.fields.addAllIf(
      //
      //   data
      // );
      var response = await Provider().postFiles(
          "register/register-agency", EditCtrl.image8Lists,
          data: data);
      if (response != null) {
        EditCtrl.disposeControllers();
        MSG.snackBar('Registration completed!!');
        var userObj = User.fromJson(response);
        await homeCtrl.loginUser(userObj);
        Preloader.hide();
        Utils.gotoHomePage();
        if (Utils.isMobileApp) {
          FirebaseMessaging.instance.subscribeToTopic(userObj.id.toString());
        }
      }
    }
  }

  Future premiumUpgrade(
      {bool updateId = false, bool updateLocation = false}) async {
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
        data = User.map(
            idType: EditCtrl.idType.value.text,
            idNumber: EditCtrl.idNumber.text);
      }
    }
    dynamic response;
    if (updateId && EditCtrl.image8Lists.isNotEmpty) {
      response = await Provider().postFiles(
          "register/user-premium-upgrade", EditCtrl.image8Lists,
          data: data);
    } else {
      response =
          await Provider().postData("register/user-premium-upgrade", data);
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
    var response =
        await Provider().postData("user/verify-payment/$reference", data);
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
      var response = await Provider()
          .postFiles("user/update", EditCtrl.image8Lists, data: data);
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
        response =
            await Provider().postData("user/update-agency-document", data);
      } else {
        response = await Provider().postFiles(
            "user/update-agency-document", EditCtrl.image8Lists,
            data: data);
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
