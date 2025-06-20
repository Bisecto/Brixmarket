import 'package:brixmarket/config/theme/color.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:brixmarket/core/preloader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instance.dart';
import '../../../core/app.dart';
import '../../../models/media_model.dart';
import '../../../models/property_model.dart';
import '../../../res/lists.dart';
import '../../../res/strings.dart';
import '../../../utils/utils.dart';
import '../../widgets/custom_text.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({Key? key}) : super(key: key);

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  int index = 0;

  int totalAllPropertypage = 0;
  int allPropertySinglePage = 1;

  int totalPublishedPropertypage = 0;
  int publishedPropertySinglePage = 1;

  int totalDraftPropertypage = 0;
  int draftPropertySinglePage = 1;

  int totalSoldPropertypage = 0;
  int soldPropertySinglePage = 1;

  int totalSuspendedPropertypage = 0;
  int suspendedPropertySinglePage = 1;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {
          index = _tabController.index;
        });
      });
    //getUserProperty(page);
    // scrollController.addListener(() {
    //   //scroll listener
    //   double showoffset =
    //   10.0; //Back to top botton will show on scroll offset 10.0
    //
    //   if (scrollController.offset > showoffset) {
    //     showbtn = true;
    //     setState(() {
    //       //update state
    //     });
    //   } else {
    //     showbtn = false;
    //     setState(() {
    //       //update state
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Pallet.secondaryColor,
          ),
        ),
        centerTitle: false,
        title: const Text("My Ads",
            style: TextStyle(
                fontSize: 16,
                color: Pallet.whiteColor,
                fontWeight: FontWeight.w600)),
        automaticallyImplyLeading: true,
        bottom: TabBar(
          isScrollable: true,
          tabs: Lst.myPropertyTabs,
          controller: _tabController,
          unselectedLabelColor: Pallet.whiteColor,
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          labelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.white,
        ),
        bottomOpacity: 1,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: Get.height * 0.85,
            child: TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: [
                FutureBuilder(
                    future: cPropCtrl
                        .getAllMyProperties(allPropertySinglePage)
                        .then((value) => {
                              totalAllPropertypage =
                                  cPropCtrl.allPropertiesPage,
                            }),
                    builder: (context, AsyncSnapshot snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                            height: 48, child: Preloader.loadingWidget());
                      } else {
                        if (cPropCtrl.myProperties.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/empty.PNG'),
                              TextStyles.richTexts(
                                  decoration: TextDecoration.underline,
                                  onPress1: () => Get.offNamed(
                                      RouteStr.mobileCreateProperty),
                                  size: 14,
                                  text1:
                                      'You don\'t have any property listed.\n',
                                  centerText: true,
                                  text2: 'Create a listing')
                            ],
                          );
                        } else {
                          totalAllPropertypage = cPropCtrl.allPropertiesPage;
                          return Column(children: [
                            Expanded(
                                child:
                                    myPropertiesWidget(cPropCtrl.myProperties)),
                            const SizedBox(
                              height: 60,
                            )
                          ]);
                        }
                      }
                    }),

                FutureBuilder(
                    future: cPropCtrl
                        .getAllPublishedProperties(publishedPropertySinglePage)
                        .then((value) => {
                              totalPublishedPropertypage =
                                  cPropCtrl.myPublishedPropertiesPage,
                            }),
                    builder: (context, AsyncSnapshot snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                            height: 48, child: Preloader.loadingWidget());
                      } else {
                        if (cPropCtrl.myPublishedProperties.value.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/empty.PNG'),
                              TextStyles.richTexts(
                                  decoration: TextDecoration.underline,
                                  onPress1: () => Get.offNamed(
                                      RouteStr.mobileCreateProperty),
                                  size: 14,
                                  text1:
                                      'You don\'t have any property listed.\n',
                                  centerText: true,
                                  text2: 'Create a listing')
                            ],
                          );
                        } else {
                          totalPublishedPropertypage =
                              cPropCtrl.myPublishedPropertiesPage;
                          return Column(children: [
                            Expanded(
                                child: Obx(() => myPropertiesWidget(
                                    cPropCtrl.myPublishedProperties))),
                            const SizedBox(
                              height: 60,
                            )
                          ]);
                        }
                      }
                    }),
                FutureBuilder(
                    future: cPropCtrl
                        .getAllDraftProperties(draftPropertySinglePage)
                        .then((value) => {
                              totalDraftPropertypage =
                                  cPropCtrl.myDraftPropertiesPage,
                            }),
                    builder: (context, AsyncSnapshot snap) {
                      List<Property> allProperties =
                          cPropCtrl.myDraftProperties; //snap.data ?? [];

                      if (snap.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                            height: 48, child: Preloader.loadingWidget());
                      } else {
                        if (cPropCtrl.myDraftProperties.value.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/empty.PNG'),
                              TextStyles.richTexts(
                                  decoration: TextDecoration.underline,
                                  onPress1: () => Get.offNamed(
                                      RouteStr.mobileCreateProperty),
                                  size: 14,
                                  text1:
                                      'You don\'t have any property listed.\n',
                                  centerText: true,
                                  text2: 'Create a listing')
                            ],
                          );
                        } else {
                          totalDraftPropertypage =
                              cPropCtrl.myDraftPropertiesPage;
                          return Column(children: [
                            Expanded(
                                child: Obx(() => myPropertiesWidget(
                                    cPropCtrl.myDraftProperties))),
                            const SizedBox(
                              height: 60,
                            )
                          ]);
                        }
                      }
                    }),
                FutureBuilder(
                    future: cPropCtrl
                        .getAllSoldProperties(soldPropertySinglePage)
                        .then((value) => {
                              totalSoldPropertypage =
                                  cPropCtrl.mySoldPropertiesPage,
                            }),
                    builder: (context, AsyncSnapshot snap) {
                      List<Property> allProperties =
                          cPropCtrl.mySoldProperties; //snap.data ?? [];

                      if (snap.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                            height: 48, child: Preloader.loadingWidget());
                      } else {
                        if (cPropCtrl.mySoldProperties.value.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/empty.PNG'),
                              TextStyles.richTexts(
                                  decoration: TextDecoration.underline,
                                  onPress1: () => Get.offNamed(
                                      RouteStr.mobileCreateProperty),
                                  size: 14,
                                  text1:
                                      'You don\'t have any property listed.\n',
                                  centerText: true,
                                  text2: 'Create a listing')
                            ],
                          );
                        } else {
                          totalSoldPropertypage =
                              cPropCtrl.mySoldPropertiesPage;
                          return Column(children: [
                            Expanded(
                                child: Obx(() => myPropertiesWidget(
                                    cPropCtrl.mySoldProperties))),
                            const SizedBox(
                              height: 60,
                            )
                          ]);
                        }
                      }
                    }),
                FutureBuilder(
                    future: cPropCtrl
                        .getAllSuspendedProperties(suspendedPropertySinglePage)
                        .then((value) => {
                              totalSuspendedPropertypage =
                                  cPropCtrl.mySuspendedPropertiesPage,
                            }),
                    builder: (context, AsyncSnapshot snap) {
                      List<Property> allProperties =
                          cPropCtrl.mySuspendedProperties; //snap.data ?? [];

                      if (snap.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                            height: 48, child: Preloader.loadingWidget());
                      } else {
                        if (cPropCtrl.mySuspendedProperties.value.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/empty.PNG'),
                              TextStyles.richTexts(
                                  decoration: TextDecoration.underline,
                                  onPress1: () => Get.offNamed(
                                      RouteStr.mobileCreateProperty),
                                  size: 14,
                                  text1:
                                      'You don\'t have any property listed.\n',
                                  centerText: true,
                                  text2: 'Create a listing')
                            ],
                          );
                        } else {
                          totalSuspendedPropertypage =
                              cPropCtrl.mySuspendedPropertiesPage;
                          return Column(children: [
                            Expanded(
                                child: Obx(() => myPropertiesWidget(
                                    cPropCtrl.mySuspendedProperties))),
                            const SizedBox(
                              height: 60,
                            )
                          ]);
                        }
                      }
                    }),

                ///hghjh
                // cPropCtrl.myProperties.value.isEmpty
                //     ? Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Image.asset('assets/images/empty.PNG'),
                //           TextStyles.richTexts(
                //               decoration: TextDecoration.underline,
                //               onPress1: () => Get.offNamed(RouteStr.mobileCreateProperty),
                //               size: 14,
                //               text1: 'You don\'t have any property listed.\n',
                //               centerText: true,
                //               text2: 'Create a listing')
                //         ],
                //       )
                //     : myPropertiesWidget(cPropCtrl.myProperties.value),
                ///ghjhg
                // cPropCtrl.myPublishedProperties.value.isEmpty
                //     ? Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Image.asset('assets/images/empty.PNG'),
                //           TextStyles.richTexts(
                //               decoration: TextDecoration.underline,
                //               onPress1: () => Get.offNamed(RouteStr.mobileCreateProperty),
                //               size: 14,
                //               text1: 'You don\'t have any property listed.\n',
                //               text2: 'Create a listing',
                //               centerText: true,
                //               text3: '',
                //               text4: '')
                //         ],
                //       )
                //     : myPropertiesWidget(cPropCtrl.myPublishedProperties.value),
                ///ghjhg
                // cPropCtrl.myDraftProperties.value.isEmpty
                //     ? Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Image.asset('assets/images/empty.PNG'),
                //           TextStyles.richTexts(
                //               decoration: TextDecoration.underline,
                //               onPress1: () => Get.offNamed(RouteStr.mobileCreateProperty),
                //               size: 14,
                //               text1: 'You don\'t have any property listed. \n',
                //               centerText: true,
                //               text2: 'Create a listing',
                //               text3: '',
                //               text4: '')
                //         ],
                //       )
                //     : myPropertiesWidget(cPropCtrl.myDraftProperties.value),
                ///ghjhg
                // cPropCtrl.mySoldProperties.value.isEmpty
                //     ? Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Image.asset('assets/images/empty.PNG'),
                //           TextStyles.richTexts(
                //             decoration: TextDecoration.underline,
                //             onPress1: () => Get.offNamed(RouteStr.mobileCreateProperty),
                //             size: 14,
                //             centerText: true,
                //             text1: 'You don\'t have any property listed.\n',
                //             text2: 'Create a listing',
                //           )
                //         ],
                //       )
                //     : myPropertiesWidget(cPropCtrl.mySoldProperties.value),
                ///ghjhg
                // cPropCtrl.mySuspendedProperties.value.isEmpty
                //     ? Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Image.asset('assets/images/empty.PNG'),
                //           TextStyles.richTexts(
                //               decoration: TextDecoration.underline,
                //               onPress1: () => Get.offNamed(RouteStr.mobileCreateProperty),
                //               size: 14,
                //               centerText: true,
                //               text1: 'You don\'t have any property listed.\n',
                //               text2: 'Create a listing',
                //               text3: '',
                //               text4: '')
                //         ],
                //       )
                //     : myPropertiesWidget(cPropCtrl.mySuspendedProperties.value),
                ///ghjhg
              ],
            ),
          ),
          Obx(() {
            return (cPropCtrl.myProperties.isNotEmpty)
                ? Positioned(
                    bottom: 0, left: 0, right: 0, child: paginationController())
                : const SizedBox.shrink();
          })
        ],
      ),
    );
  }

  Widget paginationController() {
    switch (index) {
      case 0:
        return (totalAllPropertypage > 1)
            ? Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: NumberPaginator(
                        numberPages: totalAllPropertypage,
                        onPageChange: (int index) {
                          //print(index+1);
                          setState(() {
                            allPropertySinglePage = index+1;

                            cPropCtrl.getAllMyProperties(allPropertySinglePage);
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
              )
            : const SizedBox.shrink();

      case 1:
        return (totalPublishedPropertypage > 1)
            ? Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: NumberPaginator(
                        numberPages: totalPublishedPropertypage,
                        onPageChange: (int index) {
                          setState(() {
                            publishedPropertySinglePage = index+1;

                            cPropCtrl.getAllPublishedProperties(
                                publishedPropertySinglePage);
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
              )
            : const SizedBox.shrink();

      case 2:
        return (totalDraftPropertypage > 1)
            ? Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: NumberPaginator(
                        numberPages: totalDraftPropertypage,
                        onPageChange: (int index) {
                          setState(() {
                            draftPropertySinglePage = index+1;

                            cPropCtrl
                                .getAllDraftProperties(draftPropertySinglePage);
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
              )
            : const SizedBox.shrink();

      case 3:
        return (totalSoldPropertypage > 1)
            ? Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: NumberPaginator(
                        numberPages: totalSoldPropertypage,
                        onPageChange: (int index) {
                          setState(() {
                            soldPropertySinglePage = index+1;

                            cPropCtrl
                                .getAllSoldProperties(soldPropertySinglePage);
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
              )
            : const SizedBox.shrink();

      case 4:
        return (totalSuspendedPropertypage > 1)
            ? Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: NumberPaginator(
                        numberPages: totalSuspendedPropertypage,
                        onPageChange: (int index) {
                          setState(() {
                            suspendedPropertySinglePage = index+1;

                            cPropCtrl.getAllSuspendedProperties(
                                suspendedPropertySinglePage);
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
                ))
            : const SizedBox.shrink();
    }

    return const SizedBox.shrink();
  }

  myPropertiesWidget(List<Property> properties) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: properties.length,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
        itemBuilder: ((context, index) {
          Property property = properties[index];

          String image;
          List<Media> images = property.media ?? [];
          if (images.isEmpty) {
            image = '';
          } else {
            image = property.media![0].media!;
          }

          return GestureDetector(
            onTap: () {
              cPropCtrl.showMyPropertyMenu.value = false;
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => Single_Property(
              //           property_id: property.id ?? 'OTQ1NTgwMzY3NDU1ODAw',
              //           property_tiitle: property.title ?? '',
              //         )));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Material(
                  elevation: 3,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, left: 8, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  height: 55,
                                  width: 55,
                                  fadeInDuration: const Duration(seconds: 1),
                                  fadeInCurve: Curves.easeInCirc,
                                  placeholder: defaultImage,
                                  image: propertyImgPath + image,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) =>
                                          Image.asset(
                                    defaultImage,
                                    height: 55,
                                    width: 55,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LimitedBox(
                                    maxWidth: Get.width * 0.6,
                                    child: CustomText(
                                      text: property.title ?? '',
                                      color: Colors.black,
                                      weight: FontWeight.bold,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          color: Pallet.secondaryColor,
                                          size: 16),
                                      const SizedBox(width: 6),
                                      LimitedBox(
                                        maxWidth: Get.width * 0.6,
                                        child: Text(
                                            '${property.location?.address ?? property.description}, ${property.location?.city ?? ''}, ${property.location?.state ?? ''}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  CustomText(
                                      color: Pallet.secondaryColor,
                                      text: Utils.amount(property.price ?? 0),
                                      weight: FontWeight.bold,
                                      size: 14),
                                ]),
                          ],
                        ),
                      ),
                      property.publishState == PublishedState.suspended
                          ? const SizedBox.shrink()
                          : Positioned(
                              top: -3,
                              right: -4,
                              child: InkWell(
                                onTap: () {
                                  cPropCtrl.showMyPropertyMenu.value = true;
                                  cPropCtrl.showMyPropertyMenuIndex.value =
                                      index;
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 3),
                                  child: Icon(Icons.more_vert),
                                ),
                              ),
                            ),
                      Obx(
                        () => Visibility(
                          visible: cPropCtrl.showMyPropertyMenu.value &&
                              cPropCtrl.showMyPropertyMenuIndex.value == index,
                          child: Positioned(
                            top: 4,
                            right: 24,
                            child: Material(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    property.publishState ==
                                            PublishedState.publish
                                        ? propertyAction(
                                            text: 'Edit Property',
                                            icon: Icons
                                                .mode_edit_outline_outlined,
                                            onTap: () {
                                              cPropCtrl.completeDraftProperty(
                                                  property);
                                              //EditCtrl.image8Lists.value.clear();
                                            },
                                          )
                                        : const SizedBox.shrink(),
                                    property.publishState ==
                                            PublishedState.publish
                                        ? propertyAction(
                                            text: 'Mark Sold',
                                            icon: Icons.sell_outlined,
                                            onTap: () =>
                                                cPropCtrl.changePublishState(
                                                    property: property,
                                                    state: PublishedState.sold),
                                          )
                                        : const SizedBox.shrink(),
                                    property.publishState == PublishedState.sold
                                        ? propertyAction(
                                            text: 'Republish Property',
                                            icon: Icons.published_with_changes,
                                            onTap: () =>
                                                cPropCtrl.changePublishState(
                                                    property: property,
                                                    state:
                                                        PublishedState.publish),
                                          )
                                        : const SizedBox.shrink(),
                                    property.publishState ==
                                            PublishedState.draft
                                        ? propertyAction(
                                            text: 'Edit Property',
                                            icon: Icons
                                                .mode_edit_outline_outlined,
                                            onTap: () {
                                              //EditCtrl.image8Lists.value.clear();
                                              cPropCtrl.completeDraftProperty(
                                                  property);
                                            },
                                          )
                                        : const SizedBox.shrink(),
                                    property.publishState ==
                                            PublishedState.draft
                                        ? propertyAction(
                                            text: 'Delete Property',
                                            color: Colors.red,
                                            icon: Icons.delete_outline,
                                            onTap: () =>
                                                cPropCtrl.changePublishState(
                                                    property: property,
                                                    state:
                                                        PublishedState.delete),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          width: 3,
                          height: 100,
                          decoration: BoxDecoration(
                              color:
                                  PublishedState.colors[property.publishState],
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(2),
                                  topLeft: Radius.circular(2))),
                        ),
                      ),
                    ],
                  )),
            ),
          );
        }));
  }

  propertyAction(
      {required String text,
      required IconData icon,
      Color? color,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 8, 48, 8.0),
        child: Row(
          children: [
            Icon(icon, size: 14),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color ?? Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
