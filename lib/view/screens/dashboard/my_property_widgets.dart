import 'package:brixmarket/core/app.dart';
import 'package:brixmarket/core/preloader.dart';
import 'package:brixmarket/view/widgets/appbar_menus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../models/property_model.dart';
import '../../../res/lists.dart';
import '../../../utils/utils.dart';
import '../../widgets/custom_text.dart';

class MyPropertiesWidget extends StatelessWidget {
  TabController? tabController;
  var provider;
  MyPropertiesWidget({Key? key, this.tabController, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dashPadding = Get.width * 0.03;
    tabController = tabController ?? TabController(length: 5, vsync: provider);

    return SizedBox(
      height: Get.height,
      width: double.infinity,
      child: Scrollbar(
        controller: cPropCtrl.scrollController3,
        isAlwaysShown: true,
        interactive: true,
        child: ListView(
          padding: EdgeInsets.fromLTRB(dashPadding, 0, dashPadding, 0),
          shrinkWrap: true,
          controller: cPropCtrl.scrollController3,
          children: [
            const SizedBox(height: 32),
            const CustomText(
              text: 'My Ads',
              color: Colors.black,
              weight: FontWeight.bold,
              size: 18,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              child: Material(
                  elevation: 5,
                  type: MaterialType.card,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.black12,
                          child: TabBar(
                            labelColor: const Color.fromARGB(255, 27, 23, 23),
                            unselectedLabelColor: const Color.fromARGB(255, 27, 23, 23),
                            labelStyle: const TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
                            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w200, fontSize: 16),
                            indicatorWeight: 2,
                            indicatorColor: Pallet.secondaryColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding: const EdgeInsets.only(top: 16),
                            isScrollable: Get.width <= 600,
                            physics: const BouncingScrollPhysics(),
                            onTap: (int index) {},
                            controller: tabController,
                            tabs: Lst.myPropertyTabs,
                          ),
                        ),
                        FutureBuilder(
                            initialData: cPropCtrl.myProperties.value,
                            future: cPropCtrl.getMyProperties(),
                            builder: (context, AsyncSnapshot snap) {
                              List<Property>? myProperties = snap.data;
                              return snap.connectionState == ConnectionState.waiting && !snap.hasData
                                  ? SizedBox(height: Get.height * 0.6, child: Center(child: Preloader.loadingWidget()))
                                  : Container(
                                      constraints: BoxConstraints(minHeight: Get.height * 0.5, maxHeight: Get.height * 0.8),
                                      child: Obx(() => TabBarView(
                                            controller: tabController,
                                            physics: const BouncingScrollPhysics(),
                                            children: [
                                              cPropCtrl.myProperties.value.isEmpty ? emptyPropertyList() : myPropertiesListWidget(cPropCtrl.myProperties.value),
                                              cPropCtrl.myPublishedProperties.isEmpty
                                                  ? emptyPropertyList()
                                                  : myPropertiesListWidget(cPropCtrl.myPublishedProperties.value),
                                              cPropCtrl.myDraftProperties.isEmpty ? emptyPropertyList() : myPropertiesListWidget(cPropCtrl.myDraftProperties.value),
                                              cPropCtrl.mySoldProperties.isEmpty ? emptyPropertyList() : myPropertiesListWidget(cPropCtrl.mySoldProperties.value),
                                              cPropCtrl.mySuspendedProperties.isEmpty
                                                  ? emptyPropertyList()
                                                  : myPropertiesListWidget(cPropCtrl.mySuspendedProperties.value),
                                            ],
                                          )));
                            })
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 48)
          ],
        ),
      ),
    );
  }
}

emptyPropertyList() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset('assets/images/empty.png'),
      TextStyles.richTexts(
        decoration: TextDecoration.underline,
        onPress1: () {
          cPropCtrl.onSelected(1);
        },
        size: 14,
        text1: 'You don\'t have any property listed. ',
        text2: ' Create a listing',
      )
    ],
  );
}

