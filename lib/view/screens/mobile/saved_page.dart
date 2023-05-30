import 'dart:async';

import 'package:brixmarket/core/preloader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../adapter/property_adapter.dart';
import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../controllers/mobile_app_controllers/homepage_controller.dart';
import '../../../models/property_model.dart';
import '../../widgets/appbar_menus.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/material_search_bar/src/widgets/mobile_app_widgets/property_container.dart';
import 'package:brixmarket/models/saved_property_model.dart' as savedProperty;

class SavedPages extends StatefulWidget {
  const SavedPages({Key? key}) : super(key: key);

  @override
  State<SavedPages> createState() => _SavedPagesState();
}

class _SavedPagesState extends State<SavedPages> {
  List<String> propertyID = [];
  int page = 1;
  ScrollController _controller = ScrollController();
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  StreamController<savedProperty.SavedProperty> _savedPropertyStreamController =
  StreamController.broadcast();
  getSavedProperty(int page) async {
    PropertyApi propertyApi = PropertyApi();
    await propertyApi.getSavedProperties(page,homeCtrl.user.value.id);
    setState(() {
      _savedPropertyStreamController = propertyApi.getsavedProperty;
      isLoading = false;
    });
  }
  @override
  void initState() {
    getSavedProperty(page);
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
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.delayed(const Duration(milliseconds: 10), () {
        Get.find<MobileHomeController>().bottomNavIndex.value = 0;
        return false;
      }),
      child: Scaffold(
        backgroundColor: Pallet.homeBackground,
        appBar: AppBar(
          backgroundColor: Pallet.secondaryColor,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () =>
                Get.find<MobileHomeController>().bottomNavIndex.value = 0,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 14, 0, 14),
              child: Icon(Icons.arrow_back),
            ),
          ),
          title: const CustomText(
            color: Colors.white,
            size: 18,
            text: 'Favourites',
          ),
          actions: [
            AppBarMenu(
              logout: true,
              myAccount: true,
              //clearSave: true,
              propertyIDS: homeCtrl.user.value.savedProperties!,
            ),
          ],
        ),
        body:
        Stack(
          children: [
            SizedBox(
              height: Get.height,
              child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  child: StreamBuilder<savedProperty.SavedProperty>(
                      stream: _savedPropertyStreamController.stream,
                      builder: (context, snapdata) {
                        if (snapdata.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Align(
                                alignment: Alignment.center,
                                child: Preloader.loadingWidget()),
                          );
                        } else if (isLoading) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Align(
                                alignment: Alignment.center,
                                child: Preloader.loadingWidget()),
                          );
                        } else {
                          List<savedProperty.Property> properties =
                              snapdata.data!.data.properties;
                          page = snapdata.data!.data.pages;
                          return Column(children: [
                            const SizedBox(height: 16),
                            const Divider(color: Colors.black12),
                            ListView.builder(
                              //controller: scrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: properties.length,
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, bottom: 20),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  savedProperty.Property property =
                                  properties[index];
                                  //  page = snapdata.data!.data.pages;
                                  if (snapdata
                                      .data!.data.properties.isEmpty) {
                                    return Column(
                                      children: [
                                        Column(children: [
                                          SizedBox(
                                            height: Get.height * 0.2,
                                          ),
                                  TextStyles.richTexts(
                                                        centerText: true,
                                                        color: Colors.blueGrey,
                                                        decoration: TextDecoration.underline,
                                                        onPress1: () => Get.find<MobileHomeController>()
                                                            .bottomNavIndex
                                                            .value = 1,
                                                        onPress2: () {},
                                                        size: 16,
                                                        text1:
                                                            'You don\'t have any saved property listed.\n',
                                                        text2: 'Browse list',
                                                      )
                                        ])
                                      ],
                                    );
                                  } else {
                                    return
                                      buildSavedList(
                                                                  showMore: true,
                                                                  property: property,
                                                                  borderColor: Colors.grey);
                                  }
                                }),
                          ]);
                        }
                      })),
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
                              getSavedProperty(index);
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
        // FutureBuilder(
        //     future: propCtrl.getSavedProperties(homeCtrl.user.value.id),
        //     builder: (context, AsyncSnapshot snap) {
        //       List<Property> properties = snap.data ?? [];
        //      // print(properties[0].title);
        //       return Obx(() => propCtrl.mySavedProperties.value.isEmpty &&
        //               snap.connectionState == ConnectionState.waiting
        //           ? SizedBox(
        //               height: MediaQuery.of(context).size.height * 0.8,
        //               child: Align(
        //                   alignment: Alignment.center,
        //                   child: Preloader.loadingWidget()),
        //             )
        //           : propCtrl.mySavedProperties.value.isEmpty
        //               ? Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: [
        //                     Center(
        //                         child:
        //                             Image.asset('assets/images/favourite.PNG')),
        //                     TextStyles.richTexts(
        //                       centerText: true,
        //                       color: Colors.blueGrey,
        //                       decoration: TextDecoration.underline,
        //                       onPress1: () => Get.find<MobileHomeController>()
        //                           .bottomNavIndex
        //                           .value = 1,
        //                       onPress2: () {},
        //                       size: 16,
        //                       text1:
        //                           'You don\'t have any saved property listed.\n',
        //                       text2: 'Browse list',
        //                     )
        //                   ],
        //                 )
        //               : SizedBox(
        //                   height: Get.height,
        //                   child: SizedBox(
        //                     child: ListView.builder(
        //                         itemCount:
        //                             propCtrl.mySavedProperties.length,
        //                         padding: const EdgeInsets.only(
        //                             left: 12.0, right: 12.0, bottom: 20),
        //                         scrollDirection: Axis.vertical,
        //                         shrinkWrap: true,
        //                         itemBuilder: (context, index) {
        //                           return Text(
        //                               propCtrl
        //                                   .mySavedProperties[index].title!
        //                           );
        //                             // buildPremiumList(
        //                             //   showMore: true,
        //                             //   property: propCtrl
        //                             //       .mySavedProperties[index],
        //                             //   borderColor: Colors.grey);
        //                         }),
        //                   ),
        //                 ));
        //     }),
      ),
    );
  }
}
