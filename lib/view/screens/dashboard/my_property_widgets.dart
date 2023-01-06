import 'package:brixmarket/core/app.dart';
import 'package:brixmarket/core/preloader.dart';
import 'package:brixmarket/models/media_model.dart';
import 'package:brixmarket/view/widgets/appbar_menus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../models/property_model.dart';
import '../../../res/lists.dart';
import '../../../utils/utils.dart';
import '../../widgets/custom_text.dart';

class MyPropertiesWidget extends StatefulWidget {
  TabController? tabController;
  var provider;

  MyPropertiesWidget({Key? key, this.tabController, this.provider})
      : super(key: key);

  @override
  State<MyPropertiesWidget> createState() => _MyPropertiesWidgetState();
}

class _MyPropertiesWidgetState extends State<MyPropertiesWidget> {
  int totalAllPropertypage = 0;
  int allProperty_singlePage = 1;

  int totalPublishedPropertypage= 0;
  int publishedProperty_singlePage = 1;

  int totalDraftPropertypage = 0;
  int DraftProperty_singlePage = 1;

  int totalSoldPropertypage=0;
  int SoldProperty_singlePage=1;

  int totalSuspendedPropertypage=0;
  int SuspendedProperty_singlePage=1;
  @override
  Widget build(BuildContext context) {
    double dashPadding = Get.width * 0.03;
    widget.tabController = widget.tabController ?? TabController(length: 5, vsync: widget.provider);

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
                            unselectedLabelColor:
                                const Color.fromARGB(255, 27, 23, 23),
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 16),
                            unselectedLabelStyle: const TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 16),
                            indicatorWeight: 2,
                            indicatorColor: Pallet.secondaryColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding: const EdgeInsets.only(top: 16),
                            isScrollable: Get.width <= 600,
                            physics: const BouncingScrollPhysics(),
                            onTap: (int index) {},
                            controller: widget.tabController,
                            tabs: Lst.myPropertyTabs,
                          ),
                        ),
                              Container(
                                      constraints: BoxConstraints(
                                          minHeight: Get.height * 0.5,
                                          maxHeight: Get.height * 0.8),
                                      child: TabBarView(
                                        controller: widget.tabController,
                                        physics: const BouncingScrollPhysics(),
                                        children: [
                                          FutureBuilder(
                                              future: cPropCtrl.getAllMyProperties(allProperty_singlePage),
                                              builder: (context, AsyncSnapshot snap) {
                                                //List<Property> allProperties =cPropCtrl.myProperties; //snap.data ?? [];
                                                // print(allProperties);
                                                if (snap.connectionState == ConnectionState.waiting) {
                                                  return SizedBox(
                                                      height: 48, child: Preloader.loadingWidget());
                                                } else {
                                                  if (cPropCtrl.myProperties.value.isEmpty) {
                                                    return emptyPropertyList();
                                                  } else {
                                                    totalAllPropertypage = cPropCtrl.allPropertiesPage;
                                                    return Column(children: [
                                                      Expanded(child:
                                                      Obx(()=>myPropertiesWidget(cPropCtrl.myProperties))),
                                                      if (totalAllPropertypage > 1)
                                                        Align(
                                                          alignment: Alignment.bottomCenter,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(bottom: 20.0),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceAround,
                                                                children: <Widget>[
                                                                  //  if (allPropertyPage > 1)
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        //_list.removeAt(_curr);
                                                                        if (allProperty_singlePage == 1) {
                                                                        } else {
                                                                          setState(() {
                                                                            allProperty_singlePage--;
                                                                            cPropCtrl.getAllMyProperties(
                                                                                allProperty_singlePage);
                                                                          });
                                                                        }
                                                                      },
                                                                      child:Icon(
                                                                        Icons.arrow_back,
                                                                        size: 40,
                                                                        color: allProperty_singlePage==1 ? Colors.grey:Colors.black,
                                                                      )),
                                                                  // if(allPropertyPage==totalAllPropertypage)
                                                                  // Container()
                                                                  // else
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        if (allProperty_singlePage==totalAllPropertypage
                                                                        )
                                                                        {
                                                                          //return;
                                                                          //MSG.snackBar('End of page',title: 'Message');
                                                                        } else {
                                                                          setState(() {
                                                                            print(totalAllPropertypage);
                                                                            print(allProperty_singlePage);
                                                                            allProperty_singlePage++;
                                                                            // cPropCtrl.getAllMyProperties(
                                                                            //     allPropertyPage);
                                                                          });
                                                                        }

                                                                      },
                                                                      child: Icon(
                                                                          Icons.arrow_forward,
                                                                          size: 40,
                                                                          color:allProperty_singlePage==totalAllPropertypage? Colors.grey:Colors.black
                                                                      ))
                                                                ]),
                                                          ),
                                                        )
                                                    ]);
                                                  }
                                                }
                                              }),
                                          FutureBuilder(
                                              future: cPropCtrl.getAllPublishedProperties(publishedProperty_singlePage),
                                              builder: (context, AsyncSnapshot snap) {
                                                List<Property> allProperties =
                                                    cPropCtrl.myPublishedProperties; //snap.data ?? [];
                                                print(allProperties);
                                                if (snap.connectionState == ConnectionState.waiting) {
                                                  return SizedBox(
                                                      height: 48, child: Preloader.loadingWidget());
                                                } else {
                                                  if (cPropCtrl.myPublishedProperties.value.isEmpty) {
                                                    return emptyPropertyList();
                                                  } else {
                                                    totalPublishedPropertypage =
                                                        cPropCtrl.myPublishedPropertiesPage;
                                                    return Column(children: [
                                                      Expanded(child:
                                                      Obx(()=>myPropertiesWidget(cPropCtrl.myPublishedProperties))),
                                                      if (totalPublishedPropertypage > 1)
                                                        Align(
                                                          alignment: Alignment.bottomCenter,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(bottom: 20.0),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceAround,
                                                                children: <Widget>[
                                                                  //  if (allPropertyPage > 1)
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        //_list.removeAt(_curr);
                                                                        if (publishedProperty_singlePage == 1) {
                                                                        } else {
                                                                          setState(() {
                                                                            publishedProperty_singlePage--;
                                                                            cPropCtrl.getAllMyProperties(
                                                                                publishedProperty_singlePage);
                                                                          });
                                                                        }
                                                                      },
                                                                      child:Icon(
                                                                        Icons.arrow_back,
                                                                        size: 40,
                                                                        color: publishedProperty_singlePage==1 ? Colors.grey:Colors.black,
                                                                      )),
                                                                  // if(allPropertyPage==totalAllPropertypage)
                                                                  // Container()
                                                                  // else
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        if (publishedProperty_singlePage==totalPublishedPropertypage
                                                                        )
                                                                        {
                                                                          //return;
                                                                          //MSG.snackBar('End of page',title: 'Message');
                                                                        } else {
                                                                          setState(() {
                                                                            print(totalPublishedPropertypage);
                                                                            print(publishedProperty_singlePage);
                                                                            publishedProperty_singlePage++;
                                                                            // cPropCtrl.getAllMyProperties(
                                                                            //     allPropertyPage);
                                                                          });
                                                                        }

                                                                      },
                                                                      child: Icon(
                                                                          Icons.arrow_forward,
                                                                          size: 40,
                                                                          color:publishedProperty_singlePage==totalPublishedPropertypage? Colors.grey:Colors.black
                                                                      ))
                                                                ]),
                                                          ),
                                                        )
                                                    ]);
                                                  }
                                                }
                                              }),
                                          FutureBuilder(
                                              future: cPropCtrl.getAllDraftProperties(DraftProperty_singlePage),
                                              builder: (context, AsyncSnapshot snap) {
                                                List<Property> allProperties =
                                                    cPropCtrl.myDraftProperties; //snap.data ?? [];
                                                print(allProperties);
                                                if (snap.connectionState == ConnectionState.waiting) {
                                                  return SizedBox(height: 48, child: Preloader.loadingWidget());
                                                } else {
                                                  if (cPropCtrl.myDraftProperties.value.isEmpty) {
                                                    return emptyPropertyList();
                                                  } else {
                                                    totalDraftPropertypage =
                                                        cPropCtrl.myDraftPropertiesPage;
                                                    return Column(children: [
                                                      Expanded(child:
                                                      Obx(()=>myPropertiesWidget(cPropCtrl.myDraftProperties))),
                                                      if (totalDraftPropertypage > 1)
                                                        Align(
                                                          alignment: Alignment.bottomCenter,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(bottom: 20.0),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceAround,
                                                                children: <Widget>[
                                                                  //  if (allPropertyPage > 1)
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        //_list.removeAt(_curr);
                                                                        if (DraftProperty_singlePage == 1) {
                                                                        } else {
                                                                          setState(() {
                                                                            DraftProperty_singlePage--;
                                                                            cPropCtrl.getAllMyProperties(
                                                                                DraftProperty_singlePage);
                                                                          });
                                                                        }
                                                                      },
                                                                      child:Icon(
                                                                        Icons.arrow_back,
                                                                        size: 40,
                                                                        color: DraftProperty_singlePage==1 ? Colors.grey:Colors.black,
                                                                      )),
                                                                  // if(allPropertyPage==totalAllPropertypage)
                                                                  // Container()
                                                                  // else
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        if (DraftProperty_singlePage==totalDraftPropertypage
                                                                        )
                                                                        {
                                                                          //return;
                                                                          //MSG.snackBar('End of page',title: 'Message');
                                                                        } else {
                                                                          setState(() {
                                                                            print(totalDraftPropertypage);
                                                                            print(DraftProperty_singlePage);
                                                                            DraftProperty_singlePage++;
                                                                            // cPropCtrl.getAllMyProperties(
                                                                            //     allPropertyPage);
                                                                          });
                                                                        }

                                                                      },
                                                                      child: Icon(
                                                                          Icons.arrow_forward,
                                                                          size: 40,
                                                                          color:DraftProperty_singlePage==totalDraftPropertypage? Colors.grey:Colors.black
                                                                      ))
                                                                ]),
                                                          ),
                                                        )
                                                    ]);
                                                  }
                                                }
                                              }),
                                          FutureBuilder(
                                              future: cPropCtrl.getAllSoldProperties(SoldProperty_singlePage),
                                              builder: (context, AsyncSnapshot snap) {
                                                List<Property> allProperties =
                                                    cPropCtrl.mySoldProperties; //snap.data ?? [];
                                                print(allProperties);
                                                if (snap.connectionState == ConnectionState.waiting) {
                                                  return SizedBox(height: 48, child: Preloader.loadingWidget());
                                                } else {
                                                  if (cPropCtrl.mySoldProperties.value.isEmpty) {
                                                    return emptyPropertyList();
                                                  } else {
                                                    totalSoldPropertypage =
                                                        cPropCtrl.mySoldPropertiesPage;
                                                    return Column(children: [
                                                      Expanded(child:
                                                      Obx(()=>myPropertiesWidget(cPropCtrl.mySoldProperties))),
                                                      if (totalSoldPropertypage > 1)
                                                        Align(
                                                          alignment: Alignment.bottomCenter,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(bottom: 20.0),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceAround,
                                                                children: <Widget>[
                                                                  //  if (allPropertyPage > 1)
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        //_list.removeAt(_curr);
                                                                        if (SoldProperty_singlePage == 1) {
                                                                        } else {
                                                                          setState(() {
                                                                            SoldProperty_singlePage--;
                                                                            cPropCtrl.getAllMyProperties(
                                                                                SoldProperty_singlePage);
                                                                          });
                                                                        }
                                                                      },
                                                                      child:Icon(
                                                                        Icons.arrow_back,
                                                                        size: 40,
                                                                        color: SoldProperty_singlePage==1 ? Colors.grey:Colors.black,
                                                                      )),
                                                                  // if(allPropertyPage==totalAllPropertypage)
                                                                  // Container()
                                                                  // else
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        if (SoldProperty_singlePage==totalSoldPropertypage
                                                                        )
                                                                        {
                                                                          //return;
                                                                          //MSG.snackBar('End of page',title: 'Message');
                                                                        } else {
                                                                          setState(() {
                                                                            print(totalSoldPropertypage);
                                                                            print(SoldProperty_singlePage);
                                                                            SoldProperty_singlePage++;
                                                                            // cPropCtrl.getAllMyProperties(
                                                                            //     allPropertyPage);
                                                                          });
                                                                        }

                                                                      },
                                                                      child: Icon(
                                                                          Icons.arrow_forward,
                                                                          size: 40,
                                                                          color:SoldProperty_singlePage==totalSoldPropertypage? Colors.grey:Colors.black
                                                                      ))
                                                                ]),
                                                          ),
                                                        )
                                                    ]);
                                                  }
                                                }
                                              }),
                                          FutureBuilder(
                                              future: cPropCtrl.getAllSuspendedProperties(SuspendedProperty_singlePage),
                                              builder: (context, AsyncSnapshot snap) {
                                                List<Property> allProperties =
                                                    cPropCtrl.mySuspendedProperties; //snap.data ?? [];
                                                print(allProperties);
                                                if (snap.connectionState == ConnectionState.waiting) {
                                                  return SizedBox(height: 48, child: Preloader.loadingWidget());
                                                } else {
                                                  if (cPropCtrl.mySuspendedProperties.value.isEmpty) {
                                                    return emptyPropertyList();
                                                  } else {
                                                    totalSuspendedPropertypage =
                                                        cPropCtrl.mySuspendedPropertiesPage;
                                                    return Column(children: [
                                                      Expanded(child:
                                                      Obx(()=>myPropertiesWidget(cPropCtrl.mySuspendedProperties))),
                                                      if (totalSuspendedPropertypage > 1)
                                                        Align(
                                                          alignment: Alignment.bottomCenter,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(bottom: 20.0),
                                                            child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceAround,
                                                                children: <Widget>[
                                                                  //  if (allPropertyPage > 1)
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        //_list.removeAt(_curr);
                                                                        if (SuspendedProperty_singlePage == 1) {
                                                                        } else {
                                                                          setState(() {
                                                                            SuspendedProperty_singlePage--;
                                                                            cPropCtrl.getAllMyProperties(
                                                                                SuspendedProperty_singlePage);
                                                                          });
                                                                        }
                                                                      },
                                                                      child:Icon(
                                                                        Icons.arrow_back,
                                                                        size: 40,
                                                                        color: SuspendedProperty_singlePage==1 ? Colors.grey:Colors.black,
                                                                      )),
                                                                  // if(allPropertyPage==totalAllPropertypage)
                                                                  // Container()
                                                                  // else
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        if (SuspendedProperty_singlePage==totalSuspendedPropertypage
                                                                        )
                                                                        {
                                                                          //return;
                                                                          //MSG.snackBar('End of page',title: 'Message');
                                                                        } else {
                                                                          setState(() {
                                                                            print(totalSuspendedPropertypage);
                                                                            print(SuspendedProperty_singlePage);
                                                                            SuspendedProperty_singlePage++;
                                                                            // cPropCtrl.getAllMyProperties(
                                                                            //     allPropertyPage);
                                                                          });
                                                                        }

                                                                      },
                                                                      child: Icon(
                                                                          Icons.arrow_forward,
                                                                          size: 40,
                                                                          color:SuspendedProperty_singlePage==totalSuspendedPropertypage? Colors.grey:Colors.black
                                                                      ))
                                                                ]),
                                                          ),
                                                        )
                                                    ]);
                                                  }
                                                }
                                              }),
                                        ],
                                      )
                                          // TabBarView(
                                          //   controller: tabController,
                                          //   physics:
                                          //       const BouncingScrollPhysics(),
                                          //   children: [
                                          //     cPropCtrl.myProperties.value
                                          //             .isEmpty
                                          //         ? emptyPropertyList()
                                          //         : myPropertiesListWidget(
                                          //             cPropCtrl
                                          //                 .myProperties.value),
                                          //     cPropCtrl.myPublishedProperties
                                          //             .isEmpty
                                          //         ? emptyPropertyList()
                                          //         : myPropertiesListWidget(
                                          //             cPropCtrl
                                          //                 .myPublishedProperties
                                          //                 .value),
                                          //     cPropCtrl
                                          //             .myDraftProperties.isEmpty
                                          //         ? emptyPropertyList()
                                          //         : myPropertiesListWidget(
                                          //             cPropCtrl
                                          //                 .myDraftProperties
                                          //                 .value),
                                          //     cPropCtrl.mySoldProperties.isEmpty
                                          //         ? emptyPropertyList()
                                          //         : myPropertiesListWidget(
                                          //             cPropCtrl.mySoldProperties
                                          //                 .value),
                                          //     cPropCtrl.mySuspendedProperties
                                          //             .isEmpty
                                          //         ? emptyPropertyList()
                                          //         : myPropertiesListWidget(
                                          //             cPropCtrl
                                          //                 .mySuspendedProperties
                                          //                 .value),
                                          //   ],
                                          // )
                                      )

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

Widget myPropertiesWidget(List<Property> myProperties) {
  return ListView.builder(
      itemCount: myProperties.length,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02, vertical: 20),
      itemBuilder: ((context, index) {
        Property property = myProperties[index];
        String image;
            //property.media!.isNotEmpty ? property.media![0].media! : '';
        List<Media> images = property.media ?? [];
        if(images.isEmpty){
          image='';
          print('Image is empty');
        }else{
          image=property.media![0].media!;
        }        return Column(
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
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                propertyImgPath + image)))),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.location_on_outlined,
                                              color: Pallet.secondaryColor,
                                              size: 14),
                                          const SizedBox(width: 8),
                                          SizedBox(
                                            width: Get.width * 0.25 + 55,
                                            child: Text(
                                              '${property.location?.address}, ${property.location?.city}, ${property.location?.state}',
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
                                  CustomText(
                                      color: Pallet.secondaryColor,
                                      text: Utils.amount(property.price!),
                                      weight: FontWeight.w700,
                                      size: 16),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: CustomText(
                                      color: Colors.blueGrey[500],
                                      text: property.priceDuration!
                                                  .substring(0, 3) ==
                                              'Per'
                                          ? property.priceDuration!
                                              .toUpperCase()
                                          : '',
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
