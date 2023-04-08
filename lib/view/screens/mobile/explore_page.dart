import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:brixmarket/view/widgets/drop_down.dart';
import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../controllers/mobile_app_controllers/homepage_controller.dart';
import '../../../core/app.dart';
import '../../../core/preloader.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/material_search_bar/src/widgets/mobile_app_widgets/property_container.dart';
import 'explore_filter_page.dart';
import 'package:brixmarket/models/filter_property_model.dart' as filter;
import 'package:brixmarket/adapter/property_adapter.dart';
import 'package:brixmarket/controllers/create_property_controller.dart';
import 'package:brixmarket/res/lists.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:brixmarket/models/single_property_model.dart' as sing;
import '../../../controllers/edit_controller.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  ScrollController _controller = ScrollController();

  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  StreamController<filter.FilterModel> _filterStreamController =
      StreamController.broadcast();

  getfilterProperty(int page) async {
    PropertyApi propertyApi = PropertyApi();
    await propertyApi.getProperty(page);
    setState(() {
      _filterStreamController = propertyApi.getfilterProperty;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    //_filterStreamController.di
  }

  int page = 1;
  @override
  void initState() {
    getfilterProperty(page);
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

  bool isLoading = false;

  // Widget Pages({int page = 1}) {
  //   return ;
  // }

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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 14, 0, 14),
              child: Image.asset(
                'assets/images/brix-logo-light-light.png',
                height: 30,
                width: 30,
              ),
            ),
          ),
          title: const CustomText(
            color: Colors.white,
            size: 18,
            weight: FontWeight.w600,
            text: 'Explore Properties',
          ),
          // actions: [
          //   GestureDetector(
          //     onTap: () {
          //       showMaterialModalBottomSheet(
          //         context: Get.context!,
          //         builder: (context) => SingleChildScrollView(
          //           controller: ModalScrollController.of(context),
          //           child: Container(
          //             height: MediaQuery.of(context).size.height - 100,
          //             child: LayoutBuilder(builder: (context, constraints) {
          //               double maxWidth = constraints.maxWidth;
          //               return SizedBox(
          //                 width: maxWidth,
          //                 height: constraints.maxHeight,
          //                 child: Stack(children: [
          //                   ListView(
          //                     shrinkWrap: true,
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: 12, vertical: 24),
          //                     children: [
          //                       const Text('Price',
          //                           style: TextStyle(
          //                               fontWeight: FontWeight.w600,
          //                               fontSize: 14)),
          //                       Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceAround,
          //                         crossAxisAlignment: CrossAxisAlignment.center,
          //                         children: [
          //                           Padding(
          //                             padding: const EdgeInsets.symmetric(
          //                                 vertical: 8.0),
          //                             child: DropDown(
          //                               width: maxWidth * 0.4,
          //                               color: Colors.white10,
          //                               showLabel: false,
          //                               labelColor: Colors.black54,
          //                               controller: EditCtrl.priceMin,
          //                               label: 'Min',
          //                               items: Lst.minFilterPrices,
          //                             ),
          //                           ),
          //                           const Text('to',
          //                               style: TextStyle(
          //                                   fontWeight: FontWeight.w600)),
          //                           Padding(
          //                             padding: const EdgeInsets.symmetric(
          //                                 vertical: 8.0),
          //                             child: DropDown(
          //                               width: maxWidth * 0.4,
          //                               color: Colors.white10,
          //                               showLabel: false,
          //                               controller: EditCtrl.priceMax,
          //                               label: 'Max',
          //                               items: Lst.maxFilterPrices,
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                       const SizedBox(height: 16),
          //                       const Text('Location',
          //                           style: TextStyle(
          //                               fontWeight: FontWeight.w600,
          //                               fontSize: 14)),
          //                       Padding(
          //                         padding: const EdgeInsets.symmetric(
          //                             vertical: 8.0, horizontal: 8),
          //                         child: DropDown(
          //                           width: maxWidth * 0.9,
          //                           color: Colors.white10,
          //                           showLabel: false,
          //                           labelColor: Colors.black54,
          //                           controller: EditCtrl.filterState,
          //                           label: 'State',
          //                           items: Lst.ngStates,
          //                         ),
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.symmetric(
          //                             vertical: 8.0, horizontal: 8),
          //                         child: Obx(() => DropDown(
          //                               width: maxWidth * 0.9,
          //                               color: Colors.white10,
          //                               showLabel: false,
          //                               labelColor: Colors.black54,
          //                               controller: EditCtrl.filterCity,
          //                               label: 'City/Town',
          //                               items: Lst.ngLGA[EditCtrl
          //                                       .filterState.value.text] ??
          //                                   [],
          //                             )),
          //                       ),
          //                       // Padding(
          //                       //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          //                       //   child: DropDown(
          //                       //     width: maxWidth * 0.9,
          //                       //     color: Colors.white10,
          //                       //     showLabel: false,
          //                       //     labelColor: Colors.black54,
          //                       //     controller: EditCtrl.filterLandMark,
          //                       //     label: 'Landmarks',
          //                       //     items: Lst.ngLGA[Lst.ngStates[0]] ?? [],
          //                       //   ),
          //                       // ),
          //                       Obx(() => propCtrl.showMoreFilter.value
          //                           ? Column(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.stretch,
          //                               children: [
          //                                 const SizedBox(height: 16),
          //                                 const Text('Category',
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.w600,
          //                                         fontSize: 14)),
          //                                 Wrap(
          //                                   alignment:
          //                                       WrapAlignment.spaceAround,
          //                                   crossAxisAlignment:
          //                                       WrapCrossAlignment.center,
          //                                   children: [
          //                                     Obx(() => filterBox(
          //                                           text: 'Any',
          //                                           width: maxWidth * 0.4,
          //                                           selected: EditCtrl
          //                                               .filterCategories
          //                                               .contains('Any'),
          //                                           onTap: () => propCtrl
          //                                               .toggleSelectedFilterBox(
          //                                                   filter: 'category',
          //                                                   item: 'Any'),
          //                                         )),
          //                                     ...Lst.propertyCategories
          //                                         .map((e) =>
          //                                             Obx(() => filterBox(
          //                                                   text: e,
          //                                                   width:
          //                                                       maxWidth * 0.4,
          //                                                   selected: EditCtrl
          //                                                       .filterCategories
          //                                                       .contains(e),
          //                                                   onTap: () => propCtrl
          //                                                       .toggleSelectedFilterBox(
          //                                                           filter:
          //                                                               'category',
          //                                                           item: e),
          //                                                 )))
          //                                         .toList(),
          //                                   ],
          //                                 ),
          //                                 const SizedBox(height: 16),
          //                                 const Text('Type',
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.w600,
          //                                         fontSize: 14)),
          //                                 Wrap(
          //                                   alignment:
          //                                       WrapAlignment.spaceAround,
          //                                   crossAxisAlignment:
          //                                       WrapCrossAlignment.center,
          //                                   children: [
          //                                     Obx(() => filterBox(
          //                                           text: 'Any',
          //                                           width: maxWidth * 0.4,
          //                                           selected: EditCtrl
          //                                               .filterTypes
          //                                               .contains('Any'),
          //                                           onTap: () => propCtrl
          //                                               .toggleSelectedFilterBox(
          //                                                   filter: 'type',
          //                                                   item: 'Any'),
          //                                         )),
          //                                     ...Lst.propertyTypes
          //                                         .map((e) =>
          //                                             Obx(() => filterBox(
          //                                                   text: e,
          //                                                   width:
          //                                                       maxWidth * 0.4,
          //                                                   selected: EditCtrl
          //                                                       .filterTypes
          //                                                       .contains(e),
          //                                                   onTap: () => propCtrl
          //                                                       .toggleSelectedFilterBox(
          //                                                           filter:
          //                                                               'type',
          //                                                           item: e),
          //                                                 )))
          //                                         .toList(),
          //                                   ],
          //                                 ),
          //                                 const SizedBox(height: 16),
          //                                 const Text('Status',
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.w600,
          //                                         fontSize: 14)),
          //                                 Wrap(
          //                                   alignment:
          //                                       WrapAlignment.spaceAround,
          //                                   crossAxisAlignment:
          //                                       WrapCrossAlignment.center,
          //                                   children: [
          //                                     Obx(() => filterBox(
          //                                           text: 'Any',
          //                                           width: maxWidth * 0.4,
          //                                           selected: EditCtrl
          //                                               .filterStatus
          //                                               .contains('Any'),
          //                                           onTap: () => propCtrl
          //                                               .toggleSelectedFilterBox(
          //                                                   filter: 'status',
          //                                                   item: 'Any'),
          //                                         )),
          //                                     ...Lst.propertyStatus
          //                                         .map((e) =>
          //                                             Obx(() => filterBox(
          //                                                   text: e,
          //                                                   width:
          //                                                       maxWidth * 0.4,
          //                                                   selected: EditCtrl
          //                                                       .filterStatus
          //                                                       .contains(e),
          //                                                   onTap: () => propCtrl
          //                                                       .toggleSelectedFilterBox(
          //                                                           filter:
          //                                                               'status',
          //                                                           item: e),
          //                                                 )))
          //                                         .toList(),
          //                                   ],
          //                                 ),
          //                                 const SizedBox(height: 16),
          //                                 const Text('Amenities',
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.w600,
          //                                         fontSize: 14)),
          //                                 const SizedBox(height: 8),
          //                                 FutureBuilder(
          //                                     future:
          //                                         Get.find<CreatePropertyCtrl>()
          //                                             .getAmenities(all: true),
          //                                     builder: (context,
          //                                         AsyncSnapshot snap) {
          //                                       var amenities = snap.data ?? [];
          //                                       return Wrap(
          //                                           alignment: WrapAlignment
          //                                               .spaceAround,
          //                                           children: [
          //                                             SizedBox(
          //                                               width: maxWidth * 0.4,
          //                                               child: Row(
          //                                                 children: [
          //                                                   Obx(
          //                                                     () => Checkbox(
          //                                                       activeColor: Pallet
          //                                                           .secondaryColor,
          //                                                       checkColor:
          //                                                           Colors
          //                                                               .white,
          //                                                       side: const BorderSide(
          //                                                           color: Colors
          //                                                               .black54),
          //                                                       value: EditCtrl
          //                                                           .filterAmenities
          //                                                           .contains(
          //                                                               'Any'),
          //                                                       onChanged:
          //                                                           (state) {
          //                                                         if (EditCtrl
          //                                                                 .filterAmenities
          //                                                                 .contains(
          //                                                                     'Any') &&
          //                                                             EditCtrl
          //                                                                 .filterAmenities
          //                                                                 .isNotEmpty) {
          //                                                           EditCtrl
          //                                                               .filterAmenities
          //                                                               .remove(
          //                                                                   'Any');
          //                                                         } else {
          //                                                           if (EditCtrl
          //                                                               .filterAmenities
          //                                                               .isNotEmpty) {
          //                                                             EditCtrl
          //                                                                 .filterAmenities
          //                                                                 .removeRange(
          //                                                                     0,
          //                                                                     EditCtrl.filterAmenities.length);
          //                                                           }
          //                                                           EditCtrl
          //                                                               .filterAmenities
          //                                                               .add(
          //                                                                   'Any');
          //                                                         }
          //                                                         EditCtrl
          //                                                             .filterAmenities
          //                                                             .refresh();
          //                                                       },
          //                                                     ),
          //                                                   ),
          //                                                   const SizedBox(
          //                                                       width: 10),
          //                                                   const Expanded(
          //                                                       child: Text(
          //                                                           'Any',
          //                                                           style: TextStyle(
          //                                                               fontSize:
          //                                                                   16))),
          //                                                 ],
          //                                               ),
          //                                             ),
          //                                             ...(amenities as List)
          //                                                 .map((e) => Container(
          //                                                       width:
          //                                                           maxWidth *
          //                                                               0.4,
          //                                                       margin:
          //                                                           const EdgeInsets
          //                                                                   .only(
          //                                                               bottom:
          //                                                                   8),
          //                                                       child: Row(
          //                                                         mainAxisSize:
          //                                                             MainAxisSize
          //                                                                 .min,
          //                                                         children: [
          //                                                           Obx(
          //                                                             () =>
          //                                                                 Checkbox(
          //                                                               activeColor:
          //                                                                   Pallet.secondaryColor,
          //                                                               checkColor:
          //                                                                   Colors.white,
          //                                                               side: const BorderSide(
          //                                                                   color:
          //                                                                       Colors.black54),
          //                                                               value: EditCtrl
          //                                                                   .filterAmenities
          //                                                                   .contains(e['amenity']),
          //                                                               onChanged:
          //                                                                   (state) {
          //                                                                 if (EditCtrl
          //                                                                     .filterAmenities
          //                                                                     .contains(e['amenity'])) {
          //                                                                   EditCtrl.filterAmenities.remove(e['amenity']);
          //                                                                   if (EditCtrl.filterAmenities.isEmpty) {
          //                                                                     EditCtrl.filterAmenities.add('Any');
          //                                                                   }
          //                                                                 } else {
          //                                                                   if (EditCtrl.filterAmenities.contains('Any')) {
          //                                                                     EditCtrl.filterAmenities.remove('Any');
          //                                                                   }
          //                                                                   EditCtrl.filterAmenities.add(e['amenity']);
          //                                                                 }
          //                                                                 EditCtrl
          //                                                                     .filterAmenities
          //                                                                     .refresh();
          //                                                               },
          //                                                             ),
          //                                                           ),
          //                                                           const SizedBox(
          //                                                               width:
          //                                                                   10),
          //                                                           Expanded(
          //                                                               child: Text(
          //                                                                   e['amenity'],
          //                                                                   style: const TextStyle(fontSize: 16))),
          //                                                         ],
          //                                                       ),
          //                                                     ))
          //                                                 .toList(),
          //                                           ]);
          //                                     }),
          //                                 const SizedBox(height: 16),
          //                                 //const Text('Rooms', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          //                                 // Row(
          //                                 //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                                 //   crossAxisAlignment: CrossAxisAlignment.center,
          //                                 //   children: [
          //                                 //     Padding(
          //                                 //       padding: const EdgeInsets.symmetric(vertical: 8.0),
          //                                 //       child: DropDown(
          //                                 //         width: maxWidth * 0.4,
          //                                 //         color: Colors.white10,
          //                                 //         showLabel: false,
          //                                 //         labelColor: Colors.black54,
          //                                 //         controller: EditCtrl.roomMin,
          //                                 //         label: 'Min',
          //                                 //         items: const ['1', '2', '3'],
          //                                 //       ),
          //                                 //     ),
          //                                 //     const Text('to', style: TextStyle(fontWeight: FontWeight.w600)),
          //                                 //     Padding(
          //                                 //       padding: const EdgeInsets.symmetric(vertical: 8.0),
          //                                 //       child: DropDown(
          //                                 //         width: maxWidth * 0.4,
          //                                 //         color: Colors.white10,
          //                                 //         showLabel: false,
          //                                 //         controller: EditCtrl.roomMax,
          //                                 //         label: 'Max',
          //                                 //         items: const ['1', '2', '3'],
          //                                 //       ),
          //                                 //     ),
          //                                 //   ],
          //                                 // ),
          //                                 //const SizedBox(height: 16),
          //                                 //const Text('Baths', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          //                                 // Row(
          //                                 //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                                 //   crossAxisAlignment: CrossAxisAlignment.center,
          //                                 //   children: [
          //                                 //     Padding(
          //                                 //       padding: const EdgeInsets.symmetric(vertical: 8.0),
          //                                 //       child: DropDown(
          //                                 //         width: maxWidth * 0.4,
          //                                 //         color: Colors.white10,
          //                                 //         showLabel: false,
          //                                 //         labelColor: Colors.black54,
          //                                 //         controller: EditCtrl.bathsMin,
          //                                 //         label: 'Min',
          //                                 //         items: const ['1', '2', '3'],
          //                                 //       ),
          //                                 //     ),
          //                                 //     const Text('to', style: TextStyle(fontWeight: FontWeight.w600)),
          //                                 //     Padding(
          //                                 //       padding: const EdgeInsets.symmetric(vertical: 8.0),
          //                                 //       child: DropDown(
          //                                 //         width: maxWidth * 0.4,
          //                                 //         color: Colors.white10,
          //                                 //         showLabel: false,
          //                                 //         controller: EditCtrl.bathsMax,
          //                                 //         label: 'Max',
          //                                 //         items: const ['1', '2', '3'],
          //                                 //       ),
          //                                 //     ),
          //                                 //   ],
          //                                 // ),
          //                               ],
          //                             )
          //                           : const SizedBox.shrink()),
          //                       const SizedBox(height: 24),
          //                       InkWell(
          //                         onTap: () => propCtrl.showMoreFilter.value =
          //                             propCtrl.showMoreFilter.value == true
          //                                 ? false
          //                                 : true,
          //                         child: Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Obx(() => CustomText(
          //                                   color: Pallet.secondaryColor,
          //                                   size: 16,
          //                                   text: propCtrl.showMoreFilter.value
          //                                       ? 'Less filter'
          //                                       : 'More filters',
          //                                 )),
          //                             const SizedBox(width: 12),
          //                             Obx(() => Icon(
          //                                   propCtrl.showMoreFilter.value
          //                                       ? Icons.expand_less
          //                                       : Icons.expand_more,
          //                                   color: Pallet.secondaryColor,
          //                                   size: 24,
          //                                 ))
          //                           ],
          //                         ),
          //                       ),
          //                       const SizedBox(height: 62),
          //                     ],
          //                   ),
          //                   Positioned(
          //                       bottom: 0,
          //                       child: Container(
          //                         width: maxWidth,
          //                         color: Colors.white,
          //                         padding: const EdgeInsets.only(top: 8),
          //                         child: InkWell(
          //                           onTap: () {
          //                             Get.back(result: 'hello');
          //                             //propCtrl.applyFilterParameters();
          //                           },
          //                           child: Container(
          //                             height: 48,
          //                             color: Pallet.secondaryColor,
          //                             child: const Center(
          //                               child: CustomText(
          //                                 color: Colors.white,
          //                                 size: 16,
          //                                 text: 'APPLY FILTER',
          //                               ),
          //                             ),
          //                           ),
          //                         ),
          //                       ))
          //                 ]),
          //               );
          //             }),
          //           ),
          //         ),
          //       );
          //
          //       // Navigator.push(
          //       //   context,
          //       //   MaterialPageRoute(
          //       //       builder: (context) => const FilterExplorePage()),
          //       // );
          //       //Get.to(RouteStr.mobileExploreFilter);
          //     },
          //     child: Padding(
          //         padding: const EdgeInsets.only(right: 12.0),
          //         child: Image.asset('assets/images/filter.png')),
          //   )
          // ],
        ),
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              child: SizedBox(
                child: SingleChildScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    child: StreamBuilder<filter.FilterModel>(
                        stream: _filterStreamController.stream,
                        builder: (context, snapdata) {
                          if (snapdata.connectionState ==
                              ConnectionState.waiting) {
                            return Align(
                                alignment: Alignment.center,
                                child: Preloader.loadingWidget());
                          } else if (isLoading) {
                            return Align(
                                alignment: Alignment.center,
                                child: Preloader.loadingWidget());
                          } else {
                            List<filter.Property> properties =
                                snapdata.data!.data.properties;
                            //print(snapdata.data!.data.pages);
                            return Column(children: [
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      14.0, 14, 0, 14),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const CustomText(
                                            color: Colors.blueGrey,
                                            text: 'Filter Results',
                                            weight: FontWeight.bold,
                                            size: 16),
                                        GestureDetector(
                                            onTap: () {
                                              showMaterialModalBottomSheet(
                                                context: Get.context!,
                                                builder: (context) =>
                                                    SingleChildScrollView(
                                                  controller:
                                                      ModalScrollController.of(
                                                          context),
                                                  child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            100,
                                                    child: LayoutBuilder(
                                                        builder: (context,
                                                            constraints) {
                                                      double maxWidth =
                                                          constraints.maxWidth;
                                                      return SizedBox(
                                                        width: maxWidth,
                                                        height: constraints
                                                            .maxHeight,
                                                        child: Stack(children: [
                                                          ListView(
                                                            shrinkWrap: true,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        24),
                                                            children: [
                                                              GestureDetector(
                                                                onTap: propCtrl
                                                                    .clearFilter,
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Text(
                                                                    'Clear filter',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                                ),
                                                              ),
                                                              const Text(
                                                                  'Price',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14)),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            8.0),
                                                                    child:
                                                                        DropDown(
                                                                      width:
                                                                          maxWidth *
                                                                              0.4,
                                                                      color: Colors
                                                                          .white10,
                                                                      showLabel:
                                                                          false,
                                                                      labelColor:
                                                                          Colors
                                                                              .black54,
                                                                      controller:
                                                                          EditCtrl
                                                                              .priceMin,
                                                                      label:
                                                                          'Min',
                                                                      items: Lst
                                                                          .minFilterPrices,
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                      'to',
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            8.0),
                                                                    child:
                                                                        DropDown(
                                                                      width:
                                                                          maxWidth *
                                                                              0.4,
                                                                      color: Colors
                                                                          .white10,
                                                                      showLabel:
                                                                          false,
                                                                      controller:
                                                                          EditCtrl
                                                                              .priceMax,
                                                                      label:
                                                                          'Max',
                                                                      items: Lst
                                                                          .maxFilterPrices,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 16),
                                                              const Text(
                                                                  'Location',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14)),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        8),
                                                                child: DropDown(
                                                                  width:
                                                                      maxWidth *
                                                                          0.9,
                                                                  color: Colors
                                                                      .white10,
                                                                  showLabel:
                                                                      false,
                                                                  labelColor:
                                                                      Colors
                                                                          .black54,
                                                                  controller:
                                                                      EditCtrl
                                                                          .filterState,
                                                                  label:
                                                                      'State',
                                                                  items: Lst
                                                                      .ngStates,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        8.0,
                                                                    horizontal:
                                                                        8),
                                                                child: Obx(() =>
                                                                    DropDown(
                                                                      width:
                                                                          maxWidth *
                                                                              0.9,
                                                                      color: Colors
                                                                          .white10,
                                                                      showLabel:
                                                                          false,
                                                                      labelColor:
                                                                          Colors
                                                                              .black54,
                                                                      controller:
                                                                          EditCtrl
                                                                              .filterCity,
                                                                      label:
                                                                          'City/Town',
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
                                                              Obx(() => propCtrl
                                                                      .showMoreFilter
                                                                      .value
                                                                  ? Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .stretch,
                                                                      children: [
                                                                        const SizedBox(
                                                                            height:
                                                                                16),
                                                                        const Text(
                                                                            'Category',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                                                        Wrap(
                                                                          alignment:
                                                                              WrapAlignment.spaceAround,
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment.center,
                                                                          children: [
                                                                            Obx(() =>
                                                                                filterBox(
                                                                                  text: 'Any',
                                                                                  width: maxWidth * 0.4,
                                                                                  selected: EditCtrl.filterCategories.contains('Any'),
                                                                                  onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'category', item: 'Any'),
                                                                                )),
                                                                            ...Lst.propertyCategories
                                                                                .map((e) => Obx(() => filterBox(
                                                                                      text: e,
                                                                                      width: maxWidth * 0.4,
                                                                                      selected: EditCtrl.filterCategories.contains(e),
                                                                                      onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'category', item: e),
                                                                                    )))
                                                                                .toList(),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                16),
                                                                        const Text(
                                                                            'Type',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                                                        Wrap(
                                                                          alignment:
                                                                              WrapAlignment.spaceAround,
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment.center,
                                                                          children: [
                                                                            Obx(() =>
                                                                                filterBox(
                                                                                  text: 'Any',
                                                                                  width: maxWidth * 0.4,
                                                                                  selected: EditCtrl.filterTypes.contains('Any'),
                                                                                  onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'type', item: 'Any'),
                                                                                )),
                                                                            ...Lst.propertyTypes
                                                                                .map((e) => Obx(() => filterBox(
                                                                                      text: e,
                                                                                      width: maxWidth * 0.4,
                                                                                      selected: EditCtrl.filterTypes.contains(e),
                                                                                      onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'type', item: e),
                                                                                    )))
                                                                                .toList(),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                16),
                                                                        const Text(
                                                                            'Status',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                                                        Wrap(
                                                                          alignment:
                                                                              WrapAlignment.spaceAround,
                                                                          crossAxisAlignment:
                                                                              WrapCrossAlignment.center,
                                                                          children: [
                                                                            Obx(() =>
                                                                                filterBox(
                                                                                  text: 'Any',
                                                                                  width: maxWidth * 0.4,
                                                                                  selected: EditCtrl.filterStatus.contains('Any'),
                                                                                  onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'status', item: 'Any'),
                                                                                )),
                                                                            ...Lst.propertyStatus
                                                                                .map((e) => Obx(() => filterBox(
                                                                                      text: e,
                                                                                      width: maxWidth * 0.4,
                                                                                      selected: EditCtrl.filterStatus.contains(e),
                                                                                      onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'status', item: e),
                                                                                    )))
                                                                                .toList(),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                16),
                                                                        const Text(
                                                                            'Amenities',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                                                                        const SizedBox(
                                                                            height:
                                                                                8),
                                                                        FutureBuilder(
                                                                            future:
                                                                                Get.find<CreatePropertyCtrl>().getAmenities(all: true),
                                                                            builder: (context, AsyncSnapshot snap) {
                                                                              var amenities = snap.data ?? [];
                                                                              return Wrap(alignment: WrapAlignment.spaceAround, children: [
                                                                                SizedBox(
                                                                                  width: maxWidth * 0.4,
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Obx(
                                                                                        () => Checkbox(
                                                                                          activeColor: Pallet.secondaryColor,
                                                                                          checkColor: Colors.white,
                                                                                          side: const BorderSide(color: Colors.black54),
                                                                                          value: EditCtrl.filterAmenities.contains('Any'),
                                                                                          onChanged: (state) {
                                                                                            if (EditCtrl.filterAmenities.contains('Any') && EditCtrl.filterAmenities.isNotEmpty) {
                                                                                              EditCtrl.filterAmenities.remove('Any');
                                                                                            } else {
                                                                                              if (EditCtrl.filterAmenities.isNotEmpty) {
                                                                                                EditCtrl.filterAmenities.removeRange(0, EditCtrl.filterAmenities.length);
                                                                                              }
                                                                                              EditCtrl.filterAmenities.add('Any');
                                                                                            }
                                                                                            EditCtrl.filterAmenities.refresh();
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(width: 10),
                                                                                      const Expanded(child: Text('Any', style: TextStyle(fontSize: 16))),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                ...(amenities as List)
                                                                                    .map((e) => Container(
                                                                                          width: maxWidth * 0.4,
                                                                                          margin: const EdgeInsets.only(bottom: 8),
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            children: [
                                                                                              Obx(
                                                                                                () => Checkbox(
                                                                                                  activeColor: Pallet.secondaryColor,
                                                                                                  checkColor: Colors.white,
                                                                                                  side: const BorderSide(color: Colors.black54),
                                                                                                  value: EditCtrl.filterAmenities.contains(e['amenity']),
                                                                                                  onChanged: (state) {
                                                                                                    if (EditCtrl.filterAmenities.contains(e['amenity'])) {
                                                                                                      EditCtrl.filterAmenities.remove(e['amenity']);
                                                                                                      if (EditCtrl.filterAmenities.isEmpty) {
                                                                                                        EditCtrl.filterAmenities.add('Any');
                                                                                                      }
                                                                                                    } else {
                                                                                                      if (EditCtrl.filterAmenities.contains('Any')) {
                                                                                                        EditCtrl.filterAmenities.remove('Any');
                                                                                                      }
                                                                                                      EditCtrl.filterAmenities.add(e['amenity']);
                                                                                                    }
                                                                                                    EditCtrl.filterAmenities.refresh();
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(width: 10),
                                                                                              Expanded(child: Text(e['amenity'], style: const TextStyle(fontSize: 16))),
                                                                                            ],
                                                                                          ),
                                                                                        ))
                                                                                    .toList(),
                                                                              ]);
                                                                            }),
                                                                        const SizedBox(
                                                                            height:
                                                                                16),
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
                                                              const SizedBox(
                                                                  height: 24),
                                                              InkWell(
                                                                onTap: () => propCtrl
                                                                    .showMoreFilter
                                                                    .value = propCtrl
                                                                            .showMoreFilter
                                                                            .value ==
                                                                        true
                                                                    ? false
                                                                    : true,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Obx(() =>
                                                                        CustomText(
                                                                          color:
                                                                              Pallet.secondaryColor,
                                                                          size:
                                                                              16,
                                                                          text: propCtrl.showMoreFilter.value
                                                                              ? 'Less filter'
                                                                              : 'More filters',
                                                                        )),
                                                                    const SizedBox(
                                                                        width:
                                                                            12),
                                                                    Obx(() =>
                                                                        Icon(
                                                                          propCtrl.showMoreFilter.value
                                                                              ? Icons.expand_less
                                                                              : Icons.expand_more,
                                                                          color:
                                                                              Pallet.secondaryColor,
                                                                          size:
                                                                              24,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 62),
                                                            ],
                                                          ),
                                                          Positioned(
                                                              bottom: 0,
                                                              child: Container(
                                                                width: maxWidth,
                                                                color: Colors
                                                                    .white,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 8),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isLoading =
                                                                          true;
                                                                    });
                                                                    Get.back(
                                                                        result:
                                                                            'hello');
                                                                    getfilterProperty(
                                                                        1);
                                                                    //propCtrl.applyFilterParameters();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 48,
                                                                    color: Pallet
                                                                        .secondaryColor,
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          CustomText(
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            16,
                                                                        text:
                                                                            'APPLY FILTER',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ))
                                                        ]),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              );

                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) => const FilterExplorePage()),
                                              // );
                                              //Get.to(RouteStr.mobileExploreFilter);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12.0),
                                              child: Container(
                                                  height: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.red,
                                                  ),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 12.0),
                                                      child: Image.asset(
                                                          'assets/images/filter.png'))),
                                            ))
                                      ])),
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
                                            const Text(
                                              'Adjust your filter parameter to find a property',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            )
                                          ])
                                        ],
                                      );
                                    } else {
                                      return buildFilterList(
                                          showMore: true, property: property);
                                    }
                                  }),
                              if (snapdata.data!.data.pages > 1)
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 50.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                //_list.removeAt(_curr);
                                                if (page == 1) {
                                                } else {
                                                  setState(() {
                                                    page--;
                                                    getfilterProperty(page);
                                                  });
                                                }
                                              },
                                              child: const Icon(
                                                Icons.navigate_before,
                                                size: 40,
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                if (snapdata.data!.data.pages ==
                                                    page) {
                                                } else {}
                                                setState(() {
                                                  page++;
                                                  getfilterProperty(page);
                                                });
                                              },
                                              child: const Icon(
                                                Icons.navigate_next,
                                                size: 40,
                                              )),
                                        ]),
                                  ),
                                )
                            ]);
                          }
                        })),

                // child: FutureBuilder(
                //     future: _future,
                //     builder: (context, AsyncSnapshot snap) {
                //       List<Property> properties = snap.data ?? [];
                //       // property.title!.trim().toLowerCase().contains(
                //       //     SearchValue.trim().toLowerCase())
                //       return Obx(() => propCtrl.showFeatureLoading.value
                //           ? Preloader.loadingWidget()
                //           : ListView.builder(
                //           controller: _controller,
                //               itemCount: propCtrl.exploreFilterProperties.length,
                //               padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 20),
                //               scrollDirection: Axis.vertical,
                //               shrinkWrap: true,
                //               itemBuilder: (context, index) {
                //                 Property property = properties[index];
                //                 return index == 0
                //                     ? Column(
                //                         children: [
                //                           const SizedBox(height: 16),
                //                           const Align(
                //                               alignment: Alignment.topLeft,
                //                               child: CustomText(color: Colors.blueGrey, text: 'Filter Results', weight: FontWeight.bold, size: 16)),
                //                           const Divider(color: Colors.black12),
                //                           propCtrl.exploreFilterProperties.isEmpty
                //                               ? Column(children: [
                //                                   SizedBox(
                //                                     height: Get.height * 0.2,
                //                                   ),
                //                                   const CustomText(color: Colors.blueGrey, text: 'No Results Found', weight: FontWeight.w400, size: 18),
                //                                   const SizedBox(height: 10),
                //                                   const Text(
                //                                     'Adjust your filter parameter to find a property',
                //                                     textAlign: TextAlign.center,
                //                                     style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w400, fontSize: 16),
                //                                   )
                //                                 ])
                //                               : const SizedBox.shrink(),
                //                         ],
                //                       )
                //                     : buildPremiumList(showMore: true, property: property);
                //               }));
                //     }),
              ),
            ),
          ],
        ),
        floatingActionButton: AnimatedOpacity(
          duration: const Duration(milliseconds: 1000), //show/hide animation
          opacity: showbtn ? 1.0 : 0.0, //set obacity to 1 on visible, or hide
          child: FloatingActionButton(
            onPressed: () {
              ExplorePage explorePage = const ExplorePage();
              scrollController.animateTo(
                  //go to top of scroll
                  0, //scroll offset to go
                  duration:
                      const Duration(milliseconds: 500), //duration of scroll
                  curve: Curves.fastOutSlowIn //scroll type
                  );
            },
            child: const Icon(Icons.arrow_upward),
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

// class Pages extends StatefulWidget {
//   final page;
//
//   const Pages({this.page});
//
//   @override
//   State<Pages> createState() => _PagesState();
// }
//
// class _PagesState extends State<Pages> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<filter.FilterModel>(
//           stream: _filterStreamController.stream,
//           builder: (context, snapdata) {
//             if (snapdata.connectionState == ConnectionState.waiting) {
//               return Preloader.loadingWidget();
//             } else if (isLoading) {
//               return Preloader.loadingWidget();
//             } else {
//               List<filter.Property> properties =
//                   snapdata.data!.data.properties ?? [];
//               return ListView.builder(
//                   controller: scrollController,
//                   itemCount: properties.length,
//                   padding: const EdgeInsets.only(
//                       left: 12.0, right: 12.0, bottom: 20),
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     filter.Property property = properties[index];
//                     return index == 0
//                         ? Column(
//                             children: [
//                               const SizedBox(height: 16),
//                               Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     CustomText(
//                                         color: Colors.blueGrey,
//                                         text: 'Filter Results',
//                                         weight: FontWeight.bold,
//                                         size: 16),
//                                     GestureDetector(
//                                       onTap: () {
//                                         showMaterialModalBottomSheet(
//                                           context: Get.context!,
//                                           builder: (context) =>
//                                               SingleChildScrollView(
//                                             controller:
//                                                 ModalScrollController.of(
//                                                     context),
//                                             child: Container(
//                                               height: MediaQuery.of(context)
//                                                       .size
//                                                       .height -
//                                                   100,
//                                               child: LayoutBuilder(builder:
//                                                   (context, constraints) {
//                                                 double maxWidth =
//                                                     constraints.maxWidth;
//                                                 return SizedBox(
//                                                   width: maxWidth,
//                                                   height: constraints.maxHeight,
//                                                   child: Stack(children: [
//                                                     ListView(
//                                                       shrinkWrap: true,
//                                                       padding: const EdgeInsets
//                                                               .symmetric(
//                                                           horizontal: 12,
//                                                           vertical: 24),
//                                                       children: [
//                                                         const Text('Price',
//                                                             style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600,
//                                                                 fontSize: 14)),
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceAround,
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .symmetric(
//                                                                       vertical:
//                                                                           8.0),
//                                                               child: DropDown(
//                                                                 width:
//                                                                     maxWidth *
//                                                                         0.4,
//                                                                 color: Colors
//                                                                     .white10,
//                                                                 showLabel:
//                                                                     false,
//                                                                 labelColor:
//                                                                     Colors
//                                                                         .black54,
//                                                                 controller:
//                                                                     EditCtrl
//                                                                         .priceMin,
//                                                                 label: 'Min',
//                                                                 items: Lst
//                                                                     .minFilterPrices,
//                                                               ),
//                                                             ),
//                                                             const Text('to',
//                                                                 style: TextStyle(
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w600)),
//                                                             Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .symmetric(
//                                                                       vertical:
//                                                                           8.0),
//                                                               child: DropDown(
//                                                                 width:
//                                                                     maxWidth *
//                                                                         0.4,
//                                                                 color: Colors
//                                                                     .white10,
//                                                                 showLabel:
//                                                                     false,
//                                                                 controller:
//                                                                     EditCtrl
//                                                                         .priceMax,
//                                                                 label: 'Max',
//                                                                 items: Lst
//                                                                     .maxFilterPrices,
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const SizedBox(
//                                                             height: 16),
//                                                         const Text('Location',
//                                                             style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600,
//                                                                 fontSize: 14)),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   vertical: 8.0,
//                                                                   horizontal:
//                                                                       8),
//                                                           child: DropDown(
//                                                             width:
//                                                                 maxWidth * 0.9,
//                                                             color:
//                                                                 Colors.white10,
//                                                             showLabel: false,
//                                                             labelColor:
//                                                                 Colors.black54,
//                                                             controller: EditCtrl
//                                                                 .filterState,
//                                                             label: 'State',
//                                                             items: Lst.ngStates,
//                                                           ),
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   vertical: 8.0,
//                                                                   horizontal:
//                                                                       8),
//                                                           child:
//                                                               Obx(
//                                                                   () =>
//                                                                       DropDown(
//                                                                         width: maxWidth *
//                                                                             0.9,
//                                                                         color: Colors
//                                                                             .white10,
//                                                                         showLabel:
//                                                                             false,
//                                                                         labelColor:
//                                                                             Colors.black54,
//                                                                         controller:
//                                                                             EditCtrl.filterCity,
//                                                                         label:
//                                                                             'City/Town',
//                                                                         items: Lst.ngLGA[EditCtrl.filterState.value.text] ??
//                                                                             [],
//                                                                       )),
//                                                         ),
//                                                         // Padding(
//                                                         //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//                                                         //   child: DropDown(
//                                                         //     width: maxWidth * 0.9,
//                                                         //     color: Colors.white10,
//                                                         //     showLabel: false,
//                                                         //     labelColor: Colors.black54,
//                                                         //     controller: EditCtrl.filterLandMark,
//                                                         //     label: 'Landmarks',
//                                                         //     items: Lst.ngLGA[Lst.ngStates[0]] ?? [],
//                                                         //   ),
//                                                         // ),
//                                                         Obx(() => propCtrl
//                                                                 .showMoreFilter
//                                                                 .value
//                                                             ? Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .stretch,
//                                                                 children: [
//                                                                   const SizedBox(
//                                                                       height:
//                                                                           16),
//                                                                   const Text(
//                                                                       'Category',
//                                                                       style: TextStyle(
//                                                                           fontWeight: FontWeight
//                                                                               .w600,
//                                                                           fontSize:
//                                                                               14)),
//                                                                   Wrap(
//                                                                     alignment:
//                                                                         WrapAlignment
//                                                                             .spaceAround,
//                                                                     crossAxisAlignment:
//                                                                         WrapCrossAlignment
//                                                                             .center,
//                                                                     children: [
//                                                                       Obx(() =>
//                                                                           filterBox(
//                                                                             text:
//                                                                                 'Any',
//                                                                             width:
//                                                                                 maxWidth * 0.4,
//                                                                             selected:
//                                                                                 EditCtrl.filterCategories.contains('Any'),
//                                                                             onTap: () =>
//                                                                                 propCtrl.toggleSelectedFilterBox(filter: 'category', item: 'Any'),
//                                                                           )),
//                                                                       ...Lst
//                                                                           .propertyCategories
//                                                                           .map((e) => Obx(() =>
//                                                                               filterBox(
//                                                                                 text: e,
//                                                                                 width: maxWidth * 0.4,
//                                                                                 selected: EditCtrl.filterCategories.contains(e),
//                                                                                 onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'category', item: e),
//                                                                               )))
//                                                                           .toList(),
//                                                                     ],
//                                                                   ),
//                                                                   const SizedBox(
//                                                                       height:
//                                                                           16),
//                                                                   const Text(
//                                                                       'Type',
//                                                                       style: TextStyle(
//                                                                           fontWeight: FontWeight
//                                                                               .w600,
//                                                                           fontSize:
//                                                                               14)),
//                                                                   Wrap(
//                                                                     alignment:
//                                                                         WrapAlignment
//                                                                             .spaceAround,
//                                                                     crossAxisAlignment:
//                                                                         WrapCrossAlignment
//                                                                             .center,
//                                                                     children: [
//                                                                       Obx(() =>
//                                                                           filterBox(
//                                                                             text:
//                                                                                 'Any',
//                                                                             width:
//                                                                                 maxWidth * 0.4,
//                                                                             selected:
//                                                                                 EditCtrl.filterTypes.contains('Any'),
//                                                                             onTap: () =>
//                                                                                 propCtrl.toggleSelectedFilterBox(filter: 'type', item: 'Any'),
//                                                                           )),
//                                                                       ...Lst
//                                                                           .propertyTypes
//                                                                           .map((e) => Obx(() =>
//                                                                               filterBox(
//                                                                                 text: e,
//                                                                                 width: maxWidth * 0.4,
//                                                                                 selected: EditCtrl.filterTypes.contains(e),
//                                                                                 onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'type', item: e),
//                                                                               )))
//                                                                           .toList(),
//                                                                     ],
//                                                                   ),
//                                                                   const SizedBox(
//                                                                       height:
//                                                                           16),
//                                                                   const Text(
//                                                                       'Status',
//                                                                       style: TextStyle(
//                                                                           fontWeight: FontWeight
//                                                                               .w600,
//                                                                           fontSize:
//                                                                               14)),
//                                                                   Wrap(
//                                                                     alignment:
//                                                                         WrapAlignment
//                                                                             .spaceAround,
//                                                                     crossAxisAlignment:
//                                                                         WrapCrossAlignment
//                                                                             .center,
//                                                                     children: [
//                                                                       Obx(() =>
//                                                                           filterBox(
//                                                                             text:
//                                                                                 'Any',
//                                                                             width:
//                                                                                 maxWidth * 0.4,
//                                                                             selected:
//                                                                                 EditCtrl.filterStatus.contains('Any'),
//                                                                             onTap: () =>
//                                                                                 propCtrl.toggleSelectedFilterBox(filter: 'status', item: 'Any'),
//                                                                           )),
//                                                                       ...Lst
//                                                                           .propertyStatus
//                                                                           .map((e) => Obx(() =>
//                                                                               filterBox(
//                                                                                 text: e,
//                                                                                 width: maxWidth * 0.4,
//                                                                                 selected: EditCtrl.filterStatus.contains(e),
//                                                                                 onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'status', item: e),
//                                                                               )))
//                                                                           .toList(),
//                                                                     ],
//                                                                   ),
//                                                                   const SizedBox(
//                                                                       height:
//                                                                           16),
//                                                                   const Text(
//                                                                       'Amenities',
//                                                                       style: TextStyle(
//                                                                           fontWeight: FontWeight
//                                                                               .w600,
//                                                                           fontSize:
//                                                                               14)),
//                                                                   const SizedBox(
//                                                                       height:
//                                                                           8),
//                                                                   FutureBuilder(
//                                                                       future: Get.find<
//                                                                               CreatePropertyCtrl>()
//                                                                           .getAmenities(
//                                                                               all:
//                                                                                   true),
//                                                                       builder: (context,
//                                                                           AsyncSnapshot
//                                                                               snap) {
//                                                                         var amenities =
//                                                                             snap.data ??
//                                                                                 [];
//                                                                         return Wrap(
//                                                                             alignment:
//                                                                                 WrapAlignment.spaceAround,
//                                                                             children: [
//                                                                               SizedBox(
//                                                                                 width: maxWidth * 0.4,
//                                                                                 child: Row(
//                                                                                   children: [
//                                                                                     Obx(
//                                                                                       () => Checkbox(
//                                                                                         activeColor: Pallet.secondaryColor,
//                                                                                         checkColor: Colors.white,
//                                                                                         side: const BorderSide(color: Colors.black54),
//                                                                                         value: EditCtrl.filterAmenities.contains('Any'),
//                                                                                         onChanged: (state) {
//                                                                                           if (EditCtrl.filterAmenities.contains('Any') && EditCtrl.filterAmenities.isNotEmpty) {
//                                                                                             EditCtrl.filterAmenities.remove('Any');
//                                                                                           } else {
//                                                                                             if (EditCtrl.filterAmenities.isNotEmpty) {
//                                                                                               EditCtrl.filterAmenities.removeRange(0, EditCtrl.filterAmenities.length);
//                                                                                             }
//                                                                                             EditCtrl.filterAmenities.add('Any');
//                                                                                           }
//                                                                                           EditCtrl.filterAmenities.refresh();
//                                                                                         },
//                                                                                       ),
//                                                                                     ),
//                                                                                     const SizedBox(width: 10),
//                                                                                     const Expanded(child: Text('Any', style: TextStyle(fontSize: 16))),
//                                                                                   ],
//                                                                                 ),
//                                                                               ),
//                                                                               ...(amenities as List)
//                                                                                   .map((e) => Container(
//                                                                                         width: maxWidth * 0.4,
//                                                                                         margin: const EdgeInsets.only(bottom: 8),
//                                                                                         child: Row(
//                                                                                           mainAxisSize: MainAxisSize.min,
//                                                                                           children: [
//                                                                                             Obx(
//                                                                                               () => Checkbox(
//                                                                                                 activeColor: Pallet.secondaryColor,
//                                                                                                 checkColor: Colors.white,
//                                                                                                 side: const BorderSide(color: Colors.black54),
//                                                                                                 value: EditCtrl.filterAmenities.contains(e['amenity']),
//                                                                                                 onChanged: (state) {
//                                                                                                   if (EditCtrl.filterAmenities.contains(e['amenity'])) {
//                                                                                                     EditCtrl.filterAmenities.remove(e['amenity']);
//                                                                                                     if (EditCtrl.filterAmenities.isEmpty) {
//                                                                                                       EditCtrl.filterAmenities.add('Any');
//                                                                                                     }
//                                                                                                   } else {
//                                                                                                     if (EditCtrl.filterAmenities.contains('Any')) {
//                                                                                                       EditCtrl.filterAmenities.remove('Any');
//                                                                                                     }
//                                                                                                     EditCtrl.filterAmenities.add(e['amenity']);
//                                                                                                   }
//                                                                                                   EditCtrl.filterAmenities.refresh();
//                                                                                                 },
//                                                                                               ),
//                                                                                             ),
//                                                                                             const SizedBox(width: 10),
//                                                                                             Expanded(child: Text(e['amenity'], style: const TextStyle(fontSize: 16))),
//                                                                                           ],
//                                                                                         ),
//                                                                                       ))
//                                                                                   .toList(),
//                                                                             ]);
//                                                                       }),
//                                                                   const SizedBox(
//                                                                       height:
//                                                                           16),
//                                                                   //const Text('Rooms', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
//                                                                   // Row(
//                                                                   //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                                   //   crossAxisAlignment: CrossAxisAlignment.center,
//                                                                   //   children: [
//                                                                   //     Padding(
//                                                                   //       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                                                                   //       child: DropDown(
//                                                                   //         width: maxWidth * 0.4,
//                                                                   //         color: Colors.white10,
//                                                                   //         showLabel: false,
//                                                                   //         labelColor: Colors.black54,
//                                                                   //         controller: EditCtrl.roomMin,
//                                                                   //         label: 'Min',
//                                                                   //         items: const ['1', '2', '3'],
//                                                                   //       ),
//                                                                   //     ),
//                                                                   //     const Text('to', style: TextStyle(fontWeight: FontWeight.w600)),
//                                                                   //     Padding(
//                                                                   //       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                                                                   //       child: DropDown(
//                                                                   //         width: maxWidth * 0.4,
//                                                                   //         color: Colors.white10,
//                                                                   //         showLabel: false,
//                                                                   //         controller: EditCtrl.roomMax,
//                                                                   //         label: 'Max',
//                                                                   //         items: const ['1', '2', '3'],
//                                                                   //       ),
//                                                                   //     ),
//                                                                   //   ],
//                                                                   // ),
//                                                                   //const SizedBox(height: 16),
//                                                                   //const Text('Baths', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
//                                                                   // Row(
//                                                                   //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                                   //   crossAxisAlignment: CrossAxisAlignment.center,
//                                                                   //   children: [
//                                                                   //     Padding(
//                                                                   //       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                                                                   //       child: DropDown(
//                                                                   //         width: maxWidth * 0.4,
//                                                                   //         color: Colors.white10,
//                                                                   //         showLabel: false,
//                                                                   //         labelColor: Colors.black54,
//                                                                   //         controller: EditCtrl.bathsMin,
//                                                                   //         label: 'Min',
//                                                                   //         items: const ['1', '2', '3'],
//                                                                   //       ),
//                                                                   //     ),
//                                                                   //     const Text('to', style: TextStyle(fontWeight: FontWeight.w600)),
//                                                                   //     Padding(
//                                                                   //       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                                                                   //       child: DropDown(
//                                                                   //         width: maxWidth * 0.4,
//                                                                   //         color: Colors.white10,
//                                                                   //         showLabel: false,
//                                                                   //         controller: EditCtrl.bathsMax,
//                                                                   //         label: 'Max',
//                                                                   //         items: const ['1', '2', '3'],
//                                                                   //       ),
//                                                                   //     ),
//                                                                   //   ],
//                                                                   // ),
//                                                                 ],
//                                                               )
//                                                             : const SizedBox
//                                                                 .shrink()),
//                                                         const SizedBox(
//                                                             height: 24),
//                                                         InkWell(
//                                                           onTap: () => propCtrl
//                                                               .showMoreFilter
//                                                               .value = propCtrl
//                                                                       .showMoreFilter
//                                                                       .value ==
//                                                                   true
//                                                               ? false
//                                                               : true,
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .center,
//                                                             children: [
//                                                               Obx(() =>
//                                                                   CustomText(
//                                                                     color: Pallet
//                                                                         .secondaryColor,
//                                                                     size: 16,
//                                                                     text: propCtrl
//                                                                             .showMoreFilter
//                                                                             .value
//                                                                         ? 'Less filter'
//                                                                         : 'More filters',
//                                                                   )),
//                                                               const SizedBox(
//                                                                   width: 12),
//                                                               Obx(() => Icon(
//                                                                     propCtrl.showMoreFilter
//                                                                             .value
//                                                                         ? Icons
//                                                                             .expand_less
//                                                                         : Icons
//                                                                             .expand_more,
//                                                                     color: Pallet
//                                                                         .secondaryColor,
//                                                                     size: 24,
//                                                                   ))
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         const SizedBox(
//                                                             height: 62),
//                                                       ],
//                                                     ),
//                                                     Positioned(
//                                                         bottom: 0,
//                                                         child: Container(
//                                                           width: maxWidth,
//                                                           color: Colors.white,
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .only(top: 8),
//                                                           child: InkWell(
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 isLoading =
//                                                                     true;
//                                                               });
//                                                               Get.back(
//                                                                   result:
//                                                                       'hello');
//                                                               getfilterProperty(
//                                                                   1);
//                                                               //propCtrl.applyFilterParameters();
//                                                             },
//                                                             child: Container(
//                                                               height: 48,
//                                                               color: Pallet
//                                                                   .secondaryColor,
//                                                               child:
//                                                                   const Center(
//                                                                 child:
//                                                                     CustomText(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   size: 16,
//                                                                   text:
//                                                                       'APPLY FILTER',
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ))
//                                                   ]),
//                                                 );
//                                               }),
//                                             ),
//                                           ),
//                                         );
//
//                                         // Navigator.push(
//                                         //   context,
//                                         //   MaterialPageRoute(
//                                         //       builder: (context) => const FilterExplorePage()),
//                                         // );
//                                         //Get.to(RouteStr.mobileExploreFilter);
//                                       },
//                                       child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               right: 12.0),
//                                           child: Container(
//                                             height: 40,
//                                             decoration: BoxDecoration(
//                                               color: Colors.red,
//                                             ),
//                                             child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 12.0),
//                                                     child: Image.asset('assets/images/filter.png')
//                                           )),
//                                     )
//                                     )]),
//                               const Divider(color: Colors.black12),
//                               properties.isEmpty
//                                   ? Column(children: [
//                                       SizedBox(
//                                         height: Get.height * 0.2,
//                                       ),
//                                       const CustomText(
//                                           color: Colors.blueGrey,
//                                           text: 'No Results Found',
//                                           weight: FontWeight.w400,
//                                           size: 18),
//                                       const SizedBox(height: 10),
//                                       const Text(
//                                         'Adjust your filter parameter to find a property',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: Colors.blueGrey,
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 16),
//                                       )
//                                     ])
//                                   : const SizedBox.shrink(),
//                             ],
//                           )
//                         : buildFilterList(showMore: true, property: property);
//                   });
//             }
//           }),
//       floatingActionButton: AnimatedOpacity(
//         duration: Duration(milliseconds: 1000),  //show/hide animation
//         opacity: showbtn?1.0:0.0, //set obacity to 1 on visible, or hide
//         child: FloatingActionButton(
//           onPressed: () {
//             ExplorePage explorePage=ExplorePage();
//             scrollController.animateTo( //go to top of scroll
//                 0,  //scroll offset to go
//                 duration: Duration(milliseconds: 500), //duration of scroll
//                 curve:Curves.fastOutSlowIn //scroll type
//             );
//           },
//           child: Icon(Icons.arrow_upward),
//           backgroundColor: Colors.redAccent,
//         ),
//       ),
//     );
//   }
// }

