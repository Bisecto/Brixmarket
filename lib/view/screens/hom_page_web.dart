import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/core/app.dart';
import 'package:brixmarket/libs/launch_urls.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../controllers/instance.dart';
import '../../models/property_model.dart';
import '../../res/strings.dart';
import '../../utils/utils.dart';
import '../widgets/footer_page.dart';
import '../widgets/main_drawer.dart';
import '../widgets/mobile_appbar.dart';
import '../widgets/property_cards.dart';
import '../widgets/save_property_icon.dart';
import '../widgets/web_hero_seach.dart';
import 'about.dart';

@immutable
class HomePageWeb extends StatelessWidget {
  HomePageWeb({Key? key}) : super(key: key);

  final CarouselController _controller = CarouselController();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double vw = MediaQuery.of(context).size.width;
    double vh = MediaQuery.of(context).size.height;
    double mainPadding = Get.width < 480 ? Get.width * 0.05 : Get.width * 0.06;
    double card1Width = isMobile()
        ? double.infinity
        : isTablet()
            ? Get.width * 0.41
            : Get.width * 0.275;
    double card1Space = !isTabletDown() ? 16 : Get.width * 0.03;
    double heroHeight = Get.width * 0.1 +
        (isMobile()
            ? 36
            : isTablet()
                ? 48
                : 58) +
        (isMobile()
            ? 14
            : isTablet()
                ? 18
                : 24) +
        (isMobile()
            ? 24
            : isTablet()
                ? 24
                : 48) +
        (isTabletDown()
            ? isMobile()
                ? 84 + 140
                : 120 + 160
            : 72 + 200);
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Pallet.primaryBackgroundLight,
        key: homeScaffoldKey,
        drawer: buildDrawer(context),
        appBar: appBarWeb(homeScaffoldKey),
        body: Container(
          height: vh,
          width: vw,
          color: Pallet.homeBackground,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Obx(() => AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInBack,
                          width: Get.width,
                          height: heroHeight,
                          decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage(homeCtrl.heroImage.value))),
                        )),
                    Container(
                      width: Get.width,
                      height: heroHeight,
                      color: Colors.black.withOpacity(0.7),
                      padding: EdgeInsets.only(top: Get.width * 0.1),
                      child: Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              CustomText(
                                text: 'Find your way to a ',
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
                          CustomText(
                            text: ' Buy, Rent and Lease properties in a safe space',
                            // text: ' A Hassle-free market place on accessing \nrealtors on a glance',
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            size: isMobile()
                                ? 14
                                : isTablet()
                                    ? 18
                                    : 24,
                            color: Pallet.whiteColor,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(
                              height: isMobile()
                                  ? 24
                                  : isTablet()
                                      ? 24
                                      : 48),
                          const SizedBox(height: 8),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: isMobile() ? 16 : (isTablet() ? 48 : 84)),
                              width: 840,
                              color: Colors.transparent,
                              child: WebHeroSearch()),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    height: isTabletDown()
                        ? isMobile()
                            ? 84
                            : 120
                        : 72,
                    width: Get.width,
                    color: Colors.black,
                    child: Center(
                      child: Wrap(alignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, children: [
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Get.width < 320
                              ? const SizedBox.shrink()
                              : const Padding(
                                  padding: EdgeInsets.only(top: 6.0),
                                  child: Text('For Better Experience', style: TextStyle(color: Colors.white)),
                                ),
                          const SizedBox(width: 8),
                          Text('Download Our APP', style: TextStyle(color: Colors.white, fontSize: isMobile() ? 18 : 24, fontWeight: FontWeight.w700)),
                        ]),
                        isTabletDown() ? const SizedBox(height: 8, width: double.infinity) : const SizedBox(width: 32),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OpenUrl(
                              url: Str.downloadAndroidLink,
                              widget: Image.asset('assets/images/playstore.png', fit: BoxFit.contain, width: isMobile() ? 120 : 172),
                            ),
                            const SizedBox(width: 8),
                            OpenUrl(
                              url: Str.downloadIOSLink,
                              widget: Image.asset('assets/images/apple.png', fit: BoxFit.contain, width: isMobile() ? 120 : 172),
                            ),
                          ],
                        ),
                      ]),
                    )),
                const SizedBox(height: 48),
                const SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: mainPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.015, bottom: 4),
                        child: const CustomText(
                          text: 'Top Premium Realtors',
                          color: Colors.black87,
                          size: 24,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Container(
                                  width: 32,
                                  height: 4,
                                  margin: EdgeInsets.only(top: 4, left: Get.width * 0.015),
                                  decoration: BoxDecoration(color: Pallet.secondaryColor, borderRadius: BorderRadius.circular(2))),
                              Container(
                                  width: 8,
                                  height: 4,
                                  margin: const EdgeInsets.only(left: 4, top: 4),
                                  decoration: BoxDecoration(color: Pallet.secondaryColor, borderRadius: BorderRadius.circular(2))),
                              Container(
                                  width: 4,
                                  height: 4,
                                  margin: const EdgeInsets.only(left: 4, top: 4),
                                  decoration: BoxDecoration(color: Pallet.secondaryColor, borderRadius: BorderRadius.circular(2))),
                            ],
                          )),
                      const SizedBox(height: 24),
                      Obx(
                        () => !propCtrl.isFeaturedProperties.value
                            ? const SizedBox.shrink()
                            : Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    PropertyCard1(
                                        property: propCtrl.featuredProperties[1],
                                        height: isTabletDown() ? 260 : 540,
                                        width: isTablet() ? card1Width * 2 + card1Space : card1Width),
                                    SizedBox(height: card1Space, width: isTabletDown() ? double.infinity : card1Space),
                                    SizedBox(
                                      width: isTablet() ? card1Width * 2 + card1Space + 8 : card1Width,
                                      child: Wrap(
                                        children: [
                                          PropertyCard1(property: propCtrl.featuredProperties[2], height: 260, width: card1Width),
                                          SizedBox(width: card1Space, height: card1Space),
                                          PropertyCard1(property: propCtrl.featuredProperties[3], height: 260, width: card1Width),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: isTabletDown() ? double.infinity : card1Space, height: card1Space),
                                    PropertyCard1(
                                        property: propCtrl.featuredProperties[4],
                                        height: isTabletDown() ? 260 : 540,
                                        width: isTablet() ? card1Width * 2 + card1Space : card1Width),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                CustomText(
                  text: 'Featured Properties',
                  size: 32,
                  color: Colors.blueGrey[900],
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
                                      Property property = e;
                                      String image = property.media!.isNotEmpty ? property.media![0].media! : '';
                                      return Stack(
                                        children: [
                                          InkWell(
                                            onTap: () => homeCtrl.viewSingleProperty(property),
                                            child: Container(
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        propertyImgPath + image,
                                                      ))),
                                            ),
                                          ),
                                          SizedBox(
                                              height: Utils.homeFeatureHeight(),
                                              child: Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Container(
                                                  color: Colors.black87,
                                                  padding: const EdgeInsets.fromLTRB(16, 16, 6, 16),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          CustomText(color: Colors.white, text: property.title ?? '', weight: FontWeight.w700, size: 16),
                                                          const SizedBox(height: 8),
                                                          Row(
                                                            children: [
                                                              const Icon(Icons.location_on, color: Pallet.secondaryColor, size: 18),
                                                              const SizedBox(width: 12),
                                                              Expanded(
                                                                child: CustomText(
                                                                    color: Colors.white,
                                                                    text: '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                                                    weight: FontWeight.w500,
                                                                    maxLines: 1,
                                                                    size: 14),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 16),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Wrap(
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
                                                                      color: Colors.white.withOpacity(0.7),
                                                                      text: property.priceDuration!.substring(0, 3) == 'Per' ? property.priceDuration!.toUpperCase() : '',
                                                                      weight: FontWeight.w500,
                                                                      size: 14,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Obx(() =>
                                                                  SavePropertyIcon(property: property, user: homeCtrl.user.value, state: homeCtrl.savingProperty.value)),
                                                            ],
                                                          ),
                                                        ],
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
                                      viewportFraction: isMobile()
                                          ? 0.7
                                          : isTablet()
                                              ? 0.6
                                              : 0.36,
                                      aspectRatio: 1,
                                      height: 430,
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
                const SizedBox(height: 100),
                // Container(
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage('assets/images/welcome3.jpg'),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   child: Container(
                //     color: Colors.white70,
                //     width: double.infinity,
                //     child: IntrinsicHeight(
                //       child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                //         !isDesktopSmall() && !isTabletDown()
                //             ? Container(
                //                 width: Get.width * 0.4,
                //                 padding: EdgeInsets.only(top: Get.width * 0.01, bottom: Get.width * 0.01),
                //                 decoration: const BoxDecoration(
                //                   image: DecorationImage(image: AssetImage('assets/images/wave.png')),
                //                 ),
                //                 child: Image.asset('assets/images/p2.png', height: 380, fit: BoxFit.contain),
                //               )
                //             : const SizedBox.shrink(),
                //         Container(
                //           width: !isDesktopSmall() && !isTabletDown() ? Get.width * 0.6 : Get.width,
                //           decoration: BoxDecoration(
                //             color: !isDesktopSmall() && !isTabletDown() ? Colors.transparent : Pallet.secondaryColor,
                //           ),
                //           child: CustomPaint(
                //             painter: RPSCustomPainter(),
                //             child: Container(
                //                 decoration: const BoxDecoration(
                //                   image: DecorationImage(image: AssetImage('assets/images/wave.png')),
                //                 ),
                //                 padding: !isDesktopSmall() && !isTabletDown()
                //                     ? const EdgeInsets.fromLTRB(160, 0, 24, 84)
                //                     : EdgeInsets.symmetric(vertical: 0, horizontal: mainPadding),
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     Text('DOWNLOAD', style: TextStyle(fontSize: isMobile() ? 42 : 54, fontWeight: FontWeight.w700, color: Colors.white)),
                //                     const Text('OUR APP', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: Colors.white)),
                //                     const SizedBox(height: 32),
                //                     const Padding(
                //                       padding: EdgeInsets.symmetric(horizontal: 38.0),
                //                       child: Text(
                //                           'This is an announcement video for "Flutter Shape Maker" which is a new Tool '
                //                           'to Auto-Generate Custom Paint code by Hand Made shape. We will go through the features'
                //                           ' provided by this app and will create a Bottom '
                //                           'Navigation Bar to demonstrate the functionality.',
                //                           textAlign: TextAlign.center,
                //                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
                //                     ),
                //                     const SizedBox(height: 68),
                //                     Row(
                //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                       children: [
                //                         Column(children: [
                //                           Image.asset('assets/images/playstore.png', fit: BoxFit.contain, width: 172),
                //                           const SizedBox(height: 8),
                //                           Image.asset('assets/images/apple.png', fit: BoxFit.contain, width: 172),
                //                         ]),
                //                         Image.asset('assets/images/qrcode.png', fit: BoxFit.contain, width: 120),
                //                       ],
                //                     ),
                //                   ],
                //                 )),
                //           ),
                //         ),
                //       ]),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: mainPadding),
                  child: LayoutBuilder(
                    builder: (context, constraints) => downloadOurApp(constraints.maxWidth),
                  ),
                ),
                const SizedBox(height: 48),
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
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: 8),
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

  Widget buildFloatingSearchBar() {
    return FloatingSearchBar(
      hint: 'Country, City, Town or Area',
      scrollPadding: const EdgeInsets.only(top: 0),
      transitionDuration: const Duration(milliseconds: 0),
      transitionCurve: Curves.slowMiddle,
      borderRadius: BorderRadius.circular(4),
      automaticallyImplyBackButton: false,
      automaticallyImplyDrawerHamburger: false,
      physics: const BouncingScrollPhysics(),
      axisAlignment: 0.0,
      openAxisAlignment: 0.0,
      // width: Get.width * 0.55,
      height: isTabletDown() ? 52 : 64,
      backdropColor: Colors.transparent,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) => homeCtrl.filterProduct(query),
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          child: Material(
            color: Colors.white,
            elevation: 8.0,
            shadowColor: Colors.black,
            type: MaterialType.card,
            child: Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: homeCtrl.mainData.length,
                itemBuilder: (_, int i) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 0.2))),
                    child: Text(homeCtrl.mainData[i], style: const TextStyle(fontSize: 16))))),
          ),
        );
      },
    );
  }

  List<Widget> findProperties() {
    return [
      isTabletDown()
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boxContainer(height: Get.width * 0.45, width: Get.width * 0.45, title: 'Buy', subtitle: '1,000 properties', image: 'assets/images/room3.jpg'),
                const SizedBox(width: 5),
                boxContainer(height: Get.width * 0.45, width: Get.width * 0.45, title: 'Rent', subtitle: '1,000 properties', image: 'assets/images/room2.jpg'),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                boxContainer(
                    height: isNotDeskTop() ? 240 : 300, width: isNotDeskTop() ? 240 : 300, title: 'Buy', subtitle: '1,000 properties', image: 'assets/images/room3.jpg'),
                const SizedBox(height: 5),
                boxContainer(
                    height: isNotDeskTop() ? 240 : 300, width: isNotDeskTop() ? 240 : 300, title: 'Rent', subtitle: '1,000 properties', image: 'assets/images/room2.jpg'),
              ],
            ),
      const SizedBox(height: 5),
      isTabletDown()
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: boxContainer(
                  height: Get.width * 0.45, width: Get.width * 0.45 * 2 + 4, title: 'Premium Realtor', subtitle: '1,000 properties', image: 'assets/images/room5.jpg'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: boxContainer(
                  height: isNotDeskTop() ? 485 : 605,
                  width: isNotDeskTop() ? 240 : 300,
                  title: 'Premium Realtor',
                  subtitle: '1,000 properties',
                  image: 'assets/images/room5.jpg'),
            ),
      const SizedBox(height: 5),
      isTabletDown()
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boxContainer(height: Get.width * 0.45, width: Get.width * 0.45, title: 'New Homes', subtitle: '1,000 properties', image: 'assets/images/room1.jpg'),
                const SizedBox(width: 5),
                boxContainer(height: Get.width * 0.45, width: Get.width * 0.45, title: 'Commercial', subtitle: '1,000 properties', image: 'assets/images/room6.jpg'),
              ],
            )
          : Column(
              children: [
                boxContainer(
                    height: isNotDeskTop() ? 240 : 300,
                    width: isNotDeskTop() ? 240 : 300,
                    title: 'New Homes',
                    subtitle: '1,000 properties',
                    image: 'assets/images/room1.jpg'),
                const SizedBox(height: 5),
                boxContainer(
                    height: isNotDeskTop() ? 240 : 300,
                    width: isNotDeskTop() ? 240 : 300,
                    title: 'Commercial',
                    subtitle: '1,000 properties',
                    image: 'assets/images/room6.jpg'),
              ],
            ),
    ];
  }
}

class FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    dnd(size);
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 8.0;

    Path path = Path();
    // path.moveTo(size.width / 2, 0); //Ax, Ay
    // path.quadraticBezierTo(size.width / 1.5, size.height / 8, size.width / 2, size.height / 4); //Bx, By, Cx, Cy
    // path.quadraticBezierTo(0, 3 * size.height / 8, size.width / 2, size.height / 2);
    path.moveTo(0, 0); //Ax, Ay
    path.quadraticBezierTo(0, 40, size.height / 4, size.height / 4); //Bx, By, Cx, Cy
    path.quadraticBezierTo(0, size.height, -(size.height / 4), 3 * size.height / 4); //Dx, Dy, Ex, Ey
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Pallet.secondaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height);
    path0.lineTo(size.width * 0.0825000, size.height);
    path0.quadraticBezierTo(size.width * 0.0269500, size.height * 0.8898800, size.width * 0.0265625, size.height * 0.7090000);
    path0.cubicTo(size.width * 0.0290625, size.height * 0.5235000, size.width * 0.2012500, size.height * 0.3900000, size.width * 0.2053125, size.height * 0.2345000);
    path0.quadraticBezierTo(size.width * 0.2078125, size.height * 0.0926200, size.width * 0.1543750, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
