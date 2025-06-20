import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/home_controller.dart';
import 'package:brixmarket/models/notification.dart';
import 'package:brixmarket/view/screens/mobile/profiling_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../../adapter/property_adapter.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../core/app.dart';
import '../../../core/dialogs.dart';
import '../../../core/preloader.dart';
import '../../../main.dart';
import '../../../models/home_property_model.dart';
import '../../../res/strings.dart';
import '../../../utils/utils.dart';
import '../../widgets/appbar_notification.dart';
import '../../widgets/current_location.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/material_search_bar/src/widgets/mobile_app_widgets/property_container.dart';
import '../../widgets/search_bar.dart';

import 'dart:async';

import 'package:brixmarket/models/filter_property_model.dart' as filter;

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  @override
  void initState() {
    Utils.getState();
    super.initState();
  

  }

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    homeCtrl.isGoBack = true;
    homeCtrl.firebasePermissionIOS();
    return WillPopScope(
      onWillPop: () async {
        return (await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to exit an App'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              ),
            )) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Pallet.secondaryColor,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                ImgStr.logoLightLight,
                height: 36,
              ),
              const SizedBox(width: 8),
              // const CustomText(
              //   color: Colors.white,
              //   weight: FontWeight.bold,
              //   size: 18,
              //   text: 'Brixmarket',
              // ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteStr.mobileNotification);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    AppBarNotification(),
                  ],
                ),
              ),
            )
          ],
        ),
        body: SizedBox(
          height: Get.height,
          child: ListView(
            shrinkWrap: true,
            children: [
              Stack(
                children: [
                  Container(
                    height: Get.width * 1.3 > 580
                        ? Get.width * 0.6
                        : Get.width * 0.8,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/home1.jpg'),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                      height: Get.width * 1.3 > 580
                          ? Get.width * 0.6
                          : Get.width * 0.8,
                      color: Colors.black38),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 5),
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: CurrentLocation(),
                              ),
                              const SizedBox(width: 5),
                              const Spacer(),
                              HomeController.isLogin.value
                                  ? Obx(() => GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PersonalInformation()));
                                        },
                                        child: Text(
                                          accountName(
                                              user: homeCtrl.user.value,
                                              home: true),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ))
                                  : InkWell(
                                      onTap: () => Get.toNamed(RouteStr.login),
                                      child: const CustomText(
                                        text: Str.signIn,
                                        color: Colors.white,
                                      ),
                                    )
                            ],
                          ),
                          SizedBox(height: Get.width * 0.1),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomText(
                              text: 'Find your way to',
                              color: Colors.white,
                              size: 24,
                              weight: FontWeight.w300,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: CustomText(
                              text: 'a New Home',
                              color: Colors.white,
                              size: 30,
                              weight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 8, right: 9, top: 16),
                            child: GestureDetector(
                              onTap: () =>
                                  Get.toNamed(RouteStr.mobileHomeSearch),
                              child: SearchInput(
                                width: Get.width,
                                height: Get.width > 480 ? 48 : 42,
                                isEnabled: false,
                                controller: TextEditingController(text: ''),
                                label: '',
                                hint: 'Search for city',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 3,
                  margin: const EdgeInsets.only(top: 0),
                  decoration:
                      const BoxDecoration(color: Pallet.secondaryColor)),
              const SizedBox(height: 36),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CustomText(
                        text: 'Latest Property',
                        color: Colors.blueGrey,
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                    ]),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Container(
                          width: 32,
                          height: 4,
                          margin: const EdgeInsets.only(left: 16, top: 4),
                          decoration: BoxDecoration(
                              color: Pallet.secondaryColor,
                              borderRadius: BorderRadius.circular(2))),
                      Container(
                          width: 8,
                          height: 4,
                          margin: const EdgeInsets.only(left: 4, top: 4),
                          decoration: BoxDecoration(
                              color: Pallet.secondaryColor,
                              borderRadius: BorderRadius.circular(2))),
                      Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.only(left: 4, top: 4),
                          decoration: BoxDecoration(
                              color: Pallet.secondaryColor,
                              borderRadius: BorderRadius.circular(2))),
                    ],
                  )),
              const SizedBox(height: 8),
              SizedBox(
                height: 320,
                child: FutureBuilder(
                    future: propCtrl.getHomeproperty(),
                    builder: (context, AsyncSnapshot snap) {
                      List<Latest> properties = snap.data ?? [];
                      return snap.connectionState == ConnectionState.waiting
                          ? Preloader.loadingWidget()
                          : ListView.builder(
                              itemCount: properties.length,
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Latest property = properties[index];
                                return buildHomeList(
                                    showMore: false, property: property);
                              });
                    }),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                  future: propCtrl.getLatestproperty(),
                  builder: (context, AsyncSnapshot snap) {
                    List<Latest> properties = snap.data ?? [];
                    return snap.connectionState == ConnectionState.waiting
                        ? SizedBox(height: 48, child: Preloader.loadingWidget())
                        : ListView.builder(
                            itemCount: properties.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Latest property = properties[index];
                              if (index == properties.length - 1) {
                                return _buildProgressIndicator();
                              } else {
                                return buildHomeList(
                                    showMore: false,
                                    property: property,
                                    home: true);
                              }
                            },
                          );
                  }),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  border:
                      Border(bottom: BorderSide(color: Colors.red, width: 2)),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: 'Featured Listing',
                        color: Colors.blueGrey,
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteStr.mobileHomeSearch),
                        child: const CustomText(
                          text: 'Search Your Location',
                          color: Pallet.secondaryColor,
                          size: 14,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 18),
              // Container(
              //   color: Colors.black12,
              //   height: 174,
              //   child: FutureBuilder(
              //     future: propCtrl.getFeaturedproperty1(),
              //     builder: (context, AsyncSnapshot snap) {
              //       List<Latest> properties = snap.data ?? [];
              //       return snap.connectionState == ConnectionState.waiting
              //           ? Preloader.loadingWidget()
              //           : ListView.builder(
              //               itemCount: properties.length,
              //               scrollDirection: Axis.horizontal,
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 16, vertical: 16),
              //               shrinkWrap: true,
              //               itemBuilder: (context, index) {
              //                 if (index == properties.length) {
              //                   return _buildProgressIndicator();
              //                 } else {
              //                   return buildFeaturedListing(
              //                       homeProperty: properties[index]);
              //                 }
              //               },
              //             );
              //     },
              //   ),
              // ),
              // const SizedBox(height: 36),
              // // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
              //     CustomText(
              //       text: 'Top Premium Realtors',
              //       color: Colors.blueGrey,
              //       size: 16,
              //       weight: FontWeight.w600,
              //     ),
              //     // CustomText(
              //     //   text: 'See all',
              //     //   color: Pallet.secondaryColor,
              //     //   size: 14,
              //     //   weight: FontWeight.w500,
              //     // ),
              //   ]),
              // ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Container(
                          width: 32,
                          height: 4,
                          margin: const EdgeInsets.only(left: 16, top: 4),
                          decoration: BoxDecoration(
                              color: Pallet.secondaryColor,
                              borderRadius: BorderRadius.circular(2))),
                      Container(
                          width: 8,
                          height: 4,
                          margin: const EdgeInsets.only(left: 4, top: 4),
                          decoration: BoxDecoration(
                              color: Pallet.secondaryColor,
                              borderRadius: BorderRadius.circular(2))),
                      Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.only(left: 4, top: 4),
                          decoration: BoxDecoration(
                              color: Pallet.secondaryColor,
                              borderRadius: BorderRadius.circular(2))),
                    ],
                  )),
              FutureBuilder(
                  future: propCtrl.getFeaturedproperty2(),
                  builder: (context, AsyncSnapshot snap) {
                    List<Latest> properties = snap.data ?? [];
                    return snap.connectionState == ConnectionState.waiting
                        ? Preloader.loadingWidget()
                        : ListView.builder(
                            itemCount: properties.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Latest property = properties[index];
                              if (index == properties.length) {
                                return _buildProgressIndicator();
                              } else {
                                return buildHomeList(
                                    showMore: false,
                                    property: property,
                                    home2: true);
                              }
                            },
                          );
                  }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  buildFeaturedListing({required Latest homeProperty}) {
    //String image = property.media!.isNotEmpty ? property.media![0].media! : '';
    String imag =
        homeProperty.media.isNotEmpty ? homeProperty.media[0].media : '';
    return Stack(
      children: [
        Container(
          height: 140,
          width: Get.width * 0.60,
          margin: const EdgeInsets.only(right: 12, top: 0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  propertyImgPath + imag,
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Container(
          height: 140,
          width: Get.width * 0.60,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Positioned(
          left: 8,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: CustomText(
                  text: homeProperty.title,
                  color: Colors.white,
                  maxLines: 2,
                  size: 14,
                  weight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                margin: const EdgeInsets.only(left: 0),
                child: Center(
                  child: CustomText(
                      color: Colors.yellow,
                      text: Utils.amount(homeProperty.price),
                      weight: FontWeight.bold,
                      size: 13),
                ),
                decoration: const BoxDecoration(color: Pallet.secondaryColor),
              )
            ],
          ),
        )
      ],
    );
  }
}

