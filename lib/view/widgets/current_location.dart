import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../controllers/instance.dart';
import '../../core/preloader.dart';
import '../../utils/utils.dart';
import 'custom_text.dart';

class CurrentLocation extends StatelessWidget {
  final Color color;
  const CurrentLocation({Key? key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var permission =  Geolocator.checkPermission();
    // dnd(homeCtrl.currentLocation.value);
    // if(permission == LocationPermission.denied || permission == LocationPermission.whileInUse){
    return FutureBuilder(
        future: Utils.getState(),
        builder: (context, AsyncSnapshot snap) {
          return snap.connectionState == ConnectionState.waiting && homeCtrl.currentLocation.value == ''
              ? Preloader.loadingWidget2(size: 16)
              : Obx(() => CustomText(
            maxLines: 2,
                    text: snap.data == null || homeCtrl.currentLocation.value != '' || user.city != '' || user.city != null
                        ? homeCtrl.currentLocation.value == ''
                            ? user.city != '' && user.city != null
                                ? '${user.city}, ${user.country}'
                                : '...'
                            : homeCtrl.currentLocation.value
                        : '${snap.data}',
                    color: color,
                  ));
        });}
    // else {
    //   return  CustomText(
    //     color: color,
    //       text:'...',);
    //   }
  }
//}
