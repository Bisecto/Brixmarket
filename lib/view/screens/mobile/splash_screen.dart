import 'dart:async';
import 'dart:io';

import 'package:brixmarket/utils/shared_preferences.dart';
import 'package:brixmarket/view/screens/no_internet.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../controllers/edit_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/instance.dart';
import '../../../core/dialogs.dart';
import '../../../res/strings.dart';
import '../../../utils/utils.dart';
import 'landing_page.dart';
import 'onboard_page.dart';

class SplashScreen extends StatefulWidget {
  static String splashScreen = '/splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String userMail = '';
  String userPassword = '';

  userDetails() async {
    userMail = await SharedPref.getString('user_email');
    userPassword = await SharedPref.getString('user_password');
    EditCtrl.email.text = userMail;

      if (userMail.isNotEmpty &&
        userPassword.isNotEmpty ) {
      homeCtrl.login(email: userMail,password: userPassword ).then((value) => {
            EditCtrl.email.text = '',

      });
    }
  }
  @override
  void initState() {

     userDetails();
    checkpermission();
    super.initState();
   

  

    // Connectivity().checkConnection().then((connected) async {
    //   SharedPref.getBool('acceptLocationUsage').then((accepted) async {
    //     //dnd(accepted);
    //     if(accepted == true) {
    //       if (connected) {
    //         await openApp();
    //       } else {
    //         Get.to(() =>
    //             NoInternet(
    //                 callBack: () => Get.offNamed(RouteStr.mobileSplashscreen),
    //                 reInitApp: true));
    //       }
    //     } else {
    //       if (connected) {
    //         await openApp();
    //       } else {
    //         Get.to(() =>
    //             NoInternet(
    //                 callBack: () => Get.offNamed(RouteStr.mobileSplashscreen),
    //                 reInitApp: true));
    //       }
    //       //Get.offNamed(RouteStr.mobileAcceptLocationUsage);
    //     }
    //   });
    //
    // });
  }

  checkpermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await SharedPref.putBool("isPermissionEnabled", false);
      //await SharedPref.putBool('acceptLocationUsage', true);
      Connectivity().checkConnection().then((connected) async {
        if (connected) {
          await openApp();
        } else {
          Get.to(() => NoInternet(
              callBack: () => Get.offNamed(RouteStr.mobileSplashscreen),
              reInitApp: true));
        }
      });
    } else {
      await SharedPref.putBool("isPermissionEnabled", false);
      //await SharedPref.putBool('acceptLocationUsage', false);
      Connectivity().checkConnection().then((connected) async {
        if (connected) {
          await openApp();
        } else {
          Get.to(() => NoInternet(
              callBack: () => Get.offNamed(RouteStr.mobileSplashscreen),
              reInitApp: true));
        }
      });
    }
  }

  openApp() async {
    bool firstOpen = (await SharedPref.getBool('firstOpen')) ?? false;

    if (firstOpen) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const MobileLandingPage(),
          ),
        );
        //Get.offAndToNamed(RouteStr.mobileLanding);
      });
    } else {
      await SharedPref.putBool('firstOpen', true);
      if (Platform.isAndroid) {
        showDialog<AlertDialog>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actions: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Allow Brixmarket to Use your location',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'This app collects location data to enable you find and discover properties near you even when the app is closed or when not in use',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: const Text(
                                'Deny',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                //Navigator.of(context).pop();
                                // Future.delayed(const Duration(seconds: 3), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const OnBoardingPage(),
                                  ),
                                );
                                //Get.offAndToNamed(RouteStr.mobileLanding);
                                // });
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'Accept',
                                style: TextStyle(color: Colors.green),
                              ),
                              onPressed: () async {
                                //Navigator.pop(context);
                                await Utils.getCurrentLocation();

                                //Future.delayed(const Duration(seconds: 3), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const OnBoardingPage(),
                                  ),
                                );
                                //Get.offAndToNamed(RouteStr.mobileLanding);
                                // });
                                // switch (heading) {
                                //   case 'Message':
                                //     homeCtrl.loginRequest(
                                //         request: () {
                                //           Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder: (context) =>
                                //                 const ChatPage()),
                                //           );
                                //         });
                                //
                                //     break;
                                //   case 'Review':
                                //     return;
                                //   default:
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //           const HomeNotificationsPage()),
                                //     );
                                //     break;
                                // }
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const OnBoardingPage(),
            ),
          );

          //Get.offAndToNamed(RouteStr.mobileOnboard);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImgStr.logoDark, height: isMobile() ? 54 : 64),
            const SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
