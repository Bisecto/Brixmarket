import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme/color.dart';
import '../../controllers/edit_controller.dart';
import '../../controllers/instance.dart';
import '../../res/lists.dart';
import '../../utils/utils.dart';
import '../screens/mobile/explore_filter_page.dart';
import 'drop_down.dart';
import 'form_inputs.dart';

class WebHeroSearch extends StatelessWidget {
// class WebHeroSearch extends StatefulWidget {
//   const WebHeroSearch({Key? key}) : super(key: key);
//
//   @override
//   State<WebHeroSearch> createState() => _WebHeroSearchState();
// }
//
// class _WebHeroSearchState extends State<WebHeroSearch> {
  late OverlayEntry entry;
  final layerLink = LayerLink();

  WebHeroSearch({Key? key}) : super(key: key);

  // @override
  // void initState() {
  //   super.initState();
  // }

  showOverlayFilterBox(BuildContext context) {
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    // final offSet = renderBox.localToGlobal(Offset.zero);

    entry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(link: layerLink, showWhenUnlinked: false, offset: Offset(0, size.height + 2), child: buildOverlay()),
      ),
    );
    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Container(
        height: isTabletDown() ? 48 : 62,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Expanded(
                child: FormInput(
              topSpace: false,
              borderColor: Colors.white,
              width: double.infinity,
              controller: EditCtrl.webSearchKeyWord,
              color: Colors.white,
              height: isTabletDown() ? 48 : 62,
              hint: 'Enter key word here...',
            )),
            isTabletDown()
                ? const SizedBox.shrink()
                : Expanded(
                    child: DropDown(
                      borderRadius: 0,
                      dropIconColor: Colors.red,
                      height: isTabletDown() ? 48 : 62,
                      color: Colors.white,
                      showLabel: false,
                      labelColor: Colors.black54,
                      controller: EditCtrl.filterState,
                      label: 'Location',
                      items: Lst.ngStates,
                    ),
                  ),
            isMobile()
                ? const SizedBox.shrink()
                : Expanded(
                    child: DropDown(
                      borderRadius: 0,
                      borderColor: Colors.white,
                      dropIconColor: Colors.red,
                      height: isTabletDown() ? 48 : 62,
                      color: Colors.white,
                      showLabel: false,
                      labelColor: Colors.black54,
                      controller: EditCtrl.filterCategoriesWeb,
                      label: 'Category',
                      items: Lst.propertyCategories,
                    ),
                  ),
            GestureDetector(
              onTap: () {
                if (propCtrl.showLargeFilerBox.value) {
                  propCtrl.showLargeFilerBox.value = false;
                  WidgetsBinding.instance!.addPostFrameCallback((_) => showOverlayFilterBox(context));
                } else {
                  propCtrl.showLargeFilerBox.value = true;
                  try {
                    entry.remove();
                  } catch (e) {
                    dnd(e);
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 18),
                child: Image.asset(
                  'assets/images/filter.png',
                  color: Pallet.secondaryColor,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                propCtrl.showLargeFilerBox.value = true;
                propCtrl.setAllPropertiesWeb(filter: true);
                try {
                  entry.remove();
                } catch (e) {
                  dnd(e);
                }
              },
              child: Container(
                width: isMobile()
                    ? isTabletDown()
                        ? 48
                        : 62
                    : 120,
                height: isTabletDown() ? 48 : 62,
                decoration: const BoxDecoration(
                  color: Pallet.secondaryColor,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(4), topRight: Radius.circular(4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isMobile() ? const SizedBox.shrink() : const Text('Search', style: TextStyle(color: Colors.white, fontSize: 18)),
                    isMobile() ? const SizedBox.shrink() : const SizedBox(width: 8),
                    const Icon(Icons.search, color: Colors.white),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildOverlay() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      elevation: 16,
      child: Container(
        height: 320,
        margin: const EdgeInsets.only(bottom: 8),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Wrap(children: [
              Column(
                children: [
                  const Text('Price', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DropDown(
                          width: isTabletDown() ? Get.width * 0.3 : Get.width * 0.15,
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
                          width: isTabletDown() ? Get.width * 0.3 : Get.width * 0.15,
                          color: Colors.white10,
                          showLabel: false,
                          controller: EditCtrl.priceMax,
                          label: 'Max',
                          items: Lst.maxFilterPrices,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Wrap(
                    alignment: WrapAlignment.spaceAround,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Obx(() => filterBox(
                            text: 'Any',
                            width: isMobile() ? 140 : 160,
                            selected: EditCtrl.filterTypes.contains('Any'),
                            onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'type', item: 'Any'),
                          )),
                      ...Lst.propertyTypes
                          .map((e) => Obx(() => filterBox(
                                text: e,
                                width: isMobile() ? 140 : 160,
                                selected: EditCtrl.filterTypes.contains(e),
                                onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'type', item: e),
                              )))
                          .toList(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Status', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Wrap(
                    alignment: WrapAlignment.spaceAround,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Obx(() => filterBox(
                            text: 'Any',
                            width: isMobile() ? 140 : 160,
                            selected: EditCtrl.filterStatus.contains('Any'),
                            onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'status', item: 'Any'),
                          )),
                      ...Lst.propertyStatus
                          .map((e) => Obx(() => filterBox(
                                text: e,
                                width: Get.width * 0.115,
                                selected: EditCtrl.filterStatus.contains(e),
                                onTap: () => propCtrl.toggleSelectedFilterBox(filter: 'status', item: e),
                              )))
                          .toList(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Amenities', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 8),
                  Wrap(alignment: WrapAlignment.spaceAround, children: [
                    SizedBox(
                      width: isMobile() ? 140 : 160,
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
                    ...propCtrl.allAmenities
                        .map((e) => Container(
                              width: isMobile() ? 140 : 160,
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
                                  Expanded(child: Text(e['amenity'], style: const TextStyle(fontSize: 12))),
                                ],
                              ),
                            ))
                        .toList(),
                  ]),
                  const SizedBox(height: 16),
                  const Text('Rooms', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DropDown(
                          width: isTabletDown() ? Get.width * 0.3 : Get.width * 0.15,
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
                          width: isTabletDown() ? Get.width * 0.3 : Get.width * 0.15,
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
                          width: isTabletDown() ? Get.width * 0.3 : Get.width * 0.15,
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
                          width: isTabletDown() ? Get.width * 0.3 : Get.width * 0.15,
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
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
