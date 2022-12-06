import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/core/app.dart';
import 'package:brixmarket/libs/launch_urls.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brixmarket/controllers/home_controller.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:brixmarket/models/home_property_model.dart' as home;
import '../../controllers/edit_controller.dart';
import '../../controllers/instance.dart';
import '../../models/property_model.dart';
import '../../res/lists.dart';
import '../../res/strings.dart';
import '../../utils/utils.dart';
import '../widgets/drop_down.dart';
import '../widgets/footer_page.dart';
import '../widgets/form_button.dart';
import '../widgets/main_drawer.dart';
import '../widgets/mobile_appbar.dart';
import '../widgets/property_cards.dart';
import '../widgets/save_property_icon.dart';
import '../widgets/web_hero_seach.dart';
import 'about.dart';
import 'mobile/explore_filter_page.dart';
import 'package:brixmarket/view/screens/single_property_web.dart';
@immutable
class HomePageWeb extends StatefulWidget {
  HomePageWeb({Key? key}) : super(key: key);

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  final CarouselController _controller = CarouselController();

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  int index = 0;

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
                          height: heroHeight + 145,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(homeCtrl.heroImage.value))),
                        )),
                    Container(
                      width: Get.width,
                      height: heroHeight + 145,
                      color: Colors.black.withOpacity(0.7),
                      padding: EdgeInsets.only(top: Get.width * 0.1),
                      child: Column(
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              CustomText(
                                text: 'Buy it. Sell it. Rent it. ',
                                size: isMobile()
                                    ? 28
                                    : isTablet()
                                        ? 42
                                        : 52,
                                color: Colors.white,
                                weight: FontWeight.bold,
                              ),
                              CustomText(
                                text: '',
                                size: isMobile()
                                    ? 36
                                    : isTablet()
                                        ? 48
                                        : 48,
                                color: Pallet.secondaryColor,
                                weight: FontWeight.w700,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          CustomText(
                            text:
                                ' An Online Marketplace For Everything Real Estate',
                            // text: ' A Hassle-free market place on accessing \nrealtors on a glance',
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            size: isMobile()
                                ? 12
                                : isTablet()
                                    ? 14
                                    : 18,
                            color: Pallet.whiteColor,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(
                              height: isMobile()
                                  ? 18
                                  : isTablet()
                                      ? 18
                                      : 28),
                          const SizedBox(height: 8),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      isMobile() ? 16 : (isTablet() ? 48 : 84)),
                              width: 840,
                              color: Colors.transparent,
                              child: WebHeroSearch()),
                          const SizedBox(height: 40),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    isMobile() ? 16 : (isTablet() ? 48 : 84)),
                            width: 840,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: (constraints.minWidth < 702) ? Colors.transparent : Colors.white,
                                  width: 0.5,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          index = 0;
                                          EditCtrl.filterTypes.clear();
                                          EditCtrl.filterTypes.add('Sale');
                                          //EditCtrl.filterTypes.value = 'Buy';
                                        });
                                      },
                                      child: selectPropertyType(
                                          width: constraints.minWidth,
                                          bodyIndex: 0, title: 'Buy')),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          index = 1;
                                          EditCtrl.filterTypes.clear();
                                          EditCtrl.filterTypes.add('Rent');
                                          //EditCtrl.propertyType.value = 'Rent';
                                        });
                                      },
                                      child: selectPropertyType(
                                          width: constraints.minWidth,
                                          bodyIndex: 1, title: 'Rent')),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          index = 2;
                                          EditCtrl.filterCategories.clear();
                                          EditCtrl.filterCategories.add('Commercial');
                                          // EditCtrl.propertyType.value =
                                          //     'Commercial';
                                        });
                                      },
                                      child: selectPropertyType(
                                          width: constraints.minWidth,
                                          bodyIndex: 2, title: 'Commercial')),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          index = 3;
                                          EditCtrl.filterTypes.clear();
                                          EditCtrl.filterTypes.add('Short stay');
                                          // EditCtrl.propertyType.value =
                                          //     'ShortLet';
                                        });
                                      },
                                      child: selectPropertyType(
                                          width: constraints.minWidth,
                                          bodyIndex: 3, title: 'ShortLet')),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      isMobile() ? 16 : (isTablet() ? 48 : 84)),
                              width: 840,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: DropDown(
                                        textSize: (constraints.minWidth < 702) ? 13 : 16,
                                        showLabel: true,
                                        controller: EditCtrl.priceMin,
                                        label: 'Min Price',
                                        dropIconColor: Colors.grey,
                                        borderRadius: 12,
                                        height: isTabletDown() ? 35 : 42,
                                        color: Colors.white,
                                        labelColor: Colors.white,
                                        items: Lst.minFilterPrices,
                                        hint: 'Min'),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: DropDown(
                                        textSize: (constraints.minWidth < 702) ? 13 : 16,
                                        showLabel: true,
                                        controller: EditCtrl.priceMax,
                                        label: 'Max Price',
                                        items: Lst.maxFilterPrices,
                                        dropIconColor: Colors.grey,
                                        borderRadius: 12,
                                        height: isTabletDown() ? 35 : 42,
                                        color: Colors.white,
                                        labelColor: Colors.white,
                                        hint: 'max'),
                                  ),
                                  const SizedBox(width: 20),

                                  Expanded(
                                    child: DropDown(
                                        textSize: (constraints.minWidth < 702) ? 13 : 16,
                                        showLabel: true,
                                        controller: EditCtrl.filterState,
                                        label: 'State',
                                        items: Lst.ngStates,
                                        dropIconColor: Colors.grey,
                                        borderRadius: 12,
                                        height: isTabletDown() ? 35 : 42,
                                        color: Colors.white,
                                        labelColor: Colors.white,
                                        hint: 'State'
                                    ),
                                  ),
                                  const SizedBox(width: 20),

                                  Expanded(
                                    child: Obx(() => DropDown(
                                        textSize: (constraints.minWidth < 702) ? 13 : 16,
                                        showLabel: true,
                                        controller: EditCtrl.filterCity,
                                        label: 'City/Town',
                                        items: Lst.ngLGA[EditCtrl.filterState.value.text] ?? [],
                                        dropIconColor: Colors.grey,
                                        borderRadius: 12,
                                        height: isTabletDown() ? 35 : 42,
                                        color: Colors.white,
                                        labelColor: Colors.white,
                                        hint: 'City'
                                    )),
                                  ),
                                  // Expanded(
                                  //   child: DropDown(
                                  //     textSize: (constraints.minWidth < 702) ? 13 : 16,
                                  //     borderRadius: 12,
                                  //     dropIconColor: Colors.grey,
                                  //     height: isTabletDown() ? 35 : 42,
                                  //     color: Colors.white,
                                  //     borderColor: Colors.transparent,
                                  //     showLabel: true,
                                  //     labelColor: Colors.white,
                                  //     controller: EditCtrl.category,
                                  //     label: 'Category',
                                  //     hint: 'Any',
                                  //     items: Lst.propertyCategories,
                                  //   ),
                                  // ),
                                  // const SizedBox(width: 20),
                                  // Expanded(
                                  //   child: DropDown(
                                  //     textSize: (constraints.minWidth < 702) ? 13 : 16,
                                  //
                                  //     borderRadius: 12,
                                  //     dropIconColor: Colors.grey,
                                  //     height: isTabletDown() ? 35 : 42,
                                  //     color: Colors.white,
                                  //     borderColor: Colors.transparent,
                                  //     showLabel: true,
                                  //     labelColor: Colors.white,
                                  //     controller: EditCtrl.filterStatus,
                                  //     label: 'Status',
                                  //     hint: 'Any',
                                  //     items: Lst.propertyStatus,
                                  //   ),
                                  // ),
                                  // const SizedBox(width: 20),
                                  // Expanded(
                                  //   child: DropDown(
                                  //     textSize: (constraints.minWidth < 702) ? 13 : 16,
                                  //
                                  //     borderRadius: 12,
                                  //     dropIconColor: Colors.grey,
                                  //     height: isTabletDown() ? 35 : 42,
                                  //     color: Colors.white,
                                  //     borderColor: Colors.transparent,
                                  //     showLabel: true,
                                  //     labelColor: Colors.white,
                                  //     controller: EditCtrl.priceMax,
                                  //     label: 'Maxi. Price',
                                  //     hint: 'Price ',
                                  //     items: Lst.maxFilterPrices,
                                  //   ),
                                  // ),
                                  // const SizedBox(width: 20),
                                  // Expanded(
                                  //   child: DropDown(
                                  //     textSize: (constraints.minWidth < 702) ? 13 : 16,
                                  //
                                  //     borderRadius: 12,
                                  //     dropIconColor: Colors.grey,
                                  //     height: isTabletDown() ? 35 : 42,
                                  //     color: Colors.white,
                                  //     borderColor: Colors.transparent,
                                  //     showLabel: true,
                                  //     labelColor: Colors.white,
                                  //     controller: EditCtrl.priceMin,
                                  //     label: 'Min. Price',
                                  //     hint: 'Price',
                                  //     items: Lst.minFilterPrices,
                                  //   ),
                                  // ),
                                ],
                              )),
                          const SizedBox(height: 30),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      isMobile() ? 16 : (isTablet() ? 48 : 84)),
                              width: 840,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: Row(
                                  children: [

                                    Expanded(
                                      flex: 12,
                                      child: FormButton(
                                        onPressed: () {
                                          propCtrl.setAllPropertiesWeb(
                                              filter: true);
                                        },
                                        text: 'Search',
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      flex: (constraints.minWidth < 702) ? 6 : 4,
                                      child: FormButton(
                                        onPressed: () {
                                          propCtrl.clearFilter();
                                        },
                                        text: 'Clear Filter',
                                        textSize: 14,
                                        bgColor: Colors.transparent,
                                        borderColor: Colors.white,
                                        borderWidth: 0.5,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 20,

                  children: [
                    propertyMenu(
                        prtyIcon: 'assets/images/buy-house.png',
                        width: constraints.minWidth,
                        title: 'Buy Properties',
                        body:
                        'Property all over the country is at\nyour fingertips. Brixmarket allows\nlisting of all types of real estate,\nfrom land, houses to commercial\nreal estate.',
                        btnText: 'View Properties',
                        onTap: () {
                          EditCtrl.filterTypes.clear();
                          EditCtrl.filterTypes.add('buy');
                          propCtrl.setAllPropertiesWeb(
                              filter: true);
                        }),
                    SizedBox(width: (constraints.minWidth < 1090) ?  0 : 40),


                    propertyMenu(
                        width: constraints.minWidth,
                        prtyIcon: 'assets/images/sell-house.png',

                        title: 'Sell Properties',
                        body:
                        'Are you an agent, or looking to sell\nyour own property? Put your property\nin front of buyers and renters. For\nfree! list it!\n',
                        btnText: 'List a property',
                        onTap: () {
                          if (HomeController.isLogin.value) {
                            homeCtrl.openDashboard(1);
                          } else {
                            homeCtrl.loginRequest();
                          }
                          //EditCtrl.filterTypes.clear();
                         // EditCtrl.filterTypes.add('Sale');
                        }),
                    SizedBox(width: (constraints.minWidth < 1090) ?  0 : 40),


                    propertyMenu(
                        prtyIcon: 'assets/images/rent-house.png',
                        width: constraints.minWidth,
                        title: 'Rent Properties',
                        body:
                        'House hunting just got easier. Find\n your next home without a hassle\n on Brixmarket. We have got you\n covered with shortlets and yearly\n rentals.',
                        btnText: 'View Properties',
                        onTap: () {
                          EditCtrl.filterTypes.clear();
                          EditCtrl.filterTypes.add('Rent');
                          propCtrl.setAllPropertiesWeb(
                              filter: true);
                        }),
                    SizedBox(width: (constraints.minWidth < 1090) ?  0 : 40),


                    propertyMenu(
                        prtyIcon: 'assets/images/new-house.png',

                        width: constraints.minWidth,
                        title: 'New Homes',
                        body:
                        'Looking For a new Home?. Find\n your next home without a hassle\n on Brixmarket. We have got you\n covered with all forms of exclusive \n houses for all kinds of purpose.',
                        btnText: 'Show More',
                        onTap: () {
                          EditCtrl.filterCategories.clear();
                          EditCtrl.filterCategories.add('New Home');
                          propCtrl.setAllPropertiesWeb(
                              filter: true);
                        }),
                  ],
                ),

                const SizedBox(height: 80),
                FutureBuilder(
                    future: homeCtrl.getHomeproperty(),
                    builder: (context, AsyncSnapshot<List<home.Latest>> snap) {
                      List<home.Latest> properties = snap.data ?? [];

                      if (snap.connectionState == ConnectionState.waiting) {
                        return const SizedBox.shrink();
                      } else {
                        if (snap.error != null) {
                          return const SizedBox.shrink();
                        } else {
                          return (snap.data!.isEmpty)
                              ? const SizedBox.shrink()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.068,
                                          bottom: 4),
                                      child: const CustomText(
                                        text: 'Featured Properties',
                                        color: Colors.black87,
                                        size: 24,
                                        weight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.068,
                                          bottom: 4),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 96,
                                              height: 8,
                                              margin:
                                              const EdgeInsets.only(
                                                top: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Pallet
                                                      .secondaryColor,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(8))),
                                          Container(
                                              width: 8,
                                              height: 8,
                                              margin:
                                              const EdgeInsets.only(
                                                  left: 4, top: 4),
                                              decoration: BoxDecoration(
                                                  color: Pallet
                                                      .secondaryColor,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(8))),
                                          Container(
                                              width: 8,
                                              height: 8,
                                              margin:
                                              const EdgeInsets.only(
                                                  left: 4, top: 4),
                                              decoration: BoxDecoration(
                                                  color: Pallet
                                                      .secondaryColor,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(8))),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Wrap(
                                runSpacing: 30,
                                children: [
                                  propertyListing(
                                    prtyId: properties[0].id!,
                                      prtyImage:
                                      properties[0].media![0].media ??
                                          '',
                                      prtyTitle:
                                      properties[0].title ?? '',
                                      prtyLocation:
                                      '${properties[0].location!.address}, ${properties[0].location!.city}, ${properties[0].location!.state}',
                                      property: properties[0],
                                      prtyPricing: Utils.amount(
                                        properties[0].price ?? 0,
                                      ),
                                      prtyDuration: properties[0]
                                          .priceDuration!
                                          .substring(0, 2) ==
                                          'Per'
                                          ? properties[0]
                                          .priceDuration!
                                          .toUpperCase()
                                          : ''),
                                  ////
                                  SizedBox(width: (constraints.minWidth < 1090 || isMobile()) ?  0 : 50),

                                  propertyListing(
                                    prtyId: properties[1].id!,
                                      prtyImage:
                                      properties[1].media![1].media ??
                                          '',
                                      prtyTitle:
                                      properties[1].title ?? '',
                                      prtyLocation:
                                      '${properties[1].location!.address}, ${properties[1].location!.city}, ${properties[1].location!.state}',
                                      property: properties[1],
                                      prtyPricing: Utils.amount(
                                        properties[1].price ?? 0,
                                      ),
                                      prtyDuration: properties[1]
                                          .priceDuration!
                                          .substring(0, 2) ==
                                          'Per'
                                          ? properties[1]
                                          .priceDuration!
                                          .toUpperCase()
                                          : ''),
                                  SizedBox(width: (constraints.minWidth < 1090 || isMobile()) ?  0 : 50),


                                  propertyListing(
                                    prtyId: properties[2].id!,
                                      prtyImage:
                                      properties[2].media![2].media ??
                                          '',
                                      prtyTitle:
                                      properties[2].title ?? '',
                                      prtyLocation:
                                      '${properties[2].location!.address}, ${properties[2].location!.city}, ${properties[2].location!.state}',
                                      property: properties[2],
                                      prtyPricing: Utils.amount(
                                        properties[2].price ?? 0,
                                      ),
                                      prtyDuration: properties[2]
                                          .priceDuration!
                                          .substring(0, 2) ==
                                          'Per'
                                          ? properties[2]
                                          .priceDuration!
                                          .toUpperCase()
                                          : ''),
                                ],
                              ),
                              SizedBox(width: (constraints.minWidth < 1090 || isMobile()) ?  0 : 50),
                              const SizedBox(height: 30),
                              Wrap(
                                runSpacing: 30,

                                children: [
                                  propertyListing(
                                    prtyId: properties[3].id!,
                                      prtyImage:
                                      properties[3].media![0].media ??
                                          '',
                                      prtyTitle:
                                      properties[3].title ?? '',
                                      prtyLocation:
                                      '${properties[3].location!.address}, ${properties[3].location!.city}, ${properties[3].location!.state}',
                                      property: properties[3],
                                      prtyPricing: Utils.amount(
                                        properties[3].price ?? 0,
                                      ),
                                      prtyDuration: properties[1]
                                          .priceDuration!
                                          .substring(0, 2) ==
                                          'Per'
                                          ? properties[3]
                                          .priceDuration!
                                          .toUpperCase()
                                          : ''),
                                  ////
                                  SizedBox(width: (constraints.minWidth < 1090|| isMobile()) ?  0 : 50),
                                  propertyListing(
                                    prtyId: properties[4].id!,
                                      prtyImage:
                                      properties[4].media![2].media ??
                                          '',
                                      prtyTitle:
                                      properties[4].title ?? '',
                                      prtyLocation:
                                      '${properties[4].location!.address}, ${properties[4].location!.city}, ${properties[4].location!.state}',
                                      property: properties[4],
                                      prtyPricing: Utils.amount(
                                        properties[4].price ?? 0,
                                      ),
                                      prtyDuration: properties[4]
                                          .priceDuration!
                                          .substring(0, 2) ==
                                          'Per'
                                          ? properties[4]
                                          .priceDuration!
                                          .toUpperCase()
                                          : ''),
                                  SizedBox(width: (constraints.minWidth < 1090 || isMobile()) ?  0:  50),
                                  propertyListing(
                                    prtyId: properties[5].id!,
                                      prtyImage:
                                      properties[5].media![1].media ??
                                          '',
                                      prtyTitle:
                                      properties[5].title ?? '',
                                      prtyLocation:
                                      '${properties[5].location!.address}, ${properties[5].location!.city}, ${properties[5].location!.state}',
                                      property: properties[5],
                                      prtyPricing: Utils.amount(
                                        properties[5].price ?? 0,
                                      ),
                                      prtyDuration: properties[5]
                                          .priceDuration!
                                          .substring(0, 2) ==
                                          'Per'
                                          ? properties[5]
                                          .priceDuration!
                                          .toUpperCase()
                                          : ''),
                                ],
                              )
                            ],
                          );
                        }
                      }

                      return const SizedBox.shrink();
                    }),
                const SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: mainPadding),
                  child: LayoutBuilder(
                    builder: (context, constraints) =>
                        downloadOurApp(constraints.maxWidth),
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
  propertyMenu(
      {required String title,
        required String body,
        required String btnText,
        required double width,
        required String prtyIcon,
        required Function onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:12.0,vertical:  12),
      child: AnimatedContainer(
        duration:const Duration(microseconds: 200),
        decoration: const  BoxDecoration(
          border: Border(bottom: BorderSide(width: 5.0, color: Pallet.secondaryColor)),
        ),
        child: Column(
          children: [
            SizedBox(height:50, width: 50,
              child: Image.asset(prtyIcon),
            ),
            Text(title,
                style: const TextStyle(
                  color: Color(0xFF242627),
                  height: 2,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            Text(body,
                style: const TextStyle(
                  color: Color(0xFF242627),
                  height: 2,
                  fontSize: 14,
                )),

            const SizedBox(height: 10),
            TextButton(
              onPressed: (){
                onTap();
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
                //foregroundColor: Colors.white,
              ),
              child: Text(btnText,
                  style: const TextStyle(
                    color: Pallet.secondaryColor,
                    height: 2,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 10),

          ],
        ),
      ),
    );
  }

  propertyListing(
      {required String prtyImage,
        required String prtyId,
        required String prtyTitle,
        required String prtyLocation,
        prtyPricing,
        required property,
        required String prtyDuration}) {
    return Material(
      elevation: 6,
      type: MaterialType.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context!).push(MaterialPageRoute(
              builder: (context) =>
                  Single_page_web(property_id: prtyId)));

        },
          child:Column(
        children: [
          Container(
            width: 335,
            height: 215,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      10,
                    ),
                    topRight: Radius.circular(
                      10,
                    )),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      propertyImgPath + prtyImage,
                    ))),
          ),
          SizedBox(
              width: 320,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 16, 6, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            color: Colors.black,
                            text: prtyTitle,
                            weight: FontWeight.w700,
                            size: 16),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Pallet.secondaryColor, size: 18),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomText(
                                  color: Colors.black,
                                  text: prtyLocation,
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
                                    text: prtyPricing,
                                    weight: FontWeight.w600,
                                    size: 18),
                                const SizedBox(
                                  width: 3,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: CustomText(
                                    color: Colors.black.withOpacity(0.7),
                                    text: prtyDuration,
                                    weight: FontWeight.w500,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                            Obx(() => SavehomeProperty(
                                property: property,
                                user: homeCtrl.user.value,
                                state: homeCtrl.savingProperty.value)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }


  selectPropertyType({required int bodyIndex, required String title, required double width}) {
    return Container(
      child: Center(
          child: Text(title, style: const TextStyle(color: Colors.white))),
      decoration: BoxDecoration(
          color: (index == bodyIndex)
              ? const Color(0xFFF13054)
              : Colors.transparent,
          borderRadius: (width < 702) ? BorderRadius.circular(8) :BorderRadius.only(
              topLeft: (index == 0)
                  ? const Radius.circular(8)
                  : const Radius.circular(0),
              bottomLeft: (index == 0)
                  ? const Radius.circular(8)
                  : const Radius.circular(0),
              topRight: (index == 3)
                  ? const Radius.circular(8)
                  : const Radius.circular(0),
              bottomRight: (index == 3)
                  ? const Radius.circular(8)
                  : const Radius.circular(0))),
    );
  }

  void nextPage() {
    homeCtrl.controller.animateToPage(homeCtrl.controller.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void previousPage() {
    homeCtrl.controller.animateToPage(homeCtrl.controller.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  Widget boxContainer(
      {String? title,
      String? subtitle,
      double? height,
      double? width,
      String? image}) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image!), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(4)),
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
            color: homeCtrl.highLighted.value == text
                ? Colors.white
                : Colors.transparent,
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
              color: homeCtrl.highLighted.value == text
                  ? Colors.black87
                  : Colors.white,
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
            padding:
                EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: 8),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: homeCtrl.highLighted.value == text
                            ? Pallet.secondaryColor
                            : Colors.transparent,
                        width: 2.0))),
            child: Center(
              child: CustomText(
                size: 16,
                weight: FontWeight.w600,
                text: text,
                color: homeCtrl.highLighted.value == text
                    ? Pallet.secondaryColor
                    : Colors.white,
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
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          child: Material(
            color: Colors.white,
            elevation: 8.0,
            shadowColor: Colors.black,
            type: MaterialType.card,
            child: Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: homeCtrl.mainData.length,
                itemBuilder: (_, int i) => Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black12, width: 0.2))),
                    child: Text(homeCtrl.mainData[i],
                        style: const TextStyle(fontSize: 16))))),
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
                boxContainer(
                    height: Get.width * 0.45,
                    width: Get.width * 0.45,
                    title: 'Buy',
                    subtitle: '1,000 properties',
                    image: 'assets/images/room3.jpg'),
                const SizedBox(width: 5),
                boxContainer(
                    height: Get.width * 0.45,
                    width: Get.width * 0.45,
                    title: 'Rent',
                    subtitle: '1,000 properties',
                    image: 'assets/images/room2.jpg'),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                boxContainer(
                    height: isNotDeskTop() ? 240 : 300,
                    width: isNotDeskTop() ? 240 : 300,
                    title: 'Buy',
                    subtitle: '1,000 properties',
                    image: 'assets/images/room3.jpg'),
                const SizedBox(height: 5),
                boxContainer(
                    height: isNotDeskTop() ? 240 : 300,
                    width: isNotDeskTop() ? 240 : 300,
                    title: 'Rent',
                    subtitle: '1,000 properties',
                    image: 'assets/images/room2.jpg'),
              ],
            ),
      const SizedBox(height: 5),
      isTabletDown()
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: boxContainer(
                  height: Get.width * 0.45,
                  width: Get.width * 0.45 * 2 + 4,
                  title: 'Premium Realtor',
                  subtitle: '1,000 properties',
                  image: 'assets/images/room5.jpg'),
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
                boxContainer(
                    height: Get.width * 0.45,
                    width: Get.width * 0.45,
                    title: 'New Homes',
                    subtitle: '1,000 properties',
                    image: 'assets/images/room1.jpg'),
                const SizedBox(width: 5),
                boxContainer(
                    height: Get.width * 0.45,
                    width: Get.width * 0.45,
                    title: 'Commercial',
                    subtitle: '1,000 properties',
                    image: 'assets/images/room6.jpg'),
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
    path.quadraticBezierTo(
        0, 40, size.height / 4, size.height / 4); //Bx, By, Cx, Cy
    path.quadraticBezierTo(0, size.height, -(size.height / 4),
        3 * size.height / 4); //Dx, Dy, Ex, Ey
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
    path0.quadraticBezierTo(size.width * 0.0269500, size.height * 0.8898800,
        size.width * 0.0265625, size.height * 0.7090000);
    path0.cubicTo(
        size.width * 0.0290625,
        size.height * 0.5235000,
        size.width * 0.2012500,
        size.height * 0.3900000,
        size.width * 0.2053125,
        size.height * 0.2345000);
    path0.quadraticBezierTo(size.width * 0.2078125, size.height * 0.0926200,
        size.width * 0.1543750, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
