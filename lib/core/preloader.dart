import 'dart:async';

import 'package:brixmarket/config/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/strings.dart';
import '../utils/utils.dart';

class Preloader extends StatefulWidget {
  const Preloader({Key? key}) : super(key: key);

  static late Timer timer;

  static show() {
    Get.dialog(const Preloader());
  }

  static hide() {
    if (!Utils.isMobileApp || true) {
      if (Get.isDialogOpen == true) {
        try {
          Get.back();
        } catch (e) {
          dnd(e);
        }
      }
    } else if (Get.isDialogOpen.runtimeType != Null) {
      if (Get.isDialogOpen == true) {
        try {
          timer.cancel();
          Get.back();
        } catch (e, t) {
          dnd(e);
          dnd(t);
          // Get.back();
        }
      }
      if (Get.isDialogOpen == true) {
        try {
          Get.back();
        } catch (e) {
          dnd(e);
        }
      }
    }
  }

  @override
  State<Preloader> createState() => _PreloaderState();

  static loadingWidget() {
    return const Center(child: SizedBox(width: 32, height: 32, child: CircularProgressIndicator()));
  }

  static loadingWidget2({double size = 48}) {
    return Center(
        child: Image.asset(
      ImgStr.loadingImg,
      width: size,
      height: size,
    ));
  }
}

class _PreloaderState extends State<Preloader> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation heartbeatAnimation;

  @override
  void initState() {
    super.initState();
    if (Utils.isMobileApp && false) {
      controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
      heartbeatAnimation = Tween<double>(begin: 124.0, end: 24.0).animate(controller);
      controller.forward().whenComplete(() {
        controller.reverse();
      });
      repeat();
    }
  }

  repeat() {
    Preloader.timer = Timer.periodic(const Duration(milliseconds: 1050), (Timer timer) {
      if (mounted) {
        try {
          setState(() {
            controller.forward().whenComplete(() {
              controller.reverse();
            });
          });
        } catch (e) {
          dnd(e);
        }
      } // This statement will be printed after every one second
    });
  }

  @override
  void dispose() {
    // Preloader.timer.cancel();
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        onTap: Preloader.hide,
        child: !Utils.isMobileApp || true
            ? Container(
                width: _screenWidth,
                height: _screenHeight,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset('assets/images/load.gif', width: 38),
                    Image.asset(ImgStr.loadingBalls, height: isMobile() ? 94 : 124),
                    SizedBox(
                      height: isTabletDown() ? 16 : 48,
                      width: 16,
                    ),
                    Image.asset(ImgStr.logoDark, height: isMobile() ? 48 : 64),
                    SizedBox(
                      height: 88,
                      width: 16,
                    ),
                    // Image.asset(ImgStr.loadingRedBalls, height: isMobile() ? 48 : 64),
                  ],
                ))
            : Container(
                width: _screenWidth,
                height: _screenHeight,
                decoration: const BoxDecoration(
                  color: Pallet.secondaryColor,
                  // image: DecorationImage(image: AssetImage('assets/images/loader.gif')),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: SizedBox(
                        width: _screenWidth,
                        height: _screenHeight,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: heartbeatAnimation,
                            builder: (context, widget) {
                              return Image.asset(
                                ImgStr.logo2,
                                width: heartbeatAnimation.value,
                                // color: Colors.white70,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: SizedBox(
                        width: _screenWidth,
                        height: _screenHeight,
                        child: Center(
                          child: Image.asset(ImgStr.logo2, width: 124, color: Colors.white30),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 72,
                      child: SizedBox(
                          width: _screenWidth,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/load.gif', width: 28),
                              const SizedBox(width: 8),
                              const Text(
                                Str.wait,
                                style: TextStyle(color: Pallet.whiteColor, fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            ],
                          ))),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
