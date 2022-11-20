import 'package:brixmarket/models/property_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../config/theme/color.dart';
import '../../../../../../controllers/instance.dart';
import '../../../../../../core/app.dart';
import '../../../../../../models/home_property_model.dart'as latest;
import '../../../../../../models/media_model.dart';
import '../../../../../../res/strings.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../screens/mobile/single_property_page.dart';
import '../../../../custom_text.dart';
import '../../../../save_property_icon.dart';

buildPremiumList({required bool showMore, borderColor, Property? property, bool home = false, home2 = false}) {
  if (property == null) return Container();
  int iFeature = 0;
  print('Precious12345');
  print(property.media);
  String image = (property.media ?? []).isNotEmpty ? property.media![0].media! : '';
  List<Media> images = property.media ?? [];
  return Container(
    width: 240,
    height: (showMore)
        ? 420
        : home || home2
            ? 377
            : 377,
    margin: EdgeInsets.only(right: (showMore || home || home2) ? 0 : 16, top: (showMore || home2 || home) ? 30 : 12),
    padding: EdgeInsets.all((showMore || home || home2) ? 12 : 0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: home ? Colors.black26 : Pallet.secondaryColor, width: 1.2)),
    child: InkWell(
      onTap: () {
        homeCtrl.property = property;
        //Get.toNamed(RouteStr.mobileProperty);
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (context) =>
                Single_Property(property_id: property.id!,)));
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 0),
                height: (showMore || home || home2) ? 190 : 154,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        propertyImgPath + image,
                      )),
                  borderRadius:
                      (showMore || home || home2) ? BorderRadius.circular(6) : const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Material(
                  type: MaterialType.card,
                  color: Colors.black38,
                  elevation: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    child: Row(children: [
                      const Icon(
                        Icons.camera_enhance,
                        color: Colors.orangeAccent,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      CustomText(
                        maxLines: 1,
                        text: images.length.toString(),
                        color: Colors.amber,
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ]),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Center(
                            child: CustomText(color: const Color(0xFF308b85), text: property.type ?? '', weight: FontWeight.w400, size: 13),
                          ),
                          color: Colors.black12,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          child: Center(
                            child: CustomText(color: Colors.white, text: property.status ?? '', weight: FontWeight.w400, size: 13),
                          ),
                          color: Pallet.secondaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                (showMore)
                    ? Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            CustomText(color: Pallet.secondaryColor, text: Utils.amount(property.price ?? 0), weight: FontWeight.bold, size: 18),
                            const SizedBox(height: 2),
                            property.priceDuration!.substring(0, 3) == 'Per'
                                ? CustomText(
                                    color: Colors.blueGrey,
                                    text: property.priceDuration!.substring(0, 3) == 'Per' ? property.priceDuration!.toUpperCase() : '',
                                    weight: FontWeight.bold,
                                    size: 12)
                                : const SizedBox.shrink(),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: showMore || home || home2
                    ? Get.width < 300
                        ? Get.width * 0.6
                        : Get.width * 0.7
                    : 190,
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CustomText(color: Colors.black, text: property.title ?? '', weight: FontWeight.w500, size: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Pallet.secondaryColor,
                      ),
                      SizedBox(
                        width: showMore || home || home2
                            ? Get.width < 300
                                ? Get.width * 0.5
                                : Get.width * 0.6
                            : 164,
                        child: Text('${property.location?.address}, ${property.location?.city}, ${property.location?.state}',
                            overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14)),
                      ),
                    ],
                  ),
                ]),
              ),
              Obx(() => SavePropertyIcon(
                    property: property,
                    user: homeCtrl.user.value,
                    state: homeCtrl.savingProperty.value,
                    size: 22,
                    color: Colors.red,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          (showMore)
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      CustomText(color: Pallet.secondaryColor, text: Utils.amount(property.price ?? 0), weight: FontWeight.bold, size: 18),
                      const SizedBox(width: 5),
                      CustomText(
                          color: Colors.blueGrey,
                          text: property.priceDuration!.substring(0, 3) == 'Per' ? property.priceDuration!.toUpperCase() : '',
                          weight: FontWeight.bold,
                          size: 12),
                    ],
                  ),
                ),
          const SizedBox(height: 8),
          (showMore)
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.black12),
                  child: Column(
                    children: [

                      CustomText(
                        text: 'Institutions near this property',
                        color: Colors.red,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ...property.features!.map((feature) {
                            iFeature++;
                            return iFeature >= 4
                                ? const SizedBox.shrink()
                                : Expanded(
                                    child: Column(
                                      children: [
                                        const SizedBox(width: 3),
                                        CustomText(color: Colors.black, text: feature.featureValue, weight: FontWeight.w500, size: 13),
                                      ],
                                    ),
                                  );
                          }).toList(),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    ),
  );
}
buildHomeList({required bool showMore, borderColor, latest.Latest? property, bool home = false, home2 = false}) {
  if (property == null) return Container();
  int iFeature = 0;
  String image = property.media!.isNotEmpty ? property.media![0].media! : '';
  List images = property.media ?? [];
  return Container(
    width: 240,
    height: (showMore)
        ? 420
        : home || home2
        ? 377
        : 377,
    margin: EdgeInsets.only(right: (showMore || home || home2) ? 0 : 16, top: (showMore || home2 || home) ? 30 : 12),
    padding: EdgeInsets.all((showMore || home || home2) ? 12 : 0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: home ? Colors.black26 : Pallet.secondaryColor, width: 1.2)),
    child: InkWell(
      onTap: () {
        //homeCtrl.property = property;
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (context) =>
                Single_Property(property_id: property.id,)));
        //Get.toNamed(RouteStr.mobileProperty);
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 0),
                height: (showMore || home || home2) ? 190 : 154,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        propertyImgPath + image,
                      )),
                  borderRadius:
                  (showMore || home || home2) ? BorderRadius.circular(6) : const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Material(
                  type: MaterialType.card,
                  color: Colors.black38,
                  elevation: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    child: Row(children: [
                      const Icon(
                        Icons.camera_enhance,
                        color: Colors.orangeAccent,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      CustomText(
                        maxLines: 1,
                        text: images.length.toString(),
                        color: Colors.amber,
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ]),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Center(
                            child: CustomText(color: const Color(0xFF308b85), text: property.type ?? '', weight: FontWeight.w400, size: 13),
                          ),
                          color: Colors.black12,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          child: Center(
                            child: CustomText(color: Colors.white, text: property.status ?? '', weight: FontWeight.w400, size: 13),
                          ),
                          color: Pallet.secondaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                (showMore)
                    ? Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      CustomText(color: Pallet.secondaryColor, text: Utils.amount(property.price ?? 0), weight: FontWeight.bold, size: 18),
                      const SizedBox(height: 2),
                      property.priceDuration!.substring(0, 3) == 'Per'
                          ? CustomText(
                          color: Colors.blueGrey,
                          text: property.priceDuration!.substring(0, 3) == 'Per' ? property.priceDuration!.toUpperCase() : '',
                          weight: FontWeight.bold,
                          size: 12)
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
                    : Container(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: showMore || home || home2
                    ? Get.width < 300
                    ? Get.width * 0.6
                    : Get.width * 0.7
                    : 190,
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CustomText(color: Colors.black, text: property.title ?? '', weight: FontWeight.w500, size: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Pallet.secondaryColor,
                      ),
                      SizedBox(
                        width: showMore || home || home2
                            ? Get.width < 300
                            ? Get.width * 0.5
                            : Get.width * 0.6
                            : 164,
                        child: Text('${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                            overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14)),
                      ),
                    ],
                  ),
                ]),
              ),
              // Obx(() => SavePropertyIcon(
              //   property: property,
              //   user: homeCtrl.user.value,
              //   state: homeCtrl.savingProperty.value,
              //   size: 22,
              //   color: Colors.red,
              // )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          (showMore)
              ? Container()
              : Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                CustomText(color: Pallet.secondaryColor, text: Utils.amount(property.price ?? 0), weight: FontWeight.bold, size: 18),
                const SizedBox(width: 5),
                CustomText(
                    color: Colors.blueGrey,
                    text: property.priceDuration!.substring(0, 3) == 'Per' ? property.priceDuration!.toUpperCase() : '',
                    weight: FontWeight.bold,
                    size: 12),
              ],
            ),
          ),
          const SizedBox(height: 8),
          (showMore)
              ? Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.black12),
            child: Column(
              children: [

                CustomText(
                  text: 'Institutions near this property',
                  color: Colors.red,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 8),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   mainAxisSize: MainAxisSize.max,
                //   children: [
                //     ...property.features!.map((feature) {
                //       iFeature++;
                //       return iFeature >= 4
                //           ? const SizedBox.shrink()
                //           : Expanded(
                //         child: Column(
                //           children: [
                //             const SizedBox(width: 3),
                //             CustomText(color: Colors.black, text: feature.featureValue, weight: FontWeight.w500, size: 13),
                //           ],
                //         ),
                //       );
                //     }).toList(),
                //   ],
                // ),
              ],
            ),
          )
              : Container(),
        ],
      ),
    ),
  );
}