// class ExploreGallery extends StatelessWidget {
//    ExploreGallery({Key? key,required this.images}) : super(key: key);
//   late List<sing.Media> images;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Pallet.homeBackground,
//         appBar: AppBar(
//           backgroundColor: Pallet.secondaryColor,
//           automaticallyImplyLeading: true,
//           title: const CustomText(
//             color: Colors.white,
//             size: 18,
//             text: 'Gallery',
//           ),
//         ),
//         body: GridView.builder(
//             shrinkWrap: true,
//             padding: const EdgeInsets.all(12),
//             itemCount: imageList.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 10,
//               crossAxisSpacing: 10,
//               mainAxisExtent: 180,
//             ),
//             itemBuilder: (_, index) => Hero(
//                   tag: '$index',
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.to(
//                         () => FullGalleryScreen(
//                           index: index,
//                           images: images,
//                         ),
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           shape: BoxShape.rectangle,
//                           image: DecorationImage(
//                               image: AssetImage(imageList[index]),
//                               fit: BoxFit.cover)),
//                     ),
//                   ),
//                 )));
//   }
// }

class FullGalleryScreen extends StatelessWidget {
  FullGalleryScreen({Key? key, required this.index, required this.images})
      : super(key: key);

  int i = 0;
  final int index;
  late PageController _controller;
  late List<sing.Media> images;

  @override
  Widget build(BuildContext context) {
    //Property property = propCtrl.property;
    // images = property.media ?? [];
    _controller = PageController(initialPage: 0);
    //propCtrl.currentIndex.value = images?[0].media ?? '';
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LimitedBox(
              maxHeight: Get.height,
              child: PageView(
                controller: _controller,
                children: [
                  ...images
                      .map((e) => Container(
                            width: Get.width,
                            // height: Get.height,
                            color: Colors.black,
                            child: Image.network(propertyImgPath + e.media),
                          ))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: Get.height * 0.5,
          left: 16,
          child: GestureDetector(
            onTap: () {
              previousPage();
            },
            child: Container(
              height: 40,
              width: 40,
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white.withOpacity(0.6)),
            ),
          ),
        ),
        Positioned(
          top: Get.height * 0.5,
          right: 16,
          child: GestureDetector(
            onTap: () {
              nextPage();
            },
            child: Container(
              height: 40,
              width: 40,
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white.withOpacity(0.4)),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: SafeArea(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 35,
                width: 35,
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Pallet.secondaryColor,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2)),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(top: 90),
            width: Get.width,
            child: FittedBox(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(children: [
                  ...images
                      .map((e) => Obx(() => Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: propCtrl.currentIndex.value == e.media
                                      ? Pallet.secondaryColor
                                      : Colors.grey),
                              image: DecorationImage(
                                  image:
                                      NetworkImage(propertyImgPath + e.media),
                                  fit: BoxFit.cover),
                            ),
                          )))
                      .toList(),
                ]),
              ),
            ),
          ),
        )
      ],
    );
  }

  void nextPage() {
    propCtrl.currentIndex.value = images[_controller.page!.toInt() + 1].media;
    _controller.animateToPage(_controller.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void previousPage() {
    propCtrl.currentIndex.value = images[_controller.page!.toInt() - 1].media;
    _controller.animateToPage(_controller.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
