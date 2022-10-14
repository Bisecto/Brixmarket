import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/models/property_model.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controllers/edit_controller.dart';
import '../../controllers/instance.dart';
import '../../core/app.dart';
import '../../core/preloader.dart';
import '../../models/media_model.dart';
import '../../res/lists.dart';
import '../../utils/utils.dart';
import '../widgets/drop_down.dart';
import '../widgets/footer_page.dart';
import '../widgets/main_drawer.dart';
import '../widgets/mobile_appbar.dart';
import '../widgets/properties_grid.dart';
import '../widgets/save_property_icon.dart';
import '../widgets/web_hero_seach.dart';
import 'mobile/explore_filter_page.dart';

class PropertiesPage extends StatelessWidget {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  PropertiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainPadding = Get.width < 480
        ? Get.width * 0.05
        : Get.width * 0.06 + Get.width * 0.009;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        key: homeScaffoldKey,
        backgroundColor: Pallet.primaryBackgroundLight,
        drawer: buildDrawer(context),
        appBar: appBarWeb(homeScaffoldKey),
        body: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              color: Pallet.primaryBackgroundLight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/hero1.jpg'))),
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
                                InkWell(
                                  onTap: () => propCtrl.setAllPropertiesWeb(),
                                  child: CustomText(
                                    text: 'Search for your property here',
                                    size: isMobile()
                                        ? 20
                                        : isTablet()
                                            ? 28
                                            : 48,
                                    color: Colors.white,
                                    weight: FontWeight.bold,
                                  ),
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
                    const SizedBox(height: 48),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: mainPadding),
                      child: Row(children: [
                        isMobile()
                            ? const SizedBox.shrink()
                            : Obx(() {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        homeCtrl.toggleList();
                                      },
                                      child: Icon(
                                        Icons.list_alt,
                                        size: 36,
                                        color: homeCtrl.isList.value
                                            ? Pallet.secondaryColor
                                            : Colors.grey,
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
                                        color: homeCtrl.isList.value
                                            ? Colors.grey
                                            : Pallet.secondaryColor,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        isMobile()
                            ? const SizedBox.shrink()
                            : const SizedBox(width: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 16),
                          child: Obx(() => Text(
                              //'${propCtrl.searchResultCount.value} result Found',
                            'Your filtered result',
                              style: TextStyle(
                                  fontSize: isMobile()
                                      ? 16
                                      : isDesktop()
                                          ? 18
                                          : 20,
                                  fontWeight: FontWeight.w600))),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: mainPadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Obx(() => Column(
                                  children: [
                                    Visibility(
                                        visible:
                                            propCtrl.refreshCount.value == -1,
                                        child: Text(propCtrl.refreshCount.value
                                            .toString())),
                                    FutureBuilder(
                                        future: propCtrl.allPropertiesWeb.value,
                                        builder: (context, AsyncSnapshot snap) {
                                          List<Property> properties =
                                              snap.data ?? [];
                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500),
                                              () => propCtrl.searchResultCount
                                                  .value = properties.length);
                                          return snap.connectionState ==
                                                  ConnectionState.waiting
                                              ? SizedBox(
                                                  height: 520,
                                                  child: Center(
                                                      child: Preloader
                                                          .loadingWidget()),
                                                )
                                              : Obx(
                                                  () => homeCtrl.isList.value &&
                                                          !isTabletDown()
                                                      ? buildListContainer(
                                                          properties:
                                                              properties)
                                                      : PropertiesGrade(
                                                          properties:
                                                              properties),
                                                );
                                        }),
                                  ],
                                )),
                          ),
                          isNotDeskTop()
                              ? const SizedBox.shrink()
                              : const SizedBox(width: 24),
                          isNotDeskTop()
                              ? const SizedBox.shrink()
                              : Expanded(
                                  flex: 2,
                                  child: LayoutBuilder(
                                      builder: (context, constraints) {
                                    double maxWidth = constraints.maxWidth;
                                    return Container(
                                      width: maxWidth,
                                      // height: Get.height,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 24),
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
                                      child: Stack(children: [
                                        Column(
                                          children: [
                                            Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  width: maxWidth,
                                                  color: Colors.white,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: InkWell(
                                                    onTap: () {
                                                      propCtrl.clearFilter();
                                                    },
                                                    child: Container(
                                                      height: 48,
                                                      color:
                                                          Pallet.secondaryColor,
                                                      child: const Center(
                                                        child: CustomText(
                                                          color: Colors.white,
                                                          size: 16,
                                                          text: 'CLEAR FILTER',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                            const Text('Price',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: DropDown(
                                                    width: maxWidth * 0.4,
                                                    color: Colors.white10,
                                                    showLabel: false,
                                                    labelColor: Colors.black54,
                                                    controller:
                                                        EditCtrl.priceMin,
                                                    label: 'Min',
                                                    items: Lst.minFilterPrices,
                                                  ),
                                                ),
                                                const Text('to',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: DropDown(
                                                    width: maxWidth * 0.4,
                                                    color: Colors.white10,
                                                    showLabel: false,
                                                    controller:
                                                        EditCtrl.priceMax,
                                                    label: 'Max',
                                                    items: Lst.maxFilterPrices,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            const Text('Location',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 8),
                                              child: DropDown(
                                                width: maxWidth * 0.9,
                                                color: Colors.white10,
                                                showLabel: false,
                                                labelColor: Colors.black54,
                                                controller:
                                                    EditCtrl.filterState,
                                                label: 'State',
                                                items: Lst.ngStates,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 8),
                                              child: Obx(() => DropDown(
                                                    width: maxWidth * 0.9,
                                                    color: Colors.white10,
                                                    showLabel: false,
                                                    labelColor: Colors.black54,
                                                    controller:
                                                        EditCtrl.filterCity,
                                                    label: 'City/Town',
                                                    items: Lst.ngLGA[EditCtrl
                                                            .filterState
                                                            .value
                                                            .text] ??
                                                        [],
                                                  )),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                                            //   child: DropDown(
                                            //     width: maxWidth * 0.9,
                                            //     color: Colors.white10,
                                            //     showLabel: false,
                                            //     labelColor: Colors.black54,
                                            //     controller: EditCtrl.filterLandMark,
                                            //     label: 'Landmarks',
                                            //     items: Lst.ngLGA[Lst.ngStates[0]] ?? [],
                                            //   ),
                                            // ),
                                            Obx(
                                                () =>
                                                    propCtrl.showMoreFilter
                                                                .value ||
                                                            true
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              const SizedBox(
                                                                  height: 16),
                                                              const Text(
                                                                  'Category',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14)),
                                                              Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .spaceAround,
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .center,
                                                                children: [
                                                                  Obx(() =>
                                                                      filterBox(
                                                                        text:
                                                                            'Any',
                                                                        width: maxWidth *
                                                                            0.4,
                                                                        selected: EditCtrl
                                                                            .filterCategories
                                                                            .contains('Any'),
                                                                        onTap: () => propCtrl.toggleSelectedFilterBox(
                                                                            filter:
                                                                                'category',
                                                                            item:
                                                                                'Any'),
                                                                      )),
                                                                  ...Lst
                                                                      .propertyCategories
                                                                      .map((e) =>
                                                                          Obx(() =>
                                                                              filterBox(
                                                                                text: e,
                                                                                width: maxWidth * 0.4,
                                                                                selected: EditCtrl.filterCategories.contains(e),
                                                                                onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'category', item: e),
                                                                              )))
                                                                      .toList(),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 16),
                                                              const Text('Type',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14)),
                                                              Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .spaceAround,
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .center,
                                                                children: [
                                                                  Obx(() =>
                                                                      filterBox(
                                                                        text:
                                                                            'Any',
                                                                        width: maxWidth *
                                                                            0.4,
                                                                        selected: EditCtrl
                                                                            .filterTypes
                                                                            .contains('Any'),
                                                                        onTap: () => propCtrl.toggleSelectedFilterBox(
                                                                            filter:
                                                                                'type',
                                                                            item:
                                                                                'Any'),
                                                                      )),
                                                                  ...Lst
                                                                      .propertyTypes
                                                                      .map((e) =>
                                                                          Obx(() =>
                                                                              filterBox(
                                                                                text: e,
                                                                                width: maxWidth * 0.4,
                                                                                selected: EditCtrl.filterTypes.contains(e),
                                                                                onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'type', item: e),
                                                                              )))
                                                                      .toList(),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 16),
                                                              const Text(
                                                                  'Status',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14)),
                                                              Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .spaceAround,
                                                                crossAxisAlignment:
                                                                    WrapCrossAlignment
                                                                        .center,
                                                                children: [
                                                                  Obx(() =>
                                                                      filterBox(
                                                                        text:
                                                                            'Any',
                                                                        width: maxWidth *
                                                                            0.4,
                                                                        selected: EditCtrl
                                                                            .filterStatus
                                                                            .contains('Any'),
                                                                        onTap: () => propCtrl.toggleSelectedFilterBox(
                                                                            filter:
                                                                                'status',
                                                                            item:
                                                                                'Any'),
                                                                      )),
                                                                  ...Lst
                                                                      .propertyStatus
                                                                      .map((e) =>
                                                                          Obx(() =>
                                                                              filterBox(
                                                                                text: e,
                                                                                width: maxWidth * 0.4,
                                                                                selected: EditCtrl.filterStatus.contains(e),
                                                                                onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'status', item: e),
                                                                              )))
                                                                      .toList(),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 16),
                                                              // const Text(
                                                              //     'Amenities',
                                                              //     style: TextStyle(
                                                              //         fontWeight:
                                                              //             FontWeight
                                                              //                 .w600,
                                                              //         fontSize:
                                                              //             14)),
                                                              // const SizedBox(
                                                              //     height: 8),
                                                              // FutureBuilder(
                                                              //     future: cPropCtrl
                                                              //         .getAmenities(
                                                              //             all:
                                                              //                 true),
                                                              //     builder: (context,
                                                              //         AsyncSnapshot
                                                              //             snap) {
                                                              //       var amenities =
                                                              //           snap.data ??
                                                              //               [];
                                                              //       return Wrap(
                                                              //           alignment:
                                                              //               WrapAlignment.spaceAround,
                                                              //           children: [
                                                              //             SizedBox(
                                                              //               width:
                                                              //                   maxWidth * 0.4,
                                                              //               child:
                                                              //                   Row(
                                                              //                 children: [
                                                              //                   Obx(
                                                              //                     () => Checkbox(
                                                              //                       activeColor: Pallet.secondaryColor,
                                                              //                       checkColor: Colors.white,
                                                              //                       side: const BorderSide(color: Colors.black54),
                                                              //                       value: EditCtrl.filterAmenities.contains('Any'),
                                                              //                       onChanged: (state) {
                                                              //                         if (EditCtrl.filterAmenities.contains('Any') && EditCtrl.filterAmenities.isNotEmpty) {
                                                              //                           EditCtrl.filterAmenities.remove('Any');
                                                              //                         } else {
                                                              //                           if (EditCtrl.filterAmenities.isNotEmpty) {
                                                              //                             EditCtrl.filterAmenities.removeRange(0, EditCtrl.filterAmenities.length);
                                                              //                           }
                                                              //                           EditCtrl.filterAmenities.add('Any');
                                                              //                         }
                                                              //                         EditCtrl.filterAmenities.refresh();
                                                              //                       },
                                                              //                     ),
                                                              //                   ),
                                                              //                   const SizedBox(width: 10),
                                                              //                   const Expanded(child: Text('Any', style: TextStyle(fontSize: 16))),
                                                              //                 ],
                                                              //               ),
                                                              //             ),
                                                              //             ...(amenities as List)
                                                              //                 .map((e) => Container(
                                                              //                       width: maxWidth * 0.4,
                                                              //                       margin: const EdgeInsets.only(bottom: 8),
                                                              //                       child: Row(
                                                              //                         mainAxisSize: MainAxisSize.min,
                                                              //                         children: [
                                                              //                           Obx(
                                                              //                             () => Checkbox(
                                                              //                               activeColor: Pallet.secondaryColor,
                                                              //                               checkColor: Colors.white,
                                                              //                               side: const BorderSide(color: Colors.black54),
                                                              //                               value: EditCtrl.filterAmenities.contains(e['amenity']),
                                                              //                               onChanged: (state) {
                                                              //                                 if (EditCtrl.filterAmenities.contains(e['amenity'])) {
                                                              //                                   EditCtrl.filterAmenities.remove(e['amenity']);
                                                              //                                   if (EditCtrl.filterAmenities.isEmpty) {
                                                              //                                     EditCtrl.filterAmenities.add('Any');
                                                              //                                   }
                                                              //                                 } else {
                                                              //                                   if (EditCtrl.filterAmenities.contains('Any')) {
                                                              //                                     EditCtrl.filterAmenities.remove('Any');
                                                              //                                   }
                                                              //                                   EditCtrl.filterAmenities.add(e['amenity']);
                                                              //                                 }
                                                              //                                 EditCtrl.filterAmenities.refresh();
                                                              //                               },
                                                              //                             ),
                                                              //                           ),
                                                              //                           const SizedBox(width: 10),
                                                              //                           Expanded(child: Text(e['amenity'], style: const TextStyle(fontSize: 16))),
                                                              //                         ],
                                                              //                       ),
                                                              //                     ))
                                                              //                 .toList(),
                                                              //           ]);
                                                              //     }),
                                                              const SizedBox(
                                                                  height: 16),
                                                              //const Text('Rooms', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                                              // Row(
                                                              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              //   crossAxisAlignment: CrossAxisAlignment.center,
                                                              //   children: [
                                                              //     Padding(
                                                              //       padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                              //       child: DropDown(
                                                              //         width: maxWidth * 0.4,
                                                              //         color: Colors.white10,
                                                              //         showLabel: false,
                                                              //         labelColor: Colors.black54,
                                                              //         controller: EditCtrl.roomMin,
                                                              //         label: 'Min',
                                                              //         items: const ['1', '2', '3'],
                                                              //       ),
                                                              //     ),
                                                              //     const Text('to', style: TextStyle(fontWeight: FontWeight.w600)),
                                                              //     Padding(
                                                              //       padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                              //       child: DropDown(
                                                              //         width: maxWidth * 0.4,
                                                              //         color: Colors.white10,
                                                              //         showLabel: false,
                                                              //         controller: EditCtrl.roomMax,
                                                              //         label: 'Max',
                                                              //         items: const ['1', '2', '3'],
                                                              //       ),
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                              //const SizedBox(height: 16),
                                                              //const Text('Baths', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                                              // Row(
                                                              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              //   crossAxisAlignment: CrossAxisAlignment.center,
                                                              //   children: [
                                                              //     Padding(
                                                              //       padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                              //       child: DropDown(
                                                              //         width: maxWidth * 0.4,
                                                              //         color: Colors.white10,
                                                              //         showLabel: false,
                                                              //         labelColor: Colors.black54,
                                                              //         controller: EditCtrl.bathsMin,
                                                              //         label: 'Min',
                                                              //         items: const ['1', '2', '3'],
                                                              //       ),
                                                              //     ),
                                                              //     const Text('to', style: TextStyle(fontWeight: FontWeight.w600)),
                                                              //     Padding(
                                                              //       padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                              //       child: DropDown(
                                                              //         width: maxWidth * 0.4,
                                                              //         color: Colors.white10,
                                                              //         showLabel: false,
                                                              //         controller: EditCtrl.bathsMax,
                                                              //         label: 'Max',
                                                              //         items: const ['1', '2', '3'],
                                                              //       ),
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                            ],
                                                          )
                                                        : const SizedBox
                                                            .shrink()),
                                            const SizedBox(height: 24),
                                            // InkWell(
                                            //   onTap: () => propCtrl.showMoreFilter.value = propCtrl.showMoreFilter.value == true ? false : true,
                                            //   child: Row(
                                            //     mainAxisAlignment: MainAxisAlignment.center,
                                            //     children: [
                                            //       Obx(() => CustomText(
                                            //             color: Pallet.secondaryColor,
                                            //             size: 16,
                                            //             text: propCtrl.showMoreFilter.value ? 'Less filter' : 'More filters',
                                            //           )),
                                            //       const SizedBox(width: 12),
                                            //       Obx(() => Icon(
                                            //             propCtrl.showMoreFilter.value ? Icons.expand_less : Icons.expand_more,
                                            //             color: Pallet.secondaryColor,
                                            //             size: 24,
                                            //           ))
                                            //     ],
                                            //   ),
                                            // ),
                                            const SizedBox(height: 62),
                                          ],
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            child: Container(
                                              width: maxWidth,
                                              color: Colors.white,
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: InkWell(
                                                onTap: () {
                                                  propCtrl.showLargeFilerBox
                                                      .value = true;
                                                  propCtrl.setAllPropertiesWeb(
                                                      filter: true);
                                                },
                                                child: Container(
                                                  height: 48,
                                                  color: Pallet.secondaryColor,
                                                  child: const Center(
                                                    child: CustomText(
                                                      color: Colors.white,
                                                      size: 16,
                                                      text: 'APPLY FILTER',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ]),
                                    );
                                  }), //Text(''), //FilterExplorePage(isWeb: true),
                                ),
                        ],
                      ),
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
                      margin: EdgeInsets.only(
                          left: isMobile() ? 0 : Get.width - 360),
                      child: const FilterExplorePage(isWeb: true),
                    )
                  : const SizedBox.shrink(),
            )
          ],
        ),
      );
    });
  }

  Widget buildListContainer({required List<Property> properties}) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: properties.length,
        itemBuilder: (_, i) {
          int iFeature = 0;
          Property property = properties[i];
          String image =
              property.media!.isNotEmpty ? property.media![0].media! : '';
          List<Media> images = property.media ?? [];
          print(EditCtrl.webSearchKeyWord.value.text);
          if (EditCtrl.webSearchKeyWord.value.text.trim().isNotEmpty) {
            if (property.title!.trim().toLowerCase().contains(
                EditCtrl.webSearchKeyWord.value.text.trim().toLowerCase())) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Material(
                  color: Colors.white,
                  elevation: 5,
                  type: MaterialType.card,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 0, 3),
                              height: 268,
                              width: Get.width * 0.4,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(propertyImgPath + image),
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 0, left: 10, bottom: 10),
                              height: 68,
                              child: ListView.builder(
                                itemCount:
                                    images.length > 5 ? 5 : images.length,
                                reverse: false,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: (index == 4)
                                        ? Stack(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5),
                                                color: Colors.white,
                                                height: 80,
                                                // width: 69,
                                                child: Image.network(
                                                  propertyImgPath +
                                                      images[index].media!,
                                                  height: 80,
                                                  width: Get.width * 0.4 * 0.15,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              images.length > 5
                                                  ? Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 5, top: 5),
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                      height: 80,
                                                      width: 72,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CustomText(
                                                                text: (images.length >
                                                                            5
                                                                        ? (images.length - 5).toString() +
                                                                            ' images'
                                                                        : '')
                                                                    .toString(),
                                                                color: Colors
                                                                    .white,
                                                                size: 10),
                                                            const SizedBox(
                                                                width: 5),
                                                            const Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color: Colors
                                                                    .white,
                                                                size: 12),
                                                          ]),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(
                                                right: Get.width * 0.4 * 0.01,
                                                top: 5),
                                            color: Colors.white,
                                            height: 80,
                                            width: Get.width * 0.4 * 0.16,
                                            child: Image.network(
                                              propertyImgPath +
                                                  images[index].media!,
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
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 32,
                                        width: 120,
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Center(
                                          child: CustomText(
                                              color: const Color(0xFF308b85),
                                              text:
                                                  property.type!.toUpperCase(),
                                              weight: FontWeight.w500,
                                              size: 14),
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
                                              size: 14),
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
                                                  color: Color.fromARGB(
                                                      255, 247, 241, 241),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  20))),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 13.0),
                                                    child: Icon(
                                                      Icons.verified,
                                                      size: 18,
                                                      color: Colors.green[700],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  const CustomText(
                                                      color: Colors.black54,
                                                      text: 'verified',
                                                      weight: FontWeight.w500,
                                                      size: 16),
                                                ],
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              CustomText(
                                  color: Colors.black,
                                  text: property.title,
                                  weight: FontWeight.w800,
                                  size: 18),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Pallet.secondaryColor, size: 18),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: CustomText(
                                        color: Colors.black,
                                        text:
                                            '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                        weight: FontWeight.w200,
                                        size: 16),
                                  ),
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
                                              const Icon(Icons.bed,
                                                  color: Colors.black54,
                                                  size: 18),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                  color: Colors.black54,
                                                  text: feature.featureValue,
                                                  weight: FontWeight.w200,
                                                  size: 16),
                                              const SizedBox(width: 12),
                                            ],
                                          );
                                  }).toList(),
                                ],
                              ),
                              const SizedBox(height: 36),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      RatingBarIndicator(
                                        rating: property.averageRating ?? 0,
                                        unratedColor: Colors.black26,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.yellow[900],
                                          size: 18,
                                        ),
                                        itemCount: 5,
                                        itemSize: 18.0,
                                        direction: Axis.horizontal,
                                      ),
                                      const SizedBox(width: 4),
                                      CustomText(
                                        color: Colors.black,
                                        text: (property.numberOfRatingUsers ??
                                                'No Review')
                                            .toString(),
                                        weight: FontWeight.w200,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  Obx(() => SavePropertyIconText(
                                      property: property,
                                      user: homeCtrl.user.value,
                                      state: homeCtrl.savingProperty.value)),
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(right: 30),
                                  child: const Divider()),
                              const SizedBox(height: 5),
                              const CustomText(
                                  color: Colors.black,
                                  text: 'Price',
                                  weight: FontWeight.w100,
                                  size: 14),
                              const SizedBox(height: 4),
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
                                          size: 20),
                                      const SizedBox(width: 3),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: CustomText(
                                          color: Colors.black.withOpacity(0.4),
                                          text: property.priceDuration!
                                                      .substring(0, 3) ==
                                                  'Per'
                                              ? property.priceDuration!
                                                  .toUpperCase()
                                              : '',
                                          weight: FontWeight.w500,
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        homeCtrl.viewSingleProperty(property),
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
                ),
              );
            } else {
              return Container();
            }
          } else {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Material(
                color: Colors.white,
                elevation: 5,
                type: MaterialType.card,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 0, 3),
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
                            padding: const EdgeInsets.only(
                                top: 0, left: 10, bottom: 10),
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
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              color: Colors.white,
                                              height: 80,
                                              // width: 69,
                                              child: Image.network(
                                                propertyImgPath +
                                                    images[index].media!,
                                                height: 80,
                                                width: Get.width * 0.4 * 0.15,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            images.length > 5
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5, top: 5),
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    height: 80,
                                                    width: 72,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CustomText(
                                                              text: (images.length >
                                                                          5
                                                                      ? (images.length - 5)
                                                                              .toString() +
                                                                          ' images'
                                                                      : '')
                                                                  .toString(),
                                                              color:
                                                                  Colors.white,
                                                              size: 10),
                                                          const SizedBox(
                                                              width: 5),
                                                          const Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              color:
                                                                  Colors.white,
                                                              size: 12),
                                                        ]),
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(
                                              right: Get.width * 0.4 * 0.01,
                                              top: 5),
                                          color: Colors.white,
                                          height: 80,
                                          width: Get.width * 0.4 * 0.16,
                                          child: Image.network(
                                            propertyImgPath +
                                                images[index].media!,
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
                        padding: const EdgeInsets.only(
                            top: 10, left: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
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
                                        child: CustomText(
                                            color: const Color(0xFF308b85),
                                            text: property.type!.toUpperCase(),
                                            weight: FontWeight.w500,
                                            size: 14),
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
                                            text:
                                                property.status!.toUpperCase(),
                                            weight: FontWeight.w500,
                                            size: 14),
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
                                                color: Color.fromARGB(
                                                    255, 247, 241, 241),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20))),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 13.0),
                                                  child: Icon(
                                                    Icons.verified,
                                                    size: 18,
                                                    color: Colors.green[700],
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const CustomText(
                                                    color: Colors.black54,
                                                    text: 'verified',
                                                    weight: FontWeight.w500,
                                                    size: 16),
                                              ],
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomText(
                                color: Colors.black,
                                text: property.title,
                                weight: FontWeight.w800,
                                size: 18),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Pallet.secondaryColor, size: 18),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: CustomText(
                                      color: Colors.black,
                                      text:
                                          '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                      weight: FontWeight.w200,
                                      size: 16),
                                ),
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
                                            const Icon(Icons.bed,
                                                color: Colors.black54,
                                                size: 18),
                                            const SizedBox(width: 5),
                                            CustomText(
                                                color: Colors.black54,
                                                text: feature.featureValue,
                                                weight: FontWeight.w200,
                                                size: 16),
                                            const SizedBox(width: 12),
                                          ],
                                        );
                                }).toList(),
                              ],
                            ),
                            const SizedBox(height: 36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBarIndicator(
                                      rating: property.averageRating ?? 0,
                                      unratedColor: Colors.black26,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.yellow[900],
                                        size: 18,
                                      ),
                                      itemCount: 5,
                                      itemSize: 18.0,
                                      direction: Axis.horizontal,
                                    ),
                                    const SizedBox(width: 4),
                                    CustomText(
                                      color: Colors.black,
                                      text: (property.numberOfRatingUsers ??
                                              'No Review')
                                          .toString(),
                                      weight: FontWeight.w200,
                                      size: 16,
                                    ),
                                  ],
                                ),
                                Obx(() => SavePropertyIconText(
                                    property: property,
                                    user: homeCtrl.user.value,
                                    state: homeCtrl.savingProperty.value)),
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 30),
                                child: const Divider()),
                            const SizedBox(height: 5),
                            const CustomText(
                                color: Colors.black,
                                text: 'Price',
                                weight: FontWeight.w100,
                                size: 14),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                        color: Pallet.secondaryColor,
                                        text: Utils.amount(property.price!),
                                        weight: FontWeight.w700,
                                        size: 20),
                                    const SizedBox(width: 3),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: CustomText(
                                        color: Colors.black.withOpacity(0.4),
                                        text: property.priceDuration!
                                                    .substring(0, 3) ==
                                                'Per'
                                            ? property.priceDuration!
                                                .toUpperCase()
                                            : '',
                                        weight: FontWeight.w500,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () =>
                                      homeCtrl.viewSingleProperty(property),
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
              ),
            );
          }
        });
  }
