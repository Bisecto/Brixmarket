import 'dart:math';

import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/models/property_model.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../controllers/instance.dart';
import '../../core/app.dart';
import '../../models/media_model.dart';
import '../../utils/utils.dart';
import '../widgets/footer_page.dart';
import '../widgets/main_drawer.dart';
import '../widgets/material_search_bar/src/floating_search_bar.dart';
import '../widgets/material_search_bar/src/floating_search_bar_transition.dart';
import '../widgets/mobile_appbar.dart';
import '../widgets/navbar.dart';
import '../widgets/save_property_icon.dart';
import 'mobile/explore_filter_page.dart';

class PropertyListsPage extends StatelessWidget {
  PropertyListsPage({Key? key}) : super(key: key);

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  double mainPad = 0;
  @override
  Widget build(BuildContext context) {
    homeCtrl.getProperties();
    var vw = MediaQuery.of(context).size.width;
    mainPad = (pow(vw, 5) / 40000000000000.1);
    mainPad = isTabletDown() ? 24 : mainPad;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        key: homeScaffoldKey,
        backgroundColor: Pallet.homeBackground,
        drawer: buildDrawer(context),
        appBar: !isDesktop() ? mobileAppBar(homeScaffoldKey) : AppBar(toolbarHeight: 0),
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: Pallet.homeBackground,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isDesktop() ? navBar() : const SizedBox.shrink(),
                    topMessage(homeCtrl: homeCtrl),
                    // const SizedBox(height: 10),
                    Container(
                      height: 42,
                      color: Pallet.secondaryColor,
                      padding: EdgeInsets.only(left: mainPad),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CustomText(text: 'Home', size: 14, color: Pallet.whiteColor),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios, size: 14, color: Pallet.whiteColor),
                          SizedBox(width: 10),
                          CustomText(text: 'Rent', size: 14, color: Pallet.whiteColor),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios, size: 14, color: Pallet.whiteColor),
                          SizedBox(width: 10),
                          CustomText(text: 'Apartment', size: 14, color: Pallet.whiteColor)
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: mainPad - 8, right: mainPad, top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Obx(() {
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          homeCtrl.toggleList();
                                        },
                                        child: Icon(
                                          Icons.list_alt,
                                          size: 36,
                                          color: homeCtrl.isList.value ? Pallet.secondaryColor : Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          homeCtrl.toggleList();
                                        },
                                        child: Icon(
                                          Icons.grid_view_outlined,
                                          size: 32,
                                          color: homeCtrl.isList.value ? Colors.grey : Pallet.secondaryColor,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                                const SizedBox(width: 12),
                                Container(
                                  height: 48,
                                  width: 108,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.black26)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(width: 8),
                                      CustomText(
                                        size: 14,
                                        text: 'Sorted by',
                                        color: Colors.black54,
                                      ),
                                      SizedBox(
                                          // width: 8,
                                          ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 32,
                                        color: Colors.black54,
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                              Row(children: [
                                InkWell(
                                  onTap: () {
                                    propCtrl.showWebFilter.value = true;
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 120,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.black26)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        CustomText(
                                          size: 16,
                                          text: 'Price',
                                          color: Colors.black54,
                                        ),
                                        SizedBox(width: 15),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          size: 24,
                                          color: Colors.black54,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    propCtrl.showMoreFilter.value == true;
                                    propCtrl.showWebFilter.value = true;
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 120,
                                    margin: const EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.black26)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        CustomText(
                                          size: 16,
                                          text: 'Rooms',
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          size: 24,
                                          color: Colors.black54,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                InkWell(
                                  onTap: () => propCtrl.showWebFilter.value = true,
                                  child: Container(
                                    height: 48,
                                    width: 148,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.black26)),
                                    child: const Center(
                                      child: CustomText(
                                        size: 16,
                                        text: 'All Filters',
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(
                        //     left: mainPad,
                        //     right: mainPad,
                        //     top: 64,
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //         height: 36,
                        //         width: 120,
                        //         decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: const [
                        //             Icon(
                        //               Icons.location_on,
                        //               size: 16,
                        //               color: Colors.black54,
                        //             ),
                        //             SizedBox(
                        //               width: 15,
                        //             ),
                        //             CustomText(
                        //               size: 16,
                        //               text: 'Maps',
                        //               color: Colors.black54,
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 92.0,
                            left: mainPad - 12,
                            right: mainPad - 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
                                child: Text('23,9938 Properties just around your location', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                              ),
                              Obx(() => propCtrl.loadingAllProperties.value
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(vertical: 120),
                                      child: const Center(child: CircularProgressIndicator()),
                                    )
                                  : Obx(() => Column(children: [
                                        Visibility(
                                          visible: homeCtrl.isList.value && !isTabletDown(),
                                          child: buildListContainer(),
                                        ),
                                        Visibility(
                                          visible: !homeCtrl.isList.value || isTabletDown(),
                                          child: buildGridViewContainer(constraints: constraints.maxWidth),
                                        ),
                                      ]))),
                            ],
                          ),
                        ),
                        // Positioned(
                        //     top: 10,
                        //     left: mainPad + 192,
                        //     child: SizedBox(
                        //       width: 360,
                        //       height: 300,
                        //       child: buildFloatingSearchBar(),
                        //     )),
                      ],
                    ),
                    pageFooter(),
                  ],
                ),
              ),
            ),
            Obx(() => propCtrl.showWebFilter.value
                ? GestureDetector(
                    onTap: () => propCtrl.showWebFilter.value = false,
                    child: Container(
                      width: Get.width,
                      height: Get.height,
                      color: Colors.black38,
                    ),
                  )
                : const SizedBox.shrink()),
            Obx(
              () => propCtrl.showWebFilter.value
                  ? Container(
                      width: isMobile() ? Get.width : 360,
                      margin: EdgeInsets.only(left: isMobile() ? 0 : Get.width - 360),
                      child: const FilterExplorePage(isWeb: true),
                    )
                  : const SizedBox.shrink(),
            )
          ],
        ),
      );
    });
  }

  Widget buildListContainer() {
    return Obx(() {
      List<Property> properties = propCtrl.allProperties.value;
      return ListView.builder(
          shrinkWrap: true,
          itemCount: propCtrl.allProperties.value.length,
          itemBuilder: (_, i) {
            int iFeature = 0;
            Property property = properties[i];
            String image = property.media!.isNotEmpty ? property.media![0].media! : '';
            List<Media> images = property.media ?? [];
            return Material(
              color: Colors.white,
              elevation: 2,
              type: MaterialType.card,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 3),
                          height: 268,
                          width: Get.width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(propertyImgPath + image),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 0, left: 10, bottom: 10),
                          height: 68,
                          child: ListView.builder(
                            itemCount: images.length > 5 ? 5 : images.length,
                            reverse: false,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: (index == 4)
                                    ? Stack(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(top: 5),
                                            color: Colors.white,
                                            height: 80,
                                            // width: 69,
                                            child: Image.network(
                                              propertyImgPath + images[index].media!,
                                              height: 80,
                                              width: Get.width * 0.4 * 0.15,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          images.length > 5
                                              ? Container(
                                                  margin: const EdgeInsets.only(right: 5, top: 5),
                                                  color: Colors.black.withOpacity(0.6),
                                                  height: 80,
                                                  width: 72,
                                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                    CustomText(
                                                        text: (images.length > 5 ? (images.length - 5).toString() + ' images' : '').toString(),
                                                        color: Colors.white,
                                                        size: 10),
                                                    const SizedBox(width: 5),
                                                    const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12),
                                                  ]),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(right: Get.width * 0.4 * 0.01, top: 5),
                                        color: Colors.white,
                                        height: 80,
                                        width: Get.width * 0.4 * 0.16,
                                        child: Image.network(
                                          propertyImgPath + images[index].media!,
                                          height: 80,
                                          width: 72,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 32,
                                    width: 120,
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Center(
                                      child: CustomText(color: const Color(0xFF308b85), text: property.type!.toUpperCase(), weight: FontWeight.w500, size: 14),
                                    ),
                                    color: const Color(0xFFebfcfb),
                                  ),
                                  Container(
                                    height: 32,
                                    width: 84,
                                    padding: const EdgeInsets.only(top: 3),
                                    margin: const EdgeInsets.only(left: 8),
                                    child: Center(
                                      child: CustomText(color: Colors.white, text: property.status!.toUpperCase(), weight: FontWeight.w500, size: 14),
                                    ),
                                    color: Pallet.secondaryColor,
                                  )
                                ],
                              ),
                              property.user!.agency!.isVerified == null
                                  ? const SizedBox.shrink()
                                  : property.user!.agency!.isVerified!
                                      ? Container(
                                          height: 32,
                                          width: 112,
                                          decoration: const BoxDecoration(
                                              color: Color.fromARGB(255, 247, 241, 241),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 13.0),
                                                child: Icon(
                                                  Icons.verified,
                                                  size: 18,
                                                  color: Colors.green[700],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              const CustomText(color: Colors.black54, text: 'verified', weight: FontWeight.w500, size: 16),
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomText(color: Colors.black, text: property.title, weight: FontWeight.w800, size: 18),
                          const SizedBox(
                            height: 12,
                          ),
                          ReadMoreText(
                            '${property.description}',
                            trimLines: 1,
                            colorClickableText: Colors.pink,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200, color: Colors.grey[600]),
                            trimMode: TrimMode.Line,
                            lessStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w200, color: Pallet.secondaryColor),
                            trimCollapsedText: '  Read more',
                            trimExpandedText: '  Read less',
                            moreStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Pallet.secondaryColor),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Pallet.secondaryColor, size: 18),
                              const SizedBox(
                                width: 12,
                              ),
                              CustomText(
                                  color: Colors.black,
                                  text: '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                  weight: FontWeight.w200,
                                  size: 16),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              ...property.features!.map((feature) {
                                iFeature++;
                                return iFeature >= 4
                                    ? const SizedBox.shrink()
                                    : Row(
                                        children: [
                                          const Icon(Icons.bed, color: Colors.black54, size: 18),
                                          const SizedBox(width: 5),
                                          CustomText(color: Colors.black54, text: feature.featureValue, weight: FontWeight.w200, size: 16),
                                          const SizedBox(width: 12),
                                        ],
                                      );
                              }).toList(),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RatingBarIndicator(
                                    rating: property.averageRating ?? 5,
                                    unratedColor: Pallet.whiteColor,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: property.averageRating == null ? Colors.black26 : Colors.yellow[900],
                                      size: 18,
                                    ),
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    direction: Axis.horizontal,
                                  ),
                                  const SizedBox(width: 4),
                                  CustomText(
                                    color: Colors.black,
                                    text: (property.numberOfRatingUsers ?? 'No Review').toString(),
                                    weight: FontWeight.w200,
                                    size: 16,
                                  ),
                                ],
                              ),
                              Obx(() => SavePropertyIconText(property: property, user: homeCtrl.user.value, state: homeCtrl.savingProperty.value)),
                            ],
                          ),
                          Container(margin: const EdgeInsets.only(right: 30), child: const Divider()),
                          const SizedBox(height: 5),
                          const CustomText(color: Colors.black, text: 'Price', weight: FontWeight.w100, size: 14),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomText(color: Pallet.secondaryColor, text: Utils.amount(property.price!), weight: FontWeight.w700, size: 20),
                                  const SizedBox(width: 3),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: CustomText(
                                      color: Colors.black.withOpacity(0.4),
                                      text: property.priceDuration!.substring(0, 3) == 'Per' ? property.priceDuration!.toUpperCase() : '',
                                      weight: FontWeight.w500,
                                      size: 14,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () => homeCtrl.viewSingleProperty(property),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 30),
                                  height: 40,
                                  width: 120,
                                  color: Colors.grey[900],
                                  child: const Center(
                                    child: CustomText(
                                      text: 'Take a tour',
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }

  Widget buildGridViewContainer({double? constraints}) {
    List<Property> properties = propCtrl.allProperties.value;
    return Obx(() {
      return Container(
        // padding: EdgeInsets.symmetric(horizontal: mainPad - 12),
        // constraints: BoxConstraints(minWidth: isMobile() ? Get.width * 0.9 : 300),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: propCtrl.allProperties.value.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile()
                  ? 1
                  : isTablet()
                      ? 2
                      : 3,
              mainAxisExtent: 572,
            ),
            itemBuilder: (_, i) {
              int iFeature = 0;
              Property property = properties[i];
              String image = property.media!.isNotEmpty ? property.media![0].media! : '';
              List<Media> images = property.media ?? [];
              return Container(
                margin: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Pallet.homeBackground,
                ),
                child: InkWell(
                  onTap: () => homeCtrl.viewSingleProperty(property),
                  child: Material(
                    elevation: 2,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          propertyImgPath + image,
                          height: 240,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 16, 12, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 28,
                                          width: 96,
                                          child: Center(
                                            child: CustomText(color: const Color(0xFF308b85), text: property.type!.toUpperCase(), weight: FontWeight.w500, size: 14),
                                          ),
                                          color: const Color(0xFFebfcfb),
                                        ),
                                        Container(
                                          height: 28,
                                          width: 68,
                                          margin: const EdgeInsets.only(left: 8),
                                          child: Center(
                                            child: CustomText(color: Colors.white, text: property.status!.toUpperCase(), weight: FontWeight.w500, size: 12),
                                          ),
                                          color: Pallet.secondaryColor,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        RatingBarIndicator(
                                          rating: property.averageRating ?? 5,
                                          unratedColor: Pallet.whiteColor,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: property.averageRating == null ? Colors.black26 : Colors.yellow[900],
                                            size: 16,
                                          ),
                                          itemCount: 5,
                                          itemSize: 16.0,
                                          direction: Axis.horizontal,
                                        ),
                                        const SizedBox(width: 4),
                                        CustomText(
                                            color: Colors.black, text: (property.numberOfRatingUsers ?? 'No Review').toString(), weight: FontWeight.w200, size: 12),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                CustomText(color: Colors.black, text: property.title, weight: FontWeight.w800, size: 16),
                                const SizedBox(
                                  height: 12,
                                ),
                                ReadMoreText(
                                  '${property.description}',
                                  trimLines: 1,
                                  colorClickableText: Colors.pink,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200, color: Colors.grey[600]),
                                  trimMode: TrimMode.Line,
                                  lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200, color: Pallet.secondaryColor),
                                  trimCollapsedText: '  Read more',
                                  trimExpandedText: '  Read less',
                                  moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Pallet.secondaryColor),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Pallet.secondaryColor, size: 18),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: CustomText(
                                          color: Colors.black,
                                          text: '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                          weight: FontWeight.w200,
                                          maxLines: 1,
                                          size: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                FittedBox(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ...property.features!.map((feature) {
                                        iFeature++;
                                        return iFeature >= 4
                                            ? const SizedBox.shrink()
                                            : Row(
                                                children: [
                                                  const Icon(
                                                    Icons.bed,
                                                    color: Colors.black54,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  CustomText(color: Colors.black54, text: feature.featureValue, weight: FontWeight.w200, size: 13),
                                                  const SizedBox(width: 8),
                                                ],
                                              );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 12,
                                ),
                                const CustomText(color: Colors.black, text: 'Price', weight: FontWeight.w100, size: 12),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(color: Pallet.secondaryColor, text: Utils.amount(property.price!), weight: FontWeight.w700, size: 20),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: CustomText(
                                            color: Colors.black.withOpacity(0.4),
                                            text: property.priceDuration!.substring(0, 3) == 'Per' ? property.priceDuration!.toUpperCase() : '',
                                            weight: FontWeight.w500,
                                            size: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Obx(() => SavePropertyIcon(property: property, user: homeCtrl.user.value, state: homeCtrl.savingProperty.value)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }

  // Widget buildFloatingSearchBar() {
  //   return FloatingSearchBar(
  //     hint: 'Country, City, Town or Area',
  //     scrollPadding: const EdgeInsets.only(top: 0),
  //     transitionDuration: const Duration(milliseconds: 0),
  //     transitionCurve: Curves.slowMiddle,
  //     borderRadius: BorderRadius.circular(4),
  //     border: const BorderSide(color: Colors.black26),
  //     automaticallyImplyBackButton: false,
  //     automaticallyImplyDrawerHamburger: false,
  //     physics: const BouncingScrollPhysics(),
  //     axisAlignment: 0.0,
  //     openAxisAlignment: 0.0,
  //     width: Get.width * 0.55,
  //     height: 48,
  //     backdropColor: Colors.transparent,
  //     debounceDelay: const Duration(milliseconds: 500),
  //     onQueryChanged: (query) => homeCtrl.filterProduct(query),
  //     transition: CircularFloatingSearchBarTransition(),
  //     builder: (context, transition) {
  //       return ClipRRect(
  //         borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
  //         child: Material(
  //           child: Obx(() => ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: homeCtrl.mainData.length,
  //               itemBuilder: (_, int i) => Container(
  //                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  //                   decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 0.2))),
  //                   child: Text(homeCtrl.mainData[i], style: const TextStyle(fontSize: 16))))),
  //         ),
  //       );
  //     },
  //   );
  // }
}
