import 'package:brixmarket/view/widgets/save_property_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../config/theme/color.dart';
import '../../controllers/edit_controller.dart';
import '../../controllers/instance.dart';
import '../../core/app.dart';
import '../../models/property_model.dart';
import '../../utils/utils.dart';
import 'custom_text.dart';

class PropertiesGrade extends StatelessWidget {
  const PropertiesGrade({Key? key, required this.properties}) : super(key: key);
  final List<Property> properties;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: properties.length,
        // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //   mainAxisExtent: 465,
        //   maxCrossAxisExtent: 420,
        // ),
        itemBuilder: (_, index) {
          Property property = properties[index];
          String image;
          try {
            image = property.media!.isNotEmpty ? property.media![0].media! : '';
          } catch (e) {
            dnd(e);
            image = '';
          }
          if (EditCtrl.webSearchKeyWord.value.text.trim().isNotEmpty) {
            if (property.title!.trim().toLowerCase().contains(
                EditCtrl.webSearchKeyWord.value.text.trim().toLowerCase())) {
              return Container(
                // margin: const EdgeInsets.all(12),
                margin:
                    EdgeInsets.only(right: !isMobile() ? 12 : 0, bottom: 24),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.01)),
                    borderRadius: BorderRadius.circular(4)),
                child: InkWell(
                  onTap: () => homeCtrl.viewSingleProperty(property),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(4),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          propertyImgPath + image,
                          height: 220,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 24, 12, 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 80,
                                        child: Center(
                                          child: CustomText(
                                              color: const Color(0xFF308b85),
                                              text:
                                                  property.type!.toUpperCase(),
                                              weight: FontWeight.w500,
                                              size: 9),
                                        ),
                                        color: const Color(0xFFebfcfb),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 50,
                                        margin: const EdgeInsets.only(left: 8),
                                        child: Center(
                                          child: CustomText(
                                              color: Colors.white,
                                              text: property.status!
                                                  .toUpperCase(),
                                              weight: FontWeight.w500,
                                              size: 9),
                                        ),
                                        color: Pallet.secondaryColor,
                                      )
                                    ],
                                  ),
                                  true
                                      ? const SizedBox.shrink()
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            RatingBarIndicator(
                                              rating:
                                                  property.averageRating ?? 0,
                                              unratedColor: Colors.black26,
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color: Colors.yellow[900],
                                                size: 12,
                                              ),
                                              itemCount: 5,
                                              itemSize: 12.0,
                                              direction: Axis.horizontal,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            CustomText(
                                                color: Colors.black,
                                                text: (property
                                                            .numberOfRatingUsers ??
                                                        '0')
                                                    .toString(),
                                                weight: FontWeight.w500,
                                                size: 9),
                                          ],
                                        ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              CustomText(
                                  color: Colors.black,
                                  text: property.title,
                                  weight: FontWeight.w700,
                                  size: 16),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Pallet.secondaryColor, size: 12),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                        '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 12,
                              ),
                              const CustomText(
                                  color: Colors.black,
                                  text: 'Price',
                                  weight: FontWeight.w300,
                                  size: 12),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                          color: Pallet.secondaryColor,
                                          text: Utils.amount(property.price!),
                                          weight: FontWeight.w700,
                                          size: 16),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: CustomText(
                                          color: Colors.blueGrey[500],
                                          text: property.priceDuration!
                                                      .substring(0, 3) ==
                                                  'Per'
                                              ? property.priceDuration!
                                                  .toUpperCase()
                                              : '',
                                          weight: FontWeight.w500,
                                          size: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(() => SavePropertyIcon(
                                      property: property,
                                      size: 15,
                                      user: homeCtrl.user.value,
                                      state: homeCtrl.savingProperty.value)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                width: 0,
                height: 0,
              );
            }
          } else {
            return Container(
              // margin: const EdgeInsets.all(12),
              margin: EdgeInsets.only(right: !isMobile() ? 12 : 0, bottom: 24),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.01)),
                  borderRadius: BorderRadius.circular(4)),
              child: InkWell(
                onTap: () => homeCtrl.viewSingleProperty(property),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(4),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        propertyImgPath + image,
                        height: 220,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 24, 12, 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 80,
                                      child: Center(
                                        child: CustomText(
                                            color: const Color(0xFF308b85),
                                            text: property.type!.toUpperCase(),
                                            weight: FontWeight.w500,
                                            size: 9),
                                      ),
                                      color: const Color(0xFFebfcfb),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 50,
                                      margin: const EdgeInsets.only(left: 8),
                                      child: Center(
                                        child: CustomText(
                                            color: Colors.white,
                                            text:
                                                property.status!.toUpperCase(),
                                            weight: FontWeight.w500,
                                            size: 9),
                                      ),
                                      color: Pallet.secondaryColor,
                                    )
                                  ],
                                ),
                                true
                                    ? const SizedBox.shrink()
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          RatingBarIndicator(
                                            rating: property.averageRating ?? 0,
                                            unratedColor: Colors.black26,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.yellow[900],
                                              size: 12,
                                            ),
                                            itemCount: 5,
                                            itemSize: 12.0,
                                            direction: Axis.horizontal,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          CustomText(
                                              color: Colors.black,
                                              text: (property
                                                          .numberOfRatingUsers ??
                                                      '0')
                                                  .toString(),
                                              weight: FontWeight.w500,
                                              size: 9),
                                        ],
                                      ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            CustomText(
                                color: Colors.black,
                                text: property.title,
                                weight: FontWeight.w700,
                                size: 16),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Pallet.secondaryColor, size: 12),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                      '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 12,
                            ),
                            const CustomText(
                                color: Colors.black,
                                text: 'Price',
                                weight: FontWeight.w300,
                                size: 12),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                        color: Pallet.secondaryColor,
                                        text: Utils.amount(property.price!),
                                        weight: FontWeight.w700,
                                        size: 16),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: CustomText(
                                        color: Colors.blueGrey[500],
                                        text: property.priceDuration!
                                                    .substring(0, 3) ==
                                                'Per'
                                            ? property.priceDuration!
                                                .toUpperCase()
                                            : '',
                                        weight: FontWeight.w500,
                                        size: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(() => SavePropertyIcon(
                                    property: property,
                                    size: 15,
                                    user: homeCtrl.user.value,
                                    state: homeCtrl.savingProperty.value)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}


class PropertyShortStayGrid extends StatelessWidget {
  const PropertyShortStayGrid({Key? key,required this.properties}) : super(key: key);
  final List<Property> properties;

  @override
  Widget build(BuildContext context) {

    return  ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: properties.length,
        // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //   mainAxisExtent: 465,
        //   maxCrossAxisExtent: 420,
        // ),
        itemBuilder: (_, index) {
          Property property = properties[index];
          String image;
          try {
            image = property.media!.isNotEmpty ? property.media![0].media! : '';
          } catch (e) {
            dnd(e);
            image = '';
          }
            if (property.type=='Short stay') {
              return Container(
                // margin: const EdgeInsets.all(12),
                margin:
                EdgeInsets.only(right: !isMobile() ? 12 : 0, bottom: 24),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.01)),
                    borderRadius: BorderRadius.circular(4)),
                child: InkWell(
                  onTap: () => homeCtrl.viewSingleProperty(property),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(4),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          propertyImgPath + image,
                          height: 220,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 24, 12, 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 80,
                                        child: Center(
                                          child: CustomText(
                                              color: const Color(0xFF308b85),
                                              text:
                                              property.type!.toUpperCase(),
                                              weight: FontWeight.w500,
                                              size: 9),
                                        ),
                                        color: const Color(0xFFebfcfb),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 50,
                                        margin: const EdgeInsets.only(left: 8),
                                        child: Center(
                                          child: CustomText(
                                              color: Colors.white,
                                              text: property.status!
                                                  .toUpperCase(),
                                              weight: FontWeight.w500,
                                              size: 9),
                                        ),
                                        color: Pallet.secondaryColor,
                                      )
                                    ],
                                  ),
                                  true
                                      ? const SizedBox.shrink()
                                      : Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      RatingBarIndicator(
                                        rating:
                                        property.averageRating ?? 0,
                                        unratedColor: Colors.black26,
                                        itemBuilder: (context, index) =>
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[900],
                                              size: 12,
                                            ),
                                        itemCount: 5,
                                        itemSize: 12.0,
                                        direction: Axis.horizontal,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      CustomText(
                                          color: Colors.black,
                                          text: (property
                                              .numberOfRatingUsers ??
                                              '0')
                                              .toString(),
                                          weight: FontWeight.w500,
                                          size: 9),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              CustomText(
                                  color: Colors.black,
                                  text: property.title,
                                  weight: FontWeight.w700,
                                  size: 16),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Pallet.secondaryColor, size: 12),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                        '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Divider(),
                              const SizedBox(
                                height: 12,
                              ),
                              const CustomText(
                                  color: Colors.black,
                                  text: 'Price',
                                  weight: FontWeight.w300,
                                  size: 12),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                          color: Pallet.secondaryColor,
                                          text: Utils.amount(property.price!),
                                          weight: FontWeight.w700,
                                          size: 16),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 8.0),
                                        child: CustomText(
                                          color: Colors.blueGrey[500],
                                          text: property.priceDuration!
                                              .substring(0, 3) ==
                                              'Per'
                                              ? property.priceDuration!
                                              .toUpperCase()
                                              : '',
                                          weight: FontWeight.w500,
                                          size: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(() => SavePropertyIcon(
                                      property: property,
                                      size: 15,
                                      user: homeCtrl.user.value,
                                      state: homeCtrl.savingProperty.value)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                width: 0,
                height: 0,
              );
            }
        });

  }
}
