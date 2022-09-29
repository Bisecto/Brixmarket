import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/create_property_controller.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../res/lists.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/drop_down.dart';
import '../create_property/create_property_widges.dart';

class FilterExplorePage extends StatelessWidget {
  final bool isWeb;
  const FilterExplorePage({Key? key, this.isWeb = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: isWeb ? Pallet.homeBackground : Pallet.secondaryColor,
        elevation: isWeb ? 0 : 8,
        leading: InkWell(
          onTap: () => isWeb ? propCtrl.showWebFilter.value = false : Get.back(),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(8.0, 14, 0, 14),
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: CustomText(
          size: 18,
          text: 'Filter Properties',
          color: isWeb ? Colors.black87 : Colors.white,
        ),
        foregroundColor: isWeb ? Colors.black87 : Colors.white,
        actions: [
          InkWell(
              onTap: propCtrl.clearFilter,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Clear', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ))
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return SizedBox(
          width: maxWidth,
          height: constraints.maxHeight,
          child: Stack(children: [
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              children: [
                const Text('Price', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropDown(
                        width: maxWidth * 0.4,
                        color: Colors.white10,
                        showLabel: false,
                        labelColor: Colors.black54,
                        controller: EditCtrl.priceMin,
                        label: 'Min',
                        items: Lst.minFilterPrices,
                      ),
                    ),
                    const Text('to', style: TextStyle(fontWeight: FontWeight.w600)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: DropDown(
                        width: maxWidth * 0.4,
                        color: Colors.white10,
                        showLabel: false,
                        controller: EditCtrl.priceMax,
                        label: 'Max',
                        items: Lst.maxFilterPrices,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Location', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: DropDown(
                    width: maxWidth * 0.9,
                    color: Colors.white10,
                    showLabel: false,
                    labelColor: Colors.black54,
                    controller: EditCtrl.filterState,
                    label: 'State',
                    items: Lst.ngStates,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Obx(() => DropDown(
                        width: maxWidth * 0.9,
                        color: Colors.white10,
                        showLabel: false,
                        labelColor: Colors.black54,
                        controller: EditCtrl.filterCity,
                        label: 'City/Town',
                        items: Lst.ngLGA[EditCtrl.filterState.value.text] ?? [],
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
                Obx(() => propCtrl.showMoreFilter.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
                          const Text('Category', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          Wrap(
                            alignment: WrapAlignment.spaceAround,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Obx(() => filterBox(
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
                          const SizedBox(height: 16),
                          const Text('Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          Wrap(
                            alignment: WrapAlignment.spaceAround,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Obx(() => filterBox(
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
                          const SizedBox(height: 16),
                          const Text('Status', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          Wrap(
                            alignment: WrapAlignment.spaceAround,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Obx(() => filterBox(
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
                          const SizedBox(height: 16),
                          const Text('Amenities', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          const SizedBox(height: 8),
                          FutureBuilder(
                              future: Get.find<CreatePropertyCtrl>().getAmenities(all: true),
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
                          const SizedBox(height: 16),
                          const Text('Rooms', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: DropDown(
                                  width: maxWidth * 0.4,
                                  color: Colors.white10,
                                  showLabel: false,
                                  labelColor: Colors.black54,
                                  controller: EditCtrl.roomMin,
                                  label: 'Min',
                                  items: const ['1', '2', '3'],
                                ),
                              ),
                              const Text('to', style: TextStyle(fontWeight: FontWeight.w600)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: DropDown(
                                  width: maxWidth * 0.4,
                                  color: Colors.white10,
                                  showLabel: false,
                                  controller: EditCtrl.roomMax,
                                  label: 'Max',
                                  items: const ['1', '2', '3'],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('Baths', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: DropDown(
                                  width: maxWidth * 0.4,
                                  color: Colors.white10,
                                  showLabel: false,
                                  labelColor: Colors.black54,
                                  controller: EditCtrl.bathsMin,
                                  label: 'Min',
                                  items: const ['1', '2', '3'],
                                ),
                              ),
                              const Text('to', style: TextStyle(fontWeight: FontWeight.w600)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: DropDown(
                                  width: maxWidth * 0.4,
                                  color: Colors.white10,
                                  showLabel: false,
                                  controller: EditCtrl.bathsMax,
                                  label: 'Max',
                                  items: const ['1', '2', '3'],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox.shrink()),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () => propCtrl.showMoreFilter.value = propCtrl.showMoreFilter.value == true ? false : true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => CustomText(
                            color: Pallet.secondaryColor,
                            size: 16,
                            text: propCtrl.showMoreFilter.value ? 'Less filter' : 'More filters',
                          )),
                      const SizedBox(width: 12),
                      Obx(() => Icon(
                            propCtrl.showMoreFilter.value ? Icons.expand_less : Icons.expand_more,
                            color: Pallet.secondaryColor,
                            size: 24,
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 62),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: maxWidth,
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 8),
                  child: InkWell(
                    onTap: propCtrl.applyFilterParameters,
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
      }),
    );
  }
}

filterBox({required String text, double? width, bool selected = false, Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: selected ? Pallet.secondaryColor : Colors.transparent,
          border: Border.all(color: selected ? Colors.white : Colors.black26, width: selected ? 2 : 1),
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 14, fontWeight: selected ? FontWeight.w600 : FontWeight.w500, color: selected ? Colors.white : Colors.black87),
        )),
      ),
    ),
  );
}
