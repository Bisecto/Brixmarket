
import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/libs/launch_urls.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../controllers/edit_controller.dart';
import '../../controllers/instance.dart';
import '../../core/app.dart';
import '../../core/preloader.dart';
import '../../models/media_model.dart';
import '../../models/property_model.dart';
import '../../res/strings.dart';
import '../../utils/utils.dart';
import '../widgets/custom_button.dart';
import '../widgets/footer_page.dart';
import '../widgets/form_inputs.dart';
import '../widgets/main_drawer.dart';
import '../widgets/mobile_appbar.dart';
import '../widgets/save_property_icon.dart';
import '../widgets/web_hero_seach.dart';
import 'mobile/property_details_page.dart';

class PropertyPageWeb extends StatefulWidget {
  const PropertyPageWeb({Key? key}) : super(key: key);

  @override
  State<PropertyPageWeb> createState() => _PropertyDetailsListsPageState();
}

class _PropertyDetailsListsPageState extends State<PropertyPageWeb> {
  late PageController _controller;
  bool checkState = true;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  Property property = Property();

  @override
  void initState() {
    _controller = PageController(
      initialPage: 0,
    );
    //Timer.periodic(const Duration(seconds: 1), (timer) {
    property = homeCtrl.property;
    print(property.id);

    // });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mainPadding = Get.width < 480
        ? Get.width * 0.05
        : Get.width * 0.06 + Get.width * 0.009;
    List<Media> images = property.media ?? [];

    var details = property.features == null || property.features == []
        ? [Container()]
        : property.features?.map((feature) {
            return Container(
              width: Get.width * 0.9,
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Colors.black54, size: 18),
                  const SizedBox(width: 16),
                  Expanded(
                      child: CustomText(
                          color: Colors.black54,
                          text: feature.featureValue,
                          weight: FontWeight.w500,
                          size: 16,
                          maxLines: 3)),
                ],
              ),
            );
          }).toList();
    var amenities = property.amenities == null || property.amenities == []
        ? [Container()]
        : property.amenities?.map((value) {
            return Container(
              width: Get.width * 0.9,
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(Icons.check, color: Colors.black54, size: 18),
                  const SizedBox(width: 16),
                  Expanded(
                      child: CustomText(
                          color: Colors.black54,
                          text: value.amenity,
                          weight: FontWeight.w500,
                          size: 16,
                          maxLines: 3)),
                ],
              ),
            );
          }).toList();
    var reviews = productReviews(homeCtrl.property);

    return FutureBuilder(
        future: propCtrl.fetchSingleProperty('MDM1MTIwODgzMzg3MTQ1'),
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Preloader.loadingWidget();
          } else {
            homeCtrl.property = snap.data;

            return LayoutBuilder(builder: (context, constraints) {
              return Scaffold(
                backgroundColor: Pallet.primaryBackgroundLight,
                drawer: buildDrawer(context),
                appBar: appBarWeb(homeScaffoldKey),
                body: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Pallet.primaryBackgroundDark,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // topMessage(homeCtrl: homeCtrl),
                        Container(
                          width: Get.width,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/images/hero1.jpg'))),
                          child: Container(
                            width: Get.width,
                            height: isMobile() ? 200 : 300,
                            color: Colors.black.withOpacity(0.7),
                            padding: const EdgeInsets.only(top: 32),
                            child: Column(
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    CustomText(
                                      text: 'Search for your property here',
                                      size: isMobile()
                                          ? 20
                                          : isTablet()
                                              ? 28
                                              : 48,
                                      color: Colors.white,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                SizedBox(height: isMobile() ? 0 : 20),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: isMobile()
                                            ? 16
                                            : (isTablet() ? 48 : 84)),
                                    width: 840,
                                    color: Colors.transparent,
                                    child: WebHeroSearch()),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 42,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: isMobile() ? 0 : mainPadding),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 8,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: Get.width * 0.4,
                                      child: PageView(
                                        controller: _controller,
                                        children: [
                                          ...images.map((media) {
                                            return Stack(
                                              children: [
                                                Container(
                                                  width: Get.width,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              propertyImgPath +
                                                                  media
                                                                      .media!))),
                                                ),
                                                Container(
                                                  width: Get.width,
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 275,
                                      left: 40,
                                      child: GestureDetector(
                                        onTap: () => previousPage(),
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: const Icon(
                                              Icons.arrow_back_ios_new,
                                              size: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              color: Colors.white
                                                  .withOpacity(0.6)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 275,
                                      right: 40,
                                      child: GestureDetector(
                                        onTap: () => nextPage(),
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 10,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              color: Colors.white
                                                  .withOpacity(0.4)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.4 * 0.02,
                              ),
                              Expanded(
                                flex: 2,
                                child: ListView.builder(
                                    itemCount: images.length,
                                    shrinkWrap: true,
                                    itemBuilder: ((context, index) {
                                      return (index == 2)
                                          ? Stack(
                                              children: [
                                                Container(
                                                  height:
                                                      Get.width * 0.4 * 0.32,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              propertyImgPath +
                                                                  images[index]
                                                                      .media!))),
                                                ),
                                                Container(
                                                  height:
                                                      Get.width * 0.4 * 0.32,
                                                  color: Colors.black
                                                      .withOpacity(0.4),
                                                ),
                                                images.length > 3
                                                    ? SizedBox(
                                                        height: Get.width *
                                                            0.4 *
                                                            0.32,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CustomText(
                                                                  text: (images.length >
                                                                              3
                                                                          ? (images.length - 3).toString() +
                                                                              ' images'
                                                                          : '')
                                                                      .toString(),
                                                                  color: Colors
                                                                      .white70,
                                                                  size:
                                                                      isMobile()
                                                                          ? 11
                                                                          : 14),
                                                              const SizedBox(
                                                                  width: 5),
                                                              const Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 12)
                                                            ]),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            )
                                          : Stack(
                                              children: [
                                                Container(
                                                  height:
                                                      Get.width * 0.4 * 0.32,
                                                  margin: EdgeInsets.only(
                                                    bottom:
                                                        Get.width * 0.4 * 0.02,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              propertyImgPath +
                                                                  images[index]
                                                                      .media!))),
                                                ),
                                              ],
                                            );
                                    })),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: mainPadding, vertical: 8),
                          width: Get.width,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 8,
                            children: [
                              Wrap(
                                runSpacing: 12,
                                spacing: isTabletDown() ? 16 : 48,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 32,
                                        width: isTabletDown() ? 80 : 120,
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Center(
                                          child: CustomText(
                                              color: const Color(0xFF308b85),
                                              text:
                                                  property.type!.toUpperCase(),
                                              weight: FontWeight.w500,
                                              size: isTabletDown() ? 12 : 14),
                                        ),
                                        color: const Color(0xFFebfcfb),
                                      ),
                                      Container(
                                        height: 32,
                                        width: 84,
                                        padding: const EdgeInsets.only(top: 3),
                                        margin: const EdgeInsets.only(left: 8),
                                        child: Center(
                                          child: CustomText(
                                              color: Colors.white,
                                              text: property.status!
                                                  .toUpperCase(),
                                              weight: FontWeight.w500,
                                              size: isTabletDown() ? 12 : 14),
                                        ),
                                        color: Pallet.secondaryColor,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.calendar_month,
                                          color: Pallet.secondaryColor,
                                          size: 18),
                                      const SizedBox(width: 5),
                                      CustomText(
                                        text: property.createdAt,
                                        size: isTabletDown() ? 12 : 14,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.visibility,
                                          color: Pallet.secondaryColor,
                                          size: 14),
                                      const SizedBox(width: 5),
                                      CustomText(
                                        text: '${property.views ?? 0} views',
                                        size: isTabletDown() ? 12 : 16,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      RatingBarIndicator(
                                        rating: property.averageRating ?? 5,
                                        unratedColor: Colors.black12,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: property.averageRating == null
                                              ? Colors.black26
                                              : Colors.yellow[900],
                                          size: 18,
                                        ),
                                        itemCount: 5,
                                        itemSize: 18.0,
                                        direction: Axis.horizontal,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      CustomText(
                                          text: (property.numberOfRatingUsers ??
                                                  'No Review')
                                              .toString(),
                                          weight: FontWeight.w200,
                                          size: 16),
                                    ],
                                  ),
                                  Utils.isMobileApp
                                      ? Obx(() => SavePropertyIcon(
                                          property: property,
                                          user: homeCtrl.user.value,
                                          state: homeCtrl.savingProperty.value))
                                      : Obx(() => SavePropertyIconText(
                                          property: property,
                                          user: homeCtrl.user.value,
                                          state:
                                              homeCtrl.savingProperty.value)),
                                ],
                              ),
                              InkWell(
                                onTap: () => flagInappropriate(property.id),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset('assets/images/megap.png',
                                        height: 22),
                                    const SizedBox(width: 8),
                                    const CustomText(
                                        color: Colors.black,
                                        text: 'Flag as inappropriate',
                                        weight: FontWeight.w500,
                                        size: 16),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: mainPadding, vertical: 24),
                            child: Wrap(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: isTabletDown()
                                        ? Get.width
                                        : Get.width * 0.58,
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 24, 24, 24),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0, 2))
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24.0),
                                                  child: CustomText(
                                                      color: Colors.black,
                                                      text: property.title,
                                                      weight: FontWeight.bold,
                                                      size: 25,
                                                      maxLines: 3),
                                                ),
                                              ),
                                              isMobile()
                                                  ? const SizedBox.shrink()
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 24.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CustomText(
                                                              color: Pallet
                                                                  .secondaryColor,
                                                              text: Utils.amount(
                                                                  property
                                                                      .price!),
                                                              weight: FontWeight
                                                                  .bold,
                                                              size: 20),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 4.0),
                                                            child: CustomText(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                                text: property
                                                                            .priceDuration!
                                                                            .substring(0,
                                                                                3) ==
                                                                        'Per'
                                                                    ? property
                                                                        .priceDuration!
                                                                        .toUpperCase()
                                                                    : '',
                                                                weight:
                                                                    FontWeight
                                                                        .w500,
                                                                size: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 22.0),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.location_on,
                                                    color:
                                                        Pallet.secondaryColor,
                                                    size: 18),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: CustomText(
                                                      color: Colors.black,
                                                      text:
                                                          '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                                      weight: FontWeight.w500,
                                                      maxLines: 4,
                                                      size: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          isMobile()
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 24.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomText(
                                                          color: Pallet
                                                              .secondaryColor,
                                                          text: Utils.amount(
                                                              property.price!),
                                                          weight:
                                                              FontWeight.bold,
                                                          size: 20),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 4.0),
                                                        child: CustomText(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.7),
                                                            text: property
                                                                        .priceDuration!
                                                                        .substring(
                                                                            0,
                                                                            3) ==
                                                                    'Per'
                                                                ? property
                                                                    .priceDuration!
                                                                    .toUpperCase()
                                                                : '',
                                                            weight:
                                                                FontWeight.w500,
                                                            size: 12),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 3,
                                                        color: Pallet
                                                            .secondaryColor,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const CustomText(
                                                      color: Colors.black,
                                                      text: 'Description',
                                                      weight: FontWeight.w800,
                                                      size: 18),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 23.0),
                                                child: ReadMoreText(
                                                  '${property.description}',
                                                  trimLines: 4,
                                                  textAlign: TextAlign.justify,
                                                  colorClickableText:
                                                      Pallet.secondaryColor,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey[600]),
                                                  trimMode: TrimMode.Line,
                                                  lessStyle: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      color: Pallet
                                                          .secondaryColor),
                                                  trimCollapsedText:
                                                      '  Read more',
                                                  trimExpandedText:
                                                      '  Read less',
                                                  moreStyle: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Pallet
                                                          .secondaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 3,
                                                        color: Pallet
                                                            .secondaryColor,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const CustomText(
                                                      color: Colors.black,
                                                      text:
                                                          'Property Details (Nearby)',
                                                      weight: FontWeight.w800,
                                                      size: 18),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 23.0),
                                                  child: SizedBox(
                                                    width: Get.width,
                                                    child: GridView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          details?.length,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount:
                                                            isMobile() ? 2 : 4,
                                                        mainAxisExtent: 32,
                                                      ),
                                                      itemBuilder: (_, index) =>
                                                          details?[index] ??
                                                          const SizedBox
                                                              .shrink(), //amenities
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 3,
                                                        color: Pallet
                                                            .secondaryColor,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const CustomText(
                                                      color: Colors.black,
                                                      text: 'Amenities',
                                                      weight: FontWeight.w800,
                                                      size: 18),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 23.0),
                                                  child: SizedBox(
                                                    width: Get.width,
                                                    child: GridView.builder(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          amenities?.length,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount:
                                                            isMobile() ? 2 : 4,
                                                        mainAxisExtent: 32,
                                                      ),
                                                      itemBuilder: (_, index) =>
                                                          amenities?[index] ??
                                                          const SizedBox
                                                              .shrink(), //
                                                    ),
                                                  )),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 3,
                                                        color: Pallet
                                                            .secondaryColor,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  const CustomText(
                                                      color: Colors.black,
                                                      text: 'Customer Reviews',
                                                      weight: FontWeight.w800,
                                                      size: 18),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 23.0),
                                                  child: reviews),
                                              const SizedBox(
                                                height: 48,
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 3,
                                                        color: Pallet
                                                            .secondaryColor,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  user.id == property.user?.id
                                                      ? const SizedBox.shrink()
                                                      : const CustomText(
                                                          color: Colors.black,
                                                          text:
                                                              'Review this Property',
                                                          weight:
                                                              FontWeight.w800,
                                                          size: 18),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              user.id == property.user?.id
                                                  ? const SizedBox.shrink()
                                                  : Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Column(children: [
                                                        const SizedBox(
                                                            height: 16),
                                                        RatingBar.builder(
                                                          minRating: 1,
                                                          itemCount: 5,
                                                          itemSize: 32,
                                                          itemPadding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          itemBuilder: (context,
                                                                  _) =>
                                                              const Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            EditCtrl.rating
                                                                    .text =
                                                                rating
                                                                    .toInt()
                                                                    .toString();
                                                          },
                                                        ),
                                                      ]),
                                                    ),
                                              user.id == property.user?.id
                                                  ? const SizedBox.shrink()
                                                  : Container(
                                                      width: Get.width * 0.8,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 24,
                                                              top: 20),
                                                      color: const Color(
                                                          0xFFf9f9f9),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: Get.width *
                                                                    0.4 +
                                                                12,
                                                            child:
                                                                UnderlineFormInput(
                                                              controller: EditCtrl
                                                                  .messageReview,
                                                              hint:
                                                                  'Type your comment here.',
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          FormButton(
                                                            onPressed: () => propCtrl
                                                                .submitPropertyReview(
                                                                    property
                                                                        .id),
                                                            text:
                                                                'Submit Review',
                                                            width: 160,
                                                            height: 42,
                                                            size: 16,
                                                            txtColor:
                                                                Colors.white,
                                                            radius: 4,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                    width: isTabletDown()
                                        ? Get.width
                                        : Get.width * 0.28,
                                    child: Container(
                                      // height: 1600,
                                      padding: EdgeInsets.only(
                                          left: isTabletDown() ? 0 : 24,
                                          top: isTabletDown() ? 24 : 0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      spreadRadius: 1,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 2))
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: 42,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(3),
                                                              topRight: Radius
                                                                  .circular(3)),
                                                      color:
                                                          Pallet.secondaryColor,
                                                    ),
                                                    child: const Center(
                                                      child: CustomText(
                                                          color: Colors.white,
                                                          text:
                                                              'AGENT INFORMATION',
                                                          weight:
                                                              FontWeight.w700,
                                                          size: 12),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Container(
                                                    width: 54,
                                                    height: 54,
                                                    margin:
                                                        const EdgeInsets.only(
                                                      right: 0,
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              48),
                                                      child: FadeInImage(
                                                        image: NetworkImage(
                                                          userImgPath +
                                                              (property.user
                                                                      ?.image ??
                                                                  ''),
                                                        ),
                                                        placeholder:
                                                            const AssetImage(
                                                                ImgStr.logo1),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  CustomText(
                                                      color: Colors.black,
                                                      text: accountName(
                                                          user: property.user),
                                                      weight: FontWeight.w600,
                                                      size: 16),
                                                  const SizedBox(height: 8),
                                                  property.contact
                                                              ?.phoneNumber ==
                                                          null
                                                      ? const SizedBox.shrink()
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons.phone,
                                                              color: Pallet
                                                                  .secondaryColor,
                                                              size: 12,
                                                            ),
                                                            const SizedBox(
                                                                width: 8),
                                                            CustomText(
                                                                underline: true,
                                                                color: Pallet
                                                                    .secondaryColor,
                                                                text:
                                                                    '${property.contact?.phoneNumber}',
                                                                weight:
                                                                    FontWeight
                                                                        .w700,
                                                                size: 11),
                                                          ],
                                                        ),
                                                  property.contact
                                                              ?.phoneNumber ==
                                                          null
                                                      ? const SizedBox.shrink()
                                                      : const SizedBox(
                                                          height: 8),
                                                  property.contact
                                                              ?.whatsAppNumber ==
                                                          null
                                                      ? const SizedBox.shrink()
                                                      : OpenWhatsApp(
                                                          widget: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                'assets/images/whatsapp.png',
                                                                color: Pallet
                                                                    .secondaryColor,
                                                                height: 12,
                                                                width: 12,
                                                              ),
                                                              const SizedBox(
                                                                  width: 8),
                                                              CustomText(
                                                                  underline:
                                                                      true,
                                                                  color: Pallet
                                                                      .secondaryColor,
                                                                  text:
                                                                      '${property.contact?.whatsAppNumber}',
                                                                  weight:
                                                                      FontWeight
                                                                          .w700,
                                                                  size: 11),
                                                            ],
                                                          ),
                                                          phone:
                                                              '${property.contact?.whatsAppNumber}',
                                                        ),
                                                  property.contact
                                                              ?.whatsAppNumber ==
                                                          null
                                                      ? const SizedBox.shrink()
                                                      : const SizedBox(
                                                          height: 8),
                                                  property.contact
                                                              ?.emailAddress ==
                                                          null
                                                      ? const SizedBox.shrink()
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Flexible(
                                                              child: Icon(
                                                                Icons.mail,
                                                                color: Pallet
                                                                    .secondaryColor,
                                                                size: 12,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 8),
                                                            Flexible(
                                                              child: CustomText(
                                                                  underline:
                                                                      true,
                                                                  color: Pallet
                                                                      .secondaryColor,
                                                                  text: property
                                                                          .contact
                                                                          ?.emailAddress ??
                                                                      '',
                                                                  weight:
                                                                      FontWeight
                                                                          .w700,
                                                                  size: 11),
                                                            ),
                                                          ],
                                                        ),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 24),
                                            // Container(
                                            //   padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
                                            //   decoration: BoxDecoration(
                                            //     color: Colors.white,
                                            //     borderRadius: BorderRadius.circular(4),
                                            //     boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 2, offset: Offset(0, 2))],
                                            //   ),
                                            //   child: Column(
                                            //     children: [
                                            //       const CustomText(color: Colors.black, text: 'share via:', weight: FontWeight.w600, size: 16),
                                            //       const SizedBox(height: 20),
                                            //       Padding(
                                            //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                            //         child:           GestureDetector(
                                            //           onTap: () async {
                                            //             showDialog(
                                            //               context: context,
                                            //               builder: (ctx) => const AlertDialog(
                                            //                 title: Text("Msg"),
                                            //                 content: Text(
                                            //                     "Please wait while link is been generated"),
                                            //                 actions: <Widget>[
                                            //                   Center(
                                            //                     child: CircularProgressIndicator(
                                            //                       backgroundColor: Colors.red,
                                            //                       strokeWidth: 3,
                                            //                     ),
                                            //                   )
                                            //                 ],
                                            //               ),
                                            //             );
                                            //             print(images);
                                            //             print(images.length);
                                            //             String generatedDeepLink =
                                            //                 await FirebaseDynamicLinkService
                                            //                 .createDynamicLink(
                                            //               property,
                                            //                   images[0].media.toString(),
                                            //               true,
                                            //             );
                                            //             Navigator.pop(context);
                                            //             print(
                                            //                 "GENARATED DEEP LINK ${generatedDeepLink.length}");
                                            //             print("GENARATED DEEP LINK ${generatedDeepLink}");
                                            //             await Share.share(
                                            //               "Check out this property at brixmarket " +
                                            //                   generatedDeepLink,
                                            //             );
                                            //           },
                                            //           child: Container(
                                            //             height: 50,
                                            //             margin: const EdgeInsets.symmetric(horizontal: 12),
                                            //             width: double.infinity,
                                            //             decoration: BoxDecoration(
                                            //                 borderRadius: BorderRadius.circular(4),
                                            //                 border: Border.all(color: Colors.blueGrey, width: 1.5)),
                                            //             child: Row(
                                            //               mainAxisAlignment: MainAxisAlignment.center,
                                            //               children: const [
                                            //                 Icon(
                                            //                   Icons.share,
                                            //                   color: Pallet.secondaryColor,
                                            //                 ),
                                            //                 SizedBox(width: 10),
                                            //                 CustomText(
                                            //                     color: Colors.black,
                                            //                     text: 'Share to a Friend',
                                            //                     weight: FontWeight.w400,
                                            //                     size: 14),
                                            //               ],
                                            //             ),
                                            //           ),
                                            //         )
                                            //       )
                                            //     ],
                                            //   ),
                                            // ),
                                            const SizedBox(height: 24),
                                            user.id == property.user?.id
                                                ? const SizedBox.shrink()
                                                : Container(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color:
                                                                Colors.black12,
                                                            spreadRadius: 1,
                                                            blurRadius: 2,
                                                            offset:
                                                                Offset(0, 2))
                                                      ],
                                                    ),
                                                    child: property
                                                                .user
                                                                ?.settings
                                                                ?.requestTourAlert
                                                                .value ==
                                                            false
                                                        ? const SizedBox
                                                            .shrink()
                                                        : Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 42,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius: const BorderRadius
                                                                          .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              3),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              3)),
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: CustomText(
                                                                      color: Colors
                                                                          .black,
                                                                      text:
                                                                          'REQUEST A TOUR',
                                                                      weight: FontWeight
                                                                          .w700,
                                                                      size: 12),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0,
                                                                    vertical:
                                                                        10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    UnderlineFormInput(
                                                                      controller:
                                                                          EditCtrl
                                                                              .name,
                                                                      hint:
                                                                          'Name',
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    UnderlineFormInput(
                                                                      controller:
                                                                          EditCtrl
                                                                              .phone,
                                                                      hint:
                                                                          'Phone',
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    UnderlineFormInput(
                                                                      controller:
                                                                          EditCtrl
                                                                              .email,
                                                                      hint:
                                                                          'Email',
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    UnderlineFormInput(
                                                                      controller:
                                                                          EditCtrl
                                                                              .messageTour,
                                                                      hint:
                                                                          'Message',
                                                                      maxLines:
                                                                          3,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            8),
                                                                    FormButton(
                                                                      onPressed:
                                                                          () =>
                                                                              propCtrl.submitRequestATour(property.id),
                                                                      text:
                                                                          'Send Request',
                                                                      txtColor:
                                                                          Colors
                                                                              .white,
                                                                      // width: do,
                                                                      height:
                                                                          42,
                                                                      size: 14,
                                                                      radius: 4,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            16),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                  ),
                                          ]),
                                    )),
                              ],
                            )),
                        pageFooter(),
                      ],
                    ),
                  ),
                ),
              );
            });
          }
        });
  }

  void nextPage() {
    _controller.animateToPage(_controller.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void previousPage() {
    _controller.animateToPage(_controller.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
