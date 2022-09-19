import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../controllers/mobile_app_controllers/homepage_controller.dart';
import '../../../core/app.dart';
import '../../../core/preloader.dart';
import '../../../models/media_model.dart';
import '../../../models/property_model.dart';
import '../../../res/strings.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/material_search_bar/src/widgets/mobile_app_widgets/property_container.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
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
            onTap: () => Get.find<MobileHomeController>().bottomNavIndex.value = 0,
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
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(RouteStr.mobileExploreFilter);
              },
              child: Padding(padding: const EdgeInsets.only(right: 12.0), child: Image.asset('assets/images/filter.png')),
            )
          ],
        ),
        body: SizedBox(
          height: Get.height,
          child: SizedBox(
            child: FutureBuilder(
                future: propCtrl.getProperties(navItem: 0),
                builder: (context, AsyncSnapshot snap) {
                  List<Property> properties = snap.data ?? [];

                  return Obx(() => propCtrl.showFeatureLoading.value
                      ? Preloader.loadingWidget()
                      : ListView.builder(
                          itemCount: propCtrl.exploreFilterProperties.length + 1,
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 20),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return index == 0
                                ? Column(
                                    children: [
                                      const SizedBox(height: 16),
                                      const Align(
                                          alignment: Alignment.topLeft,
                                          child: CustomText(color: Colors.blueGrey, text: 'Filter Results', weight: FontWeight.bold, size: 16)),
                                      const Divider(color: Colors.black12),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                        child: Image.asset('assets/images/banner-one.jpg'),
                                      ),
                                      propCtrl.exploreFilterProperties.isEmpty
                                          ? Column(children: [
                                              SizedBox(
                                                height: Get.height * 0.2,
                                              ),
                                              const CustomText(color: Colors.blueGrey, text: 'No Results Found', weight: FontWeight.w400, size: 18),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Adjust your filter parameter to find a property',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w400, fontSize: 16),
                                              )
                                            ])
                                          : const SizedBox.shrink(),
                                    ],
                                  )
                                : buildPremiumList(showMore: true, property: propCtrl.exploreFilterProperties[index - 1]);
                          }));
                }),
          ),
        ),
      ),
    );
  }
}

List<String> imageList = [
  'assets/images/bedroom2.jpg',
  'assets/images/bedroom.jpg',
  'assets/images/bedroom3.jpg',
  'assets/images/bedroom4.jpg',
  'assets/images/room1.jpg',
  'assets/images/home_bg1.jpg'
];

class ExploreGallery extends StatelessWidget {
  ExploreGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallet.homeBackground,
        appBar: AppBar(
          backgroundColor: Pallet.secondaryColor,
          automaticallyImplyLeading: true,
          title: const CustomText(
            color: Colors.white,
            size: 18,
            text: 'Gallery',
          ),
        ),
        body: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(12),
            itemCount: imageList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 180,
            ),
            itemBuilder: (_, index) => Hero(
                  tag: '$index',
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        () => FullGalleryScreen(
                          index: index,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(image: AssetImage(imageList[index]), fit: BoxFit.cover)),
                    ),
                  ),
                )));
  }
}

class FullGalleryScreen extends StatelessWidget {
  FullGalleryScreen({Key? key, required this.index}) : super(key: key);

  int i = 0;
  final int index;
  late PageController _controller;
  late List<Media> images;
  @override
  Widget build(BuildContext context) {
    Property property = propCtrl.property;
    images = property.media ?? [];
    _controller = PageController(initialPage: 0);
    propCtrl.currentIndex.value = images[0].media ?? '';
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
                            child: Image.network(propertyImgPath + e.media!),
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white.withOpacity(0.6)),
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white.withOpacity(0.4)),
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
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.2)),
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
                              border: Border.all(color: propCtrl.currentIndex.value == e.media ? Pallet.secondaryColor : Colors.grey),
                              image: DecorationImage(image: NetworkImage(propertyImgPath + e.media!), fit: BoxFit.cover),
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
    propCtrl.currentIndex.value = images[_controller.page!.toInt() + 1].media ?? '';
    _controller.animateToPage(_controller.page!.toInt() + 1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void previousPage() {
    propCtrl.currentIndex.value = images[_controller.page!.toInt() - 1].media ?? '';
    _controller.animateToPage(_controller.page!.toInt() - 1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