Widget myPropertiesListWidget(List<Property> myProperties) {
  return ListView.builder(
      itemCount: myProperties.length,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: 20),
      itemBuilder: ((context, index) {
        Property property = myProperties[index];
        String image = property.media!.isNotEmpty ? property.media![0].media! : '';
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(propertyImgPath + image)))),
                            SizedBox(
                              width: Get.width * 0.01,
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              SizedBox(
                                width: Get.width * 0.3 + 55,
                                child: Text(
                                  '${property.title},',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_on_outlined, color: Pallet.secondaryColor, size: 14),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: Get.width * 0.25 + 55,
                                    child: Text(
                                      '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                      maxLines: 3,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ]),
                        ),
                        isMobile()
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(color: Pallet.secondaryColor, text: Utils.amount(property.price!), weight: FontWeight.w700, size: 16),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: CustomText(
                                      color: Colors.blueGrey[500],
                                      text: property.priceDuration!.substring(0, 3) == 'Per' ? property.priceDuration!.toUpperCase() : '',
                                      weight: FontWeight.w600,
                                      size: 10,
                                    ),
                                  ),
                                ],
                              ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       width: 84,
                        //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        //       decoration: BoxDecoration(
                        //         color: property.status == 'New' ? Colors.green[50] : Colors.red[50],
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //       child: Text(
                        //         property.status!,
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(color: property.status == 'New' ? Colors.green : Colors.red),
                        //       ),
                        //     ),
                        //     CustomText(
                        //       text: property.createdAt,
                        //       color: Colors.black,
                        //       weight: FontWeight.w300,
                        //       size: 12,
                        //     ),
                        //   ],
                        // ),
                        // Expanded(
                        //   child: property.publishState == PublishedState.publish
                        //       ? InkWell(
                        //           child: Align(
                        //           alignment: Alignment.topRight,
                        //           child: FormButton(
                        //             onPressed: () => cPropCtrl.changePublishState(property: property, state: PublishedState.sold),
                        //             text: 'Mark Sold',
                        //             txtColor: Colors.black,
                        //             bgColor: Colors.red[100],
                        //             width: 84,
                        //             height: 32,
                        //             size: 12,
                        //             top: 0,
                        //             radius: 16,
                        //           ),
                        //         ))
                        //       : property.publishState == PublishedState.draft
                        //           ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        //               InkWell(
                        //                 onTap: () => cPropCtrl.completeDraftProperty(property),
                        //                 child: const CircleAvatar(
                        //                   radius: 16,
                        //                   backgroundColor: Colors.grey,
                        //                   child: Icon(
                        //                     Icons.edit_note,
                        //                     color: Colors.white,
                        //                     size: 16,
                        //                   ),
                        //                 ),
                        //               ),
                        //               const SizedBox(width: 8),
                        //               InkWell(
                        //                   onTap: () => cPropCtrl.changePublishState(property: property, state: PublishedState.delete),
                        //                   child: const CircleAvatar(
                        //                     radius: 16,
                        //                     backgroundColor: Colors.red,
                        //                     child: Icon(
                        //                       Icons.delete_outline,
                        //                       color: Colors.white,
                        //                       size: 16,
                        //                     ),
                        //                   ))
                        //             ])
                        //           : property.publishState == PublishedState.sold
                        //               ? InkWell(
                        //                   child: Align(
                        //                   alignment: Alignment.topRight,
                        //                   child: FormButton(
                        //                     onPressed: () => cPropCtrl.changePublishState(property: property, state: PublishedState.publish),
                        //                     text: 'Republish',
                        //                     txtColor: Colors.black,
                        //                     bgColor: Colors.green[100],
                        //                     width: 84,
                        //                     height: 32,
                        //                     size: 12,
                        //                     top: 0,
                        //                     radius: 16,
                        //                   ),
                        //                 ))
                        //               : Container(),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: isMobile() ? 0 : Get.width * 0.02,
                  ),
                  MyPropertyMenu(
                    property: property,
                    markSold: property.publishState == PublishedState.publish,
                    republish: property.publishState == PublishedState.sold,
                    edit: property.publishState != PublishedState.suspended,
                    delete: property.publishState != PublishedState.suspended,
                  )
                ],
              ),
            ),
            const Divider(color: Colors.black12),
            const SizedBox(height: 12),
          ],
        );
      }));
}