class SearchByNameOfProperty extends StatefulWidget {
  const SearchByNameOfProperty({Key? key}) : super(key: key);

  @override
  State<SearchByNameOfProperty> createState() => _SearchByNameOfPropertyState();
}

class _SearchByNameOfPropertyState extends State<SearchByNameOfProperty> {
  var myFocusNode = FocusNode().obs;
  TextEditingController tc = TextEditingController();
  String searchValue = '';
  bool isSubmitted = false;
  ScrollController _controller = ScrollController();

  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  StreamController<filter.FilterModel> _filterStreamController =
      StreamController.broadcast();

  getSearchedResult(int page, String searchValue) async {
    PropertyApi propertyApi = PropertyApi();
    await propertyApi.getProperty(page, searchValue: searchValue);
    setState(() {
      _filterStreamController = propertyApi.getfilterProperty;
      isLoading = false;
    });
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    propCtrl.clearFilter();
    scrollController.addListener(() {
      //scroll listener
      double showoffset =
          10.0; //Back to top botton will show on scroll offset 10.0

      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {
          //update state
        });
      } else {
        showbtn = false;
        setState(() {
          //update state
        });
      }
    });
    getSearchedResult(1, 'duplex');
  }

  int page = 1;

  @override
  void dispose() {
    super.dispose();
    //_filterStreamController.di
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Pallet.secondaryColor,
          automaticallyImplyLeading: true,
          leadingWidth: 28,
          title: Container(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Hero(
                tag: 'search',
                child: Material(
                  child: TextField(
                    onSubmitted: (value) {
                      if (value.isEmpty) {
                        MSG.errorSnackBar(
                          'Empty field',
                        );
                      } else {
                        setState(() {
                          page = 1;
                          isLoading = true;
                          searchValue = value;
                          getSearchedResult(page, searchValue);
                        });
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: myFocusNode.value.hasFocus
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () => Get.back(),
                              )
                            : const SizedBox.shrink(),
                        hintText: 'Search with name of property',
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          )),
      body: Stack(
        children: [
          (isLoading)
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                      alignment: Alignment.center,
                      child: Preloader.loadingWidget()),
                )
              : SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  child: StreamBuilder<filter.FilterModel>(
                      stream: _filterStreamController.stream,
                      builder: (context, snapdata) {
                        if (snapdata.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Align(
                                alignment: Alignment.center,
                                child: Preloader.loadingWidget()),
                          );
                        } else {
                          List<filter.Property> properties =
                              snapdata.data!.data.properties;

                          page = snapdata.data!.data.pages;
                          return properties.isEmpty
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 120,
                                          width: 120,
                                          child: Image.asset(
                                              'assets/images/list.png')),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const CustomText(
                                          color: Pallet.secondaryColor,
                                          text:
                                              'Nothing to see here, try another keyword',
                                          weight: FontWeight.normal,
                                          size: 16),
                                    ],
                                  ),
                                )
                              : Column(children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(14.0, 14, 0, 14),
                                    child: CustomText(
                                        color: Colors.blueGrey,
                                        text: 'Searched Results',
                                        weight: FontWeight.bold,
                                        size: 16),
                                  ),
                                  const SizedBox(height: 16),
                                  const Divider(color: Colors.black12),
                                  ListView.builder(
                                      //controller: scrollController,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: properties.length,
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12.0, bottom: 20),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        filter.Property property =
                                            properties[index];
                                        if (snapdata
                                            .data!.data.properties.isEmpty) {
                                          return Column(
                                            children: [
                                              Column(children: [
                                                SizedBox(
                                                  height: Get.height * 0.2,
                                                ),
                                                const CustomText(
                                                    color: Colors.blueGrey,
                                                    text: 'No Results Found',
                                                    weight: FontWeight.w400,
                                                    size: 18),
                                                const SizedBox(height: 10),
                                              ])
                                            ],
                                          );
                                        } else {
                                          return buildFilterList(
                                              showMore: true,
                                              property: property);
                                        }
                                      }),
                                  const SizedBox(
                                    height: 70,
                                  ),
                                ]);
                        }
                      })),
          if (page > 1)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: NumberPaginator(
                        numberPages: page,
                        onPageChange: (int index) {
                          setState(() {
                            isLoading = true;
                            getSearchedResult(index+1, searchValue);
                          });
                        },
                        config: NumberPaginatorUIConfig(
                          buttonSelectedForegroundColor: Colors.white,
                          buttonUnselectedForegroundColor: Colors.pink,
                          buttonUnselectedBackgroundColor:
                              Colors.grey.withOpacity(0.1),
                          buttonSelectedBackgroundColor: Colors.pink,
                        ),
                      )),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({Key? key}) : super(key: key);

  @override
  State<HomeSearchPage> createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  var myFocusNode = FocusNode().obs;
  TextEditingController tc = TextEditingController();
  String searchValue = '';
  bool isSubmitted = false;
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  StreamController<filter.FilterModel> _filterStreamController =
      StreamController.broadcast();

  getSearchedResult(int page, String searchValue) async {
    PropertyApi propertyApi = PropertyApi();
    await propertyApi.getProperty(page, location: searchValue.toLowerCase()).then((value) => {
          isLoading = false,
        });
    setState(() {
      _filterStreamController = propertyApi.getfilterProperty;
      isLoading = false;
    });
  }

  bool isLoading = false;

  @override
  void initState() {
    propCtrl.clearFilter();
    myFocusNode.value.requestFocus();
    myFocusNode.value.addListener(() {
      myFocusNode.refresh();
    });
    scrollController.addListener(() {
      //scroll listener
      double showoffset =
          10.0; //Back to top botton will show on scroll offset 10.0

      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {
          //update state
        });
      } else {
        showbtn = false;
        setState(() {
          //update state
        });
      }
    });

    getSearchedResult(1, 'Abuja');
    super.initState();
  }

  int page = 1;

  @override
  void dispose() {
    myFocusNode.value.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Pallet.secondaryColor,
          automaticallyImplyLeading: true,
          leadingWidth: 28,
          title: Container(
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Hero(
                tag: 'search',
                child: Material(
                  child: TextField(
                    focusNode: myFocusNode.value,
                    controller: EditCtrl.homeSearch,
                    onSubmitted: (value) {
                      if (value.isEmpty) {
                        MSG.errorSnackBar(
                          'Empty field',
                        );
                      } else {
                        setState(() {
                          EditCtrl.homeSearch.text = value;
                          page = 1;
                          isLoading = true;
                          searchValue = value;
                          getSearchedResult(page, searchValue);
                        });
                      }

                      //propCtrl.homeSearchProperties();
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: myFocusNode.value.hasFocus
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () => Get.back(),
                              )
                            : const SizedBox.shrink(),
                        hintText: 'Search using Location',
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          )),
      body: Stack(
        children: [
          Positioned(
            bottom: 50,
            left: 0, right: 0,
            top: 2,
            child: SizedBox(
              height: Get.height,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const ScrollPhysics(),
                child: Obx(() => propCtrl.searchLoading.value
                    ? SizedBox(
                        height: Get.height,
                        width: Get.width,
                        child: const Center(
                          child: SizedBox(child: CircularProgressIndicator()),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Pallet.secondaryColor),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {
                                    var location =
                                        user.city != null && user.city != ''
                                            ? user.city.toString()
                                            : homeCtrl.currentLocation
                                                        .split(',')
                                                        .length >
                                                    1
                                                ? homeCtrl.currentLocation
                                                    .split(',')[1]
                                                : '';
                                    if (location == '' || location == 'null') {
                                      MSG.errorSnackBar(
                                          'Your location has not yet been set');
                                    } else {
                                      EditCtrl.homeSearch.text =
                                          location.contains('Federal') ||
                                                  location.contains('FCT')
                                              ? 'Abuja'
                                              : location;
                                      //propCtrl.homeSearchProperties();
                                    }
                                  },
                                  child: const CustomText(
                                      color: Pallet.secondaryColor,
                                      text: 'Use my current location',
                                      weight: FontWeight.normal,
                                      size: 16),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 14.0, bottom: 14),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            const SearchByNameOfProperty()));
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.house,
                                        color: Colors.red,
                                      ),
                                      CustomText(
                                          color: Pallet.secondaryColor,
                                          text: '   Search using property name',
                                          weight: FontWeight.normal,
                                          size: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (isLoading)
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.6,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Preloader.loadingWidget()),
                              ),
          
                            if (!isLoading)
                              StreamBuilder<filter.FilterModel>(
                                  stream: _filterStreamController.stream,
                                  builder: (context, snapdata) {
                                    if (snapdata.connectionState ==
                                        ConnectionState.waiting) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Preloader.loadingWidget()),
                                      );
                                    } else if (isLoading) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Preloader.loadingWidget()),
                                      );
                                    } else {
                                      List<filter.Property> properties =
                                          snapdata.data!.data.properties;
          
                                      page = snapdata.data!.data.pages;
                                      return properties.isEmpty
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.6,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      height: 120,
                                                      width: 120,
                                                      child: Image.asset(
                                                          'assets/images/list.png')),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  const CustomText(
                                                      color:
                                                          Pallet.secondaryColor,
                                                      text:
                                                          'No properties showing in this location',
                                                      weight: FontWeight.normal,
                                                      size: 16),
                                                ],
                                              ),
                                            )
                                          : Column(children: [
                                              const Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: CustomText(
                                                    color: Colors.blueGrey,
                                                    text: 'Searched Results',
                                                    weight: FontWeight.bold,
                                                    size: 16),
                                              ),
                                              const SizedBox(height: 16),
                                              const Divider(
                                                  color: Colors.black12),
                                              ListView.builder(
                                                  //controller: scrollController,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: properties.length,
                                                  padding: const EdgeInsets.only(
                                                      left: 12.0,
                                                      right: 12.0,
                                                      bottom: 20),
                                                  scrollDirection: Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, index) {
                                                    filter.Property property =
                                                        properties[index];
                                                    if (snapdata.data!.data
                                                        .properties.isEmpty) {
                                                      return Column(
                                                        children: [
                                                          Column(children: [
                                                            SizedBox(
                                                              height: Get.height *
                                                                  0.2,
                                                            ),
                                                            const CustomText(
                                                                color: Colors
                                                                    .blueGrey,
                                                                text:
                                                                    'No Results Found',
                                                                weight: FontWeight
                                                                    .w400,
                                                                size: 18),
                                                            const SizedBox(
                                                                height: 10),
                                                          ])
                                                        ],
                                                      );
                                                    } else {
                                                      return buildFilterList(
                                                          showMore: true,
                                                          property: property);
                                                    }
                                                  }),
                                            ]);
                                    }
                                  }),
          
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const CustomText(
                            //         color: Colors.blueGrey,
                            //         text: 'Search Results',
                            //         weight: FontWeight.normal,
                            //         size: 16),
                            //     propCtrl.searchProperties.isEmpty
                            //         ? const CustomText(
                            //             color: Pallet.secondaryColor,
                            //             text: 'No Results Found',
                            //             weight: FontWeight.w400,
                            //             size: 16)
                            //         : CustomText(
                            //             color: Pallet.secondaryColor,
                            //             text:
                            //                 '${propCtrl.searchProperties.length} results Found',
                            //             weight: FontWeight.w400,
                            //             size: 16),
                            //   ],
                            // ),
                            // const SizedBox(height: 8),
                            // propCtrl.searchProperties.isNotEmpty
                            //     ? SizedBox(
                            //         child: ListView.builder(
                            //             physics: const NeverScrollableScrollPhysics(),
                            //             itemCount: propCtrl.searchProperties.length,
                            //             scrollDirection: Axis.vertical,
                            //             shrinkWrap: true,
                            //             itemBuilder: (context, index) {
                            //               return buildPremiumList(
                            //                   showMore: true,
                            //                   property:
                            //                       propCtrl.searchProperties[index]);
                            //             }),
                            //       )
                            //     : Column(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           SizedBox(
                            //             height: Get.height * 0.3,
                            //           ),
                            //           const CustomText(
                            //               color: Colors.blueGrey,
                            //               text: 'No Results Found',
                            //               weight: FontWeight.w400,
                            //               size: 18),
                            //           const SizedBox(height: 10),
                            //           const CustomText(
                            //               color: Colors.blueGrey,
                            //               text:
                            //                   'Enable your location for better proximity',
                            //               weight: FontWeight.w400,
                            //               size: 16),
                            //         ],
                            //       ),
                                                  const SizedBox(height: 50,)
          
                          ],
                        ),
                      )),
              ),
            ),
          ),
          if (page > 1)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: NumberPaginator(
                        numberPages: page,
                        onPageChange: (int index) {
                          setState(() {
                            isLoading = true;
                            getSearchedResult(index+1, searchValue);
                          });
                        },
                        config: NumberPaginatorUIConfig(
                          buttonSelectedForegroundColor: Colors.white,
                          buttonUnselectedForegroundColor: Colors.pink,
                          buttonUnselectedBackgroundColor:
                              Colors.grey.withOpacity(0.1),
                          buttonSelectedBackgroundColor: Colors.pink,
                        ),
                      )),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class HomeNotificationsPage extends StatefulWidget {
  const HomeNotificationsPage({Key? key}) : super(key: key);

  @override
  State<HomeNotificationsPage> createState() => _HomeNotificationsPageState();
}

