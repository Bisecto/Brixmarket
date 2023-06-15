import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/core/app.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../controllers/instance.dart';
import '../../models/media_model.dart';
import '../../models/property_model.dart';
import '../../utils/utils.dart';
import '../widgets/footer_page.dart';
import '../widgets/main_drawer.dart';
import '../widgets/mobile_appbar.dart';
import '../widgets/navbar.dart';
import '../widgets/save_property_icon.dart';

@immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final CarouselController _controller = CarouselController();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double vw = MediaQuery.of(context).size.width;
    double vh = MediaQuery.of(context).size.height;
    return LayoutBuilder(builder: (context, constraints) {
      return
          // Obx(() =>
          Scaffold(
        backgroundColor: Pallet.homeBackground,
        key: homeScaffoldKey,
        drawer: buildDrawer(context),
        appBar: !isDesktop() && false ? mobileAppBar(homeScaffoldKey) : appBarWeb(homeScaffoldKey),
        body: Container(
          height: vh,
          width: vw,
          color: Pallet.homeBackground,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isDesktop() && false ? navBar() : const SizedBox.shrink(),
                // topMessage(homeCtrl: homeCtrl),
                Stack(
                  children: [
                    Container(
                      width: Get.width,
                      height: isMobile() ? 520 : 740,
                      decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/hero1.jpg'))),
                    ),
                    Container(
                      width: Get.width,
                      height: isMobile() ? 520 : 740,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              CustomText(
                                text: ' Find your way to a ',
                                size: isMobile()
                                    ? 28
                                    : isTablet()
                                        ? 42
                                        : 52,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              ),
                              CustomText(
                                text: ' New Home',
                                size: isMobile()
                                    ? 36
                                    : isTablet()
                                        ? 48
                                        : 58,
                                color: Pallet.secondaryColor,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          FutureBuilder(
                              future: Utils.getCurrentLocation(),
                              builder: (context, AsyncSnapshot<Position?> snap) {
                                return CustomText(
                                  text: snap.data == null
                                      ? ' A Hassle-free market place on accessing realtors on a glance'
                                      : 'Lat: ${snap.data!.latitude} Lng: ${snap.data!.longitude}  Accuracy: ${snap.data!.accuracy} ',
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  size: isMobile()
                                      ? 14
                                      : isTablet()
                                          ? 18
                                          : 24,
                                  color: Pallet.whiteColor,
                                  weight: FontWeight.w200,
                                );
                              }),
                          SizedBox(height: isMobile() ? 16 : 48),
                          isTabletDown()
                              ? Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                  const Spacer(flex: 2),
                                  searchCategoryButton(onTap: () => homeCtrl.searchProperty('Buy'), text: 'Buy'),
                                  const Spacer(),
                                  searchCategoryButton(onTap: () => homeCtrl.searchProperty('Rent'), text: 'Rent'),
                                  const Spacer(),
                                  searchCategoryButton(onTap: () => homeCtrl.searchProperty('New Home'), text: 'New Home'),
                                  const Spacer(),
                                  searchCategoryButton(onTap: () => homeCtrl.searchProperty('Commercial'), text: 'Commercial'),
                                  const Spacer(flex: 2),
                                ])
                              : Container(
                                  height: 72,
                                  width: 720,
                                  color: Colors.white.withOpacity(0.1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        buttonWbg(onTap: () => homeCtrl.searchProperty('Buy'), text: 'Buy'),
                                        const SizedBox(width: 40),
                                        buttonWbg(onTap: () => homeCtrl.searchProperty('Rent'), text: 'Rent'),
                                        const SizedBox(width: 40),
                                        buttonWbg(onTap: () => homeCtrl.searchProperty('New Homes'), text: 'New Homes'),
                                        const SizedBox(width: 40),
                                        buttonWbg(onTap: () => homeCtrl.searchProperty('Commercial'), text: 'Commercial')
                                      ],
                                    ),
                                  ),
                                ),
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: isMobile() ? 268 : 198),
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: 'For a better experience',
                                      size: 14,
                                      color: isMobile() ? Pallet.secondaryColor : Pallet.whiteColor,
                                      weight: FontWeight.w200,
                                    ),
                                    const SizedBox(height: 8),
                                    CustomText(
                                      text: 'Download the App Via',
                                      size: 24,
                                      color: isMobile() ? Colors.black54 : Colors.white.withOpacity(0.5),
                                      weight: FontWeight.normal,
                                    ),
                                    const SizedBox(height: 15),
                                    Center(
                                      child: FittedBox(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 30),
                                            Image.asset('assets/images/playstore_logo.png', height: 50),
                                            const SizedBox(width: 30),
                                            Image.asset('assets/images/apple_logo.png', height: 50),
                                            const SizedBox(width: 30),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Align(
                              //   alignment: Alignment.topCenter,
                              //   child: Container(
                              //     margin: EdgeInsets.symmetric(
                              //         vertical: isMobile() ? 12 : 24,
                              //         horizontal: isMobile()
                              //             ? 16
                              //             : isTablet()
                              //                 ? 48
                              //                 : 0),
                              //     width: 740,
                              //     constraints: const BoxConstraints(maxHeight: 420),
                              //     child: buildFloatingSearchBar(),
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                const CustomText(
                  text: 'Browse popular properties',
                  size: 16,
                  color: Color.fromARGB(255, 144, 180, 196),
                  weight: FontWeight.w300,
                ),
                const SizedBox(height: 25),
                CustomText(
                  text: 'Find Properties In Your City',
                  size: isTabletDown() ? 24 : 32,
                  color: Colors.blueGrey[500],
                  weight: FontWeight.w400,
                ),
                const SizedBox(height: 30),
                // SizedBox(
                //   width: Get.width,
                //   child: isTabletDown()
                //       ? Column(
                //           children: findProperties(),
                //         )
                //       : Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: findProperties(),
                //         ),
                // ),
                const SizedBox(height: 30),
                const CustomText(
                  text: 'Check out for our recent',
                  size: 16,
                  color: Color.fromARGB(255, 144, 180, 196),
                  weight: FontWeight.w300,
                ),
                const SizedBox(height: 25),
                CustomText(
                  text: 'Featured Property',
                  size: 32,
                  color: Colors.blueGrey[500],
                  weight: FontWeight.w400,
                ),
                const SizedBox(height: 30),
                FutureBuilder(
                    future: homeCtrl.fetchFeaturedProperties(),
                    builder: (context, AsyncSnapshot<List<Property>> snap) {
                      List<Property> properties = snap.data ?? [];
                      return properties.isEmpty
                          ? const SizedBox.shrink()
                          : Stack(
                              children: [
                                CarouselSlider(
                                  items: [
                                    ...properties.map((e) {
                                      int iFeature = 0;
                                      Property property = e;
                                      String image = property.media!.isNotEmpty ? property.media![0].media! : '';
                                      List<Media> images = property.media ?? [];
                                      return Stack(
                                        children: [
                                          Container(
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      propertyImgPath + image,
                                                    ))),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(left: isTabletDown() ? 0 : Get.width * 0.08),
                                              padding: EdgeInsets.only(bottom: !isDesktop() ? Get.width * 0.03 : 0),
                                              height: Utils.homeFeatureHeight(),
                                              child: Align(
                                                alignment: isTabletDown() ? Alignment.bottomCenter : Alignment.centerLeft,
                                                child: Material(
                                                  elevation: 2,
                                                  color: Colors.white,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        width: isMobile() ? Get.width * 0.75 : 390,
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Wrap(
                                                                children: [
                                                                  Container(
                                                                    height: 28,
                                                                    width: 96,
                                                                    child: Center(
                                                                      child: CustomText(
                                                                          color: Color(0xFF308b85), text: property.type ?? '', weight: FontWeight.w500, size: 14),
                                                                    ),
                                                                    color: const Color(0xFFebfcfb),
                                                                  ),
                                                                  const SizedBox(width: 8),
                                                                  Container(
                                                                    height: 28,
                                                                    width: 68,
                                                                    child: Center(
                                                                      child:
                                                                          CustomText(color: Colors.white, text: property.status ?? '', weight: FontWeight.w500, size: 12),
                                                                    ),
                                                                    color: Pallet.secondaryColor,
                                                                  ),
                                                                  Row(mainAxisSize: MainAxisSize.min, children: [
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
                                                                        color: Colors.black,
                                                                        text: (property.numberOfRatingUsers ?? 'No Review').toString(),
                                                                        weight: FontWeight.w200,
                                                                        size: 12),
                                                                  ])
                                                                ],
                                                              ),
                                                              const SizedBox(height: 12),
                                                              const SizedBox(height: 12),
                                                              CustomText(color: Colors.black, text: property.title ?? '', weight: FontWeight.w800, size: 16),
                                                              const SizedBox(height: 4),
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
                                                              const SizedBox(height: 12),
                                                              ReadMoreText(
                                                                property.description ?? '',
                                                                trimLines: 1,
                                                                colorClickableText: Colors.pink,
                                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200, color: Colors.grey[600]),
                                                                trimMode: TrimMode.Line,
                                                                lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200, color: Pallet.secondaryColor),
                                                                trimCollapsedText: '  Read more',
                                                                trimExpandedText: '  Read less',
                                                                moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Pallet.secondaryColor),
                                                              ),
                                                              const SizedBox(height: 12),
                                                              const SizedBox(height: 24),
                                                              Wrap(
                                                                crossAxisAlignment: WrapCrossAlignment.start,
                                                                children: [
                                                                  ...property.features!.map((feature) {
                                                                    iFeature++;
                                                                    return iFeature >= 4
                                                                        ? const SizedBox.shrink()
                                                                        : Row(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            children: [
                                                                              const Icon(
                                                                                Icons.bed,
                                                                                color: Colors.black54,
                                                                                size: 12,
                                                                              ),
                                                                              const SizedBox(width: 5),
                                                                              CustomText(
                                                                                  color: Colors.black54, text: feature.featureValue, weight: FontWeight.w200, size: 13),
                                                                              const SizedBox(width: 8),
                                                                            ],
                                                                          );
                                                                  }).toList(),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 12),
                                                              const Divider(),
                                                              const SizedBox(height: 12),
                                                              const CustomText(color: Colors.black, text: 'Price', weight: FontWeight.w100, size: 12),
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
                                                                          text: Utils.amount(property.price ?? 0),
                                                                          weight: FontWeight.w700,
                                                                          size: 20),
                                                                      const SizedBox(
                                                                        width: 3,
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(top: 8.0),
                                                                        child: CustomText(
                                                                          color: Colors.black.withOpacity(0.4),
                                                                          text: property.priceDuration!.substring(0, 3) == 'Per'
                                                                              ? property.priceDuration!.toUpperCase()
                                                                              : '',
                                                                          weight: FontWeight.w500,
                                                                          size: 14,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Obx(() => SavePropertyIcon(
                                                                      property: property, user: homeCtrl.user.value, state: homeCtrl.savingProperty.value)),
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
                                              )),
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                      autoPlayInterval: const Duration(seconds: 15),
                                      autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                                      pauseAutoPlayOnTouch: true,
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      viewportFraction: 1,
                                      height: Utils.homeFeatureHeight(),
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, reason) {
                                        // homeCtrl.currentImageIndex.value = index;
                                      }),
                                ),
                                Positioned(
                                  top: !isMobile() ? Get.width * 0.2 : Get.width * 0.2,
                                  right: Get.width * 0.03,
                                  child: InkWell(
                                    onTap: () => _controller.nextPage(duration: const Duration(seconds: 1)),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 10,
                                      ),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white.withOpacity(0.4)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: !isMobile() ? Get.width * 0.2 : Get.width * 0.2,
                                  left: Get.width * 0.03,
                                  child: InkWell(
                                    onTap: () => _controller.previousPage(duration: const Duration(seconds: 1)),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 10,
                                      ),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white.withOpacity(0.4)),
                                    ),
                                  ),
                                ),
                              ],
                            );
                    }),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Pallet.secondaryColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: isTablet() ? Get.width * 0.6 : Get.width * 0.9),
                            child: Text('Are you an estate agent or developer? List your property for FREE.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: isTabletDown() ? 14 : 16,
                                )),
                          ),
                          isMobile()
                              ? const SizedBox.shrink()
                              : SizedBox(
                                  width: isMobile()
                                      ? 0
                                      : isTablet()
                                          ? 24
                                          : 80),
                          isMobile()
                              ? const SizedBox.shrink()
                              : Container(
                                  height: 38,
                                  width: 120,
                                  margin: const EdgeInsets.only(left: 8),
                                  child: Center(
                                    child: CustomText(color: Colors.blueGrey[600], text: 'Register', weight: FontWeight.w500, size: 14),
                                  ),
                                  color: Pallet.whiteColor,
                                )
                        ],
                      ),
                      isMobile()
                          ? Container(
                              height: 38,
                              width: 120,
                              margin: const EdgeInsets.only(left: 8, top: 8),
                              child: Center(
                                child: CustomText(color: Colors.blueGrey[600], text: 'Register', weight: FontWeight.w500, size: 14),
                              ),
                              color: Pallet.whiteColor,
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                pageFooter(),
              ],
            ),
          ),
        ),
      ); //);
    });
  }

  void nextPage() {
    homeCtrl.controller.animateToPage(homeCtrl.controller.page!.toInt() + 1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void previousPage() {
    homeCtrl.controller.animateToPage(homeCtrl.controller.page!.toInt() - 1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  Widget boxContainer({String? title, String? subtitle, double? height, double? width, String? image}) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(image!), fit: BoxFit.cover), borderRadius: BorderRadius.circular(4)),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: title!,
                size: isMobile() ? 20 : 28,
                color: Colors.white,
                weight: FontWeight.w700,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomText(
                text: subtitle,
                size: 16,
                color: Colors.white,
                weight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buttonWbg({
    Function()? onTap,
    String? text,
    Color? bgColor,
    Color? txtColor,
    Color? nbTxtColor,
    double? screenWidth,
    double fontSize = 18,
    double horizontal = 28,
    double vertical = 8,
    double height = 48,
    double width = 132,
    bool? isBg,
  }) {
    screenWidth = Get.width;
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.red,
      child: Obx(
        () => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: Pallet.whiteColor, width: 0.5),
            borderRadius: BorderRadius.circular(3),
            color: homeCtrl.highLighted.value == text ? Colors.white : Colors.transparent,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.white,
                offset: Offset(1.0, -6.0),
                blurRadius: 90.0,
              ),
            ],
          ),
          child: Center(
            child: CustomText(
              size: fontSize,
              color: homeCtrl.highLighted.value == text ? Colors.black87 : Colors.white,
              weight: FontWeight.w100,
              text: text!,
            ),
          ),
        ),
      ),
    );
  }

  searchCategoryButton({onTap, String text = ''}) {
    return InkWell(
      onTap: onTap,
      child: Obx(() => Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: 8),
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(color: homeCtrl.highLighted.value == text ? Pallet.secondaryColor : Colors.transparent, width: 2.0))),
            child: Center(
              child: CustomText(
                size: 16,
                weight: FontWeight.w600,
                text: text,
                color: homeCtrl.highLighted.value == text ? Pallet.secondaryColor : Colors.white,
              ),
            ),
          )),
    );
  }

  Widget textInputField() {
    return Container(
      height: 60,
      width: 720,
      padding: const EdgeInsets.only(top: 8, left: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
          controller: TextEditingController(text: ''),
          keyboardType: TextInputType.text,
          maxLines: 1,
          cursorColor: Pallet.secondaryColor,
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search_outlined,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              hintText: 'City, state, property type',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 16)),
          onChanged: (text) {}),
    );
  }

  Widget textInputField2({required double screenWidth}) {
    return Container(
      height: (screenWidth <= 592) ? 50 : 60,
      width: (screenWidth <= 592) ? 350 : 564,
      padding: const EdgeInsets.only(top: 8, left: 25),
      margin: EdgeInsets.symmetric(horizontal: (screenWidth <= 592) ? 24 : 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
          controller: TextEditingController(text: ''),
          keyboardType: TextInputType.text,
          maxLines: 1,
          cursorColor: Pallet.secondaryColor,
          decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search_outlined,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              hintText: 'city.state.property type',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
          onChanged: (text) {}),
    );
  }

  // Widget buildFloatingSearchBar() {
  //   return FloatingSearchBar(
  //     hint: 'Country, City, Town or Area',
  //     scrollPadding: const EdgeInsets.only(top: 0),
  //     transitionDuration: const Duration(milliseconds: 0),
  //     transitionCurve: Curves.slowMiddle,
  //     borderRadius: BorderRadius.circular(4),
  //     automaticallyImplyBackButton: false,
  //     automaticallyImplyDrawerHamburger: false,
  //     physics: const BouncingScrollPhysics(),
  //     axisAlignment: 0.0,
  //     openAxisAlignment: 0.0,
  //     // width: Get.width * 0.55,
  //     height: isTabletDown() ? 52 : 64,
  //     backdropColor: Colors.transparent,
  //     debounceDelay: const Duration(milliseconds: 500),
  //     onQueryChanged: (query) => homeCtrl.filterProduct(query),
  //     transition: CircularFloatingSearchBarTransition(),
  //     builder: (context, transition) {
  //       return ClipRRect(
  //         borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
  //         child: Material(
  //           color: Colors.white,
  //           elevation: 8.0,
  //           shadowColor: Colors.black,
  //           type: MaterialType.card,
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
