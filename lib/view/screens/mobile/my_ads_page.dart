import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/core/preloader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/edit_controller.dart';
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

class _MyAdsPageState extends State<MyAdsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
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
        title: const Text("My Ads", style: TextStyle(fontSize: 16, color: Pallet.whiteColor, fontWeight: FontWeight.w600)),
        automaticallyImplyLeading: true,
        bottom: TabBar(
          isScrollable: true,
          tabs: Lst.myPropertyTabs,
          controller: _tabController,
          unselectedLabelColor: Pallet.whiteColor,
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.white,
        ),
        bottomOpacity: 1,
      ),
      body: SizedBox(
          height: Get.height * 0.85,
          child: FutureBuilder(
              future: cPropCtrl.getMyProperties(),
              builder: (context, AsyncSnapshot snap) {
                List<Property>? myProperties = snap.data;
                return snap.connectionState == ConnectionState.waiting
                    ? Center(
                        child: Preloader.loadingWidget(),
                      )
                    : Obx(
                        () => TabBarView(
                          controller: _tabController,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            cPropCtrl.myProperties.value.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/empty.PNG'),
                                      TextStyles.richTexts(
                                          decoration: TextDecoration.underline,
                                          onPress1: () => Get.offNamed(RouteStr.mobileCreateProperty),
                                          size: 14,
                                          text1: 'You don\'t have any property listed.\n',
                                          centerText: true,
                                          text2: 'Create a listing')
                                    ],
                                  )
                                : myPropertiesWidget(cPropCtrl.myProperties.value),
                            cPropCtrl.myPublishedProperties.value.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/empty.PNG'),
                                      TextStyles.richTexts(
                                          decoration: TextDecoration.underline,
                                          onPress1: () => Get.offNamed(RouteStr.mobileCreateProperty),
                                          size: 14,
                                          text1: 'You don\'t have any property listed.\n',
                                          text2: 'Create a listing',
                                          centerText: true,
                                          text3: '',
                                          text4: '')
                                    ],
                                  )
                                : myPropertiesWidget(cPropCtrl.myPublishedProperties.value),
                            cPropCtrl.myDraftProperties.value.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/empty.PNG'),
                                      TextStyles.richTexts(
                                          decoration: TextDecoration.underline,
                                          onPress1: () => Get.offNamed(RouteStr.mobileCreateProperty),
                                          size: 14,
                                          text1: 'You don\'t have any property listed. \n',
                                          centerText: true,
                                          text2: 'Create a listing',
                                          text3: '',
                                          text4: '')
                                    ],
                                  )
                                : myPropertiesWidget(cPropCtrl.myDraftProperties.value),
                            cPropCtrl.mySoldProperties.value.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/empty.PNG'),
                                      TextStyles.richTexts(
                                        decoration: TextDecoration.underline,
                                        onPress1: () => Get.offNamed(RouteStr.mobileCreateProperty),
                                        size: 14,
                                        centerText: true,
                                        text1: 'You don\'t have any property listed.\n',
                                        text2: 'Create a listing',
                                      )
                                    ],
                                  )
                                : myPropertiesWidget(cPropCtrl.mySoldProperties.value),
                            cPropCtrl.mySuspendedProperties.value.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/empty.PNG'),
                                      TextStyles.richTexts(
                                          decoration: TextDecoration.underline,
                                          onPress1: () => Get.offNamed(RouteStr.mobileCreateProperty),
                                          size: 14,
                                          centerText: true,
                                          text1: 'You don\'t have any property listed.\n',
                                          text2: 'Create a listing',
                                          text3: '',
                                          text4: '')
                                    ],
                                  )
                                : myPropertiesWidget(cPropCtrl.mySuspendedProperties.value),
                          ],
                        ),
                      );
              })),
    );
  }

  myPropertiesWidget(List<Property> properties) {
    return GestureDetector(
      onTap: () {
        cPropCtrl.showMyPropertyMenu.value = false;
      },
      child: ListView.builder(
          itemCount: properties.length,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
          itemBuilder: ((context, index) {
            Property property = properties[index];
            int iFeature = 0;
            String image = property.media!.isNotEmpty ? property.media![0].media! : '';
            List<Media> images = property.media ?? [];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Material(
                  elevation: 3,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, left: 8, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          propertyImgPath + image,
                                        )))),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                  const Icon(Icons.location_on_outlined, color: Pallet.secondaryColor, size: 16),
                                  const SizedBox(width: 6),
                                  LimitedBox(
                                    maxWidth: Get.width * 0.6,
                                    child: Text('${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 14, overflow: TextOverflow.ellipsis)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              CustomText(color: Pallet.secondaryColor, text: Utils.amount(property.price ?? 0), weight: FontWeight.bold, size: 14),
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
                                  cPropCtrl.showMyPropertyMenuIndex.value = index;

                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                                  child: Icon(Icons.more_vert),
                                ),
                              ),
                            ),
                      Obx(
                        () => Visibility(
                          visible: cPropCtrl.showMyPropertyMenu.value && cPropCtrl.showMyPropertyMenuIndex.value == index,
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
                                    property.publishState == PublishedState.publish
                                        ? propertyAction(
                                            text: 'Edit Property',
                                            icon: Icons.mode_edit_outline_outlined,
                                            onTap: () {
                                              cPropCtrl.completeDraftProperty(property);
                                              //EditCtrl.image8Lists.value.clear();
                                              },
                                          )
                                        : const SizedBox.shrink(),
                                    property.publishState == PublishedState.publish
                                        ? propertyAction(
                                            text: 'Mark Sold',
                                            icon: Icons.sell_outlined,
                                            onTap: () => cPropCtrl.changePublishState(property: property, state: PublishedState.sold),
                                          )
                                        : const SizedBox.shrink(),
                                    property.publishState == PublishedState.sold
                                        ? propertyAction(
                                            text: 'Republish Property',
                                            icon: Icons.published_with_changes,
                                            onTap: () => cPropCtrl.changePublishState(property: property, state: PublishedState.publish),
                                          )
                                        : const SizedBox.shrink(),
                                    property.publishState == PublishedState.draft
                                        ? propertyAction(
                                            text: 'Edit Property',
                                            icon: Icons.mode_edit_outline_outlined,
                                            onTap: (){
                                              //EditCtrl.image8Lists.value.clear();
                                              cPropCtrl.completeDraftProperty(property);

                                            },
                                          )
                                        : const SizedBox.shrink(),
                                    property.publishState == PublishedState.draft
                                        ? propertyAction(
                                            text: 'Delete Property',
                                            color: Colors.red,
                                            icon: Icons.delete_outline,
                                            onTap: () => cPropCtrl.changePublishState(property: property, state: PublishedState.delete),
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
                              color: PublishedState.colors[property.publishState],
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(2), topLeft: Radius.circular(2))),
                        ),
                      ),
                    ],
                  )),
            );
          })),
    );
  }

  propertyAction({required String text, required IconData icon, Color? color, required Function() onTap}) {
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color ?? Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
