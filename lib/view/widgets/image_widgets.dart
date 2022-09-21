import 'package:brixmarket/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme/color.dart';
import '../../controllers/instance.dart';
import '../../core/app.dart';
import '../../res/strings.dart';
import 'current_location.dart';
import 'custom_text.dart';

circleProfileImage({double radius = 45}) {
  reInitInstance();
  return CircleAvatar(
    radius: radius + 2,
    backgroundColor: Colors.blueGrey,
    child: CircleAvatar(
      radius: radius,
      backgroundImage: (user.image != null && user.image != '') ? NetworkImage('$userImgPath${user.image}') as ImageProvider : const AssetImage(ImgStr.avatarImg),
    ),
  );
}

profileImgAndRefId() {
  reInitInstance();
  return Column(
    children: [
      circleProfileImage(),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(
            color: Colors.black,
            size: 14,
            text: Str.refIdPrefix,
          ),
          CustomText(
            color: Pallet.secondaryColor,
            size: 14,
            text: user.refId,
          ),
        ],
      ),
    ],
  );
}

profileImgAndBasicInfo() {
  reInitInstance();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteStr.mobileProfileHome);
              },
              child:circleProfileImage(),
            ),

            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CustomText(
                      color: !Utils.isMobileApp ? Colors.white : Colors.black,
                      size: 14,
                      text: 'REF ID: ',
                    ),
                    CustomText(
                      color: Pallet.secondaryColor,
                      size: 14,
                      text: user.refId,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Obx(() => CustomText(
                      color: !Utils.isMobileApp ? Colors.white70 : Colors.black,
                      size: 18,
                      text: accountName(user: homeCtrl.user.value),
                      weight: FontWeight.bold,
                    )),
                const SizedBox(height: 4),
                CustomText(
                  color: !Utils.isMobileApp ? Colors.white70 : Colors.black,
                  size: 14,
                  text: user.emailAddress ?? '',
                ),
                !Utils.isMobileApp ? const SizedBox.shrink() : const SizedBox(height: 4),
                !Utils.isMobileApp ? const SizedBox.shrink() : const CurrentLocation(color: Colors.black87),
              ],
            )
          ]),
          const SizedBox(height: 24),
          user.isUser == true
              ? const SizedBox.shrink()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Status: '),
                    Obx(() => homeCtrl.user.value.agency?.isVerified == true
                        ? Row(
                            children: const [
                              Icon(
                                Icons.verified_user,
                                size: 16,
                                color: Colors.green,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Verified',
                                style: TextStyle(color: Colors.green),
                              ),
                              SizedBox(width: 4),
                            ],
                          )
                        : Row(
                            children: const [
                              Icon(
                                Icons.verified_user,
                                size: 16,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Pending verification',
                                style: TextStyle(color: Colors.orange),
                              ),
                              SizedBox(width: 4),
                            ],
                          )),
                  ],
                )
        ],
      ),
    ),
  );
}