//
// Widget buildGridViewContainer({double? constraints}) {
//   List<Property> properties = propCtrl.allProperties;
//   return Obx(() {
//     return GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         // physics: const BouncingScrollPhysics(),
//         itemCount: propCtrl.allProperties.value.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: isMobile()
//               ? 1
//               : isTablet()
//                   ? 2
//                   : 2,
//           mainAxisExtent: 560,
//         ),
//         itemBuilder: (_, i) {
//           int iFeature = 0;
//           Property property = properties[i];
//           String image = property.media!.isNotEmpty ? property.media![0].media! : '';
//           List<Media> images = property.media ?? [];
//           return Container(
//             margin: EdgeInsets.only(left: i % 2 == 0 || isMobile() ? 0 : 12, right: i % 2 == 0 && !isMobile() ? 12 : 0, bottom: 24),
//             decoration: const BoxDecoration(
//               color: Pallet.homeBackground,
//             ),
//             child: InkWell(
//               onTap: () => homeCtrl.viewSingleProperty(property),
//               child: Material(
//                 elevation: 2,
//                 borderRadius: BorderRadius.circular(4),
//                 color: Colors.white,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Image.network(
//                       propertyImgPath + image,
//                       height: 240,
//                       width: double.maxFinite,
//                       fit: BoxFit.cover,
//                     ),
//                     Container(
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(12.0, 16, 12, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Container(
//                                       height: 28,
//                                       width: 96,
//                                       child: Center(
//                                         child: CustomText(color: const Color(0xFF308b85), text: property.type!.toUpperCase(), weight: FontWeight.w500, size: 14),
//                                       ),
//                                       color: const Color(0xFFebfcfb),
//                                     ),
//                                     Container(
//                                       height: 28,
//                                       width: 68,
//                                       margin: const EdgeInsets.only(left: 8),
//                                       child: Center(
//                                         child: CustomText(color: Colors.white, text: property.status!.toUpperCase(), weight: FontWeight.w500, size: 12),
//                                       ),
//                                       color: Pallet.secondaryColor,
//                                     )
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 true
//                                     ? const SizedBox.shrink()
//                                     : Row(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           RatingBarIndicator(
//                                             rating: property.averageRating ?? 5,
//                                             unratedColor: Pallet.whiteColor,
//                                             itemBuilder: (context, index) => Icon(
//                                               Icons.star,
//                                               color: property.averageRating == null ? Colors.black26 : Colors.yellow[900],
//                                               size: 16,
//                                             ),
//                                             itemCount: 5,
//                                             itemSize: 16.0,
//                                             direction: Axis.horizontal,
//                                           ),
//                                           const SizedBox(width: 4),
//                                           CustomText(
//                                               color: Colors.black, text: (property.numberOfRatingUsers ?? 'No Review').toString(), weight: FontWeight.w200, size: 12),
//                                         ],
//                                       ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             CustomText(color: Colors.black, text: property.title, weight: FontWeight.w800, size: 16),
//                             const SizedBox(
//                               height: 12,
//                             ),
//                             Row(
//                               children: [
//                                 const Icon(Icons.location_on, color: Pallet.secondaryColor, size: 18),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: CustomText(
//                                       color: Colors.black,
//                                       text: '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
//                                       weight: FontWeight.w200,
//                                       maxLines: 1,
//                                       size: 14),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 36,
//                             ),
//                             FittedBox(
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ...property.features!.map((feature) {
//                                     iFeature++;
//                                     return iFeature >= 4
//                                         ? const SizedBox.shrink()
//                                         : Row(
//                                             children: [
//                                               const Icon(
//                                                 Icons.bed,
//                                                 color: Colors.black54,
//                                                 size: 12,
//                                               ),
//                                               const SizedBox(width: 5),
//                                               CustomText(color: Colors.black54, text: feature.featureValue, weight: FontWeight.w200, size: 13),
//                                               const SizedBox(width: 8),
//                                             ],
//                                           );
//                                   }).toList(),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 12,
//                             ),
//                             const Divider(),
//                             const CustomText(color: Colors.black, text: 'Price', weight: FontWeight.w100, size: 12),
//                             const SizedBox(
//                               height: 6,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   children: [
//                                     CustomText(color: Pallet.secondaryColor, text: Utils.amount(property.price!), weight: FontWeight.w700, size: 20),
//                                     const SizedBox(
//                                       width: 3,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: CustomText(
//                                         color: Colors.black.withOpacity(0.4),
//                                         text: property.priceDuration!.substring(0, 3) == 'Per' ? property.priceDuration!.toUpperCase() : '',
//                                         weight: FontWeight.w500,
//                                         size: 14,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Obx(() => SavePropertyIcon(property: property, user: homeCtrl.user.value, state: homeCtrl.savingProperty.value)),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   });
// }
//
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