class _HomeNotificationsPageState extends State<HomeNotificationsPage> {
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor:
            Utils.isMobileApp ? Pallet.secondaryColor : Colors.white,
        automaticallyImplyLeading: true,
        title: const Text('Notifications'),
        foregroundColor:
            Utils.isMobileApp ? Pallet.whiteColor : Pallet.secondaryColor,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: homeCtrl.getNotifications(),
            builder: (context, AsyncSnapshot snap) {
              List<AppNotification> notificationItems = snap.data ?? [];
              return SizedBox(
                height: Get.height,
                child: snap.connectionState == ConnectionState.waiting
                    ? Preloader.loadingWidget()
                    : snap.connectionState == ConnectionState.done &&
                            !snap.hasData
                        ? const Center(
                            child: CustomText(
                              color: Colors.blueGrey,
                              size: 16,
                              text: 'No Notifications',
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: notificationItems.length,
                            itemBuilder: ((context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: 4, top: (index == 0) ? 20 : 0),
                                child: Material(
                                    type: MaterialType.card,
                                    elevation: 3,
                                    child: Column(children: [
                                      ListTile(
                                        onTap: () => showDes.value = showDes
                                                    .value ==
                                                notificationItems[index].time
                                            ? ''
                                            : notificationItems[index].time,
                                        leading: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: notificationItems[index]
                                                  .background),
                                          child: Center(
                                              child: Icon(
                                                  notificationItems[index].icon,
                                                  color:
                                                      notificationItems[index]
                                                          .iconColor)),
                                        ),
                                        title: CustomText(
                                          color: const Color(0xFF282E3A),
                                          size: 16,
                                          text: notificationItems[index].title,
                                          weight: FontWeight.w600,
                                        ),
                                        subtitle: Obx(() => Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: showDes.value ==
                                                          notificationItems[
                                                                  index]
                                                              .time
                                                      ? 0
                                                      : 8.0),
                                              child: Text(
                                                  notificationItems[index]
                                                      .description,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            )),
                                        trailing: CustomText(
                                            color: const Color(0xFF282E3A),
                                            size: 14,
                                            text:
                                                notificationItems[index].time),
                                      ),
                                      Obx(() => showDes.value !=
                                              notificationItems[index].time
                                          ? const SizedBox.shrink()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  left: 72,
                                                  right: 12,
                                                  bottom: showDes.value ==
                                                          notificationItems[
                                                                  index]
                                                              .time
                                                      ? 16
                                                      : 8.0),
                                              child: Text(
                                                  notificationItems[index]
                                                      .description,
                                                  style: const TextStyle(
                                                      color: Colors.blueGrey)),
                                            )),
                                    ])),
                              );
                            })),
              );
            }),
      ),
    );
  }

  var showDes = ''.obs;
  List<NotificationProperties> notificationItems = [
    NotificationProperties(
        icon: Icons.notification_important,
        iconColor: Pallet.secondaryColor,
        bgColor: Pallet.secondaryColor.withOpacity(0.5),
        title: 'Password Reset',
        subTitle: 'You have Successfully changed your password',
        date: 'May, 5 2022'),
    NotificationProperties(
        icon: Icons.star,
        iconColor: const Color(0xFF4A88FF),
        bgColor: const Color(0xFFE8EFFC),
        title: 'Subscribed to PRO plan',
        subTitle: 'You have Successfully subscribed to PRO plan',
        date: 'May, 5 2022'),
    NotificationProperties(
        icon: Icons.notification_important,
        iconColor: Pallet.secondaryColor,
        bgColor: Pallet.secondaryColor.withOpacity(0.5),
        title: 'New Tour Request',
        subTitle: 'Request recieved',
        date: 'May, 5 2022'),
    NotificationProperties(
        icon: Icons.note_add,
        iconColor: const Color(0xFF4A88FF),
        bgColor: const Color(0xFFE8EFFC),
        title: 'Listing Approved',
        subTitle: 'You have Successfully been listed',
        date: 'May, 5 2022'),
    NotificationProperties(
        icon: Icons.notification_important,
        iconColor: const Color(0xFF0FA958),
        bgColor: const Color(0xFFE1F9EC),
        title: 'Payment Successful',
        subTitle: 'You have Successfully made your payment',
        date: 'May, 5 2022'),
  ];
}

class NotificationProperties {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;
  final String subTitle;
  final String date;

  NotificationProperties({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
    required this.subTitle,
    required this.date,
  });
}
