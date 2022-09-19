import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/instance.dart';
import '../../utils/utils.dart';

class AppBarNotification extends StatelessWidget {
  const AppBarNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: homeCtrl.getNewNotifications(),
        builder: (context, snap) {
          return snap.hasData && homeCtrl.newNotifications.value != 0
              ? Obx(
                  () => homeCtrl.newNotifications.value == 0
                      ? const SizedBox.shrink()
                      : Positioned(
                          right:  1,
                          top:  1,
                          child: CircleAvatar(
                            backgroundColor: Utils.isMobileApp ? Colors.black : Colors.red,
                            radius: 8,
                            child: Text(
                              homeCtrl.newNotifications.value.toString(),
                              style: const TextStyle(color: Colors.white, height: 1, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                )
              : const SizedBox.shrink();
        });
  }
}
