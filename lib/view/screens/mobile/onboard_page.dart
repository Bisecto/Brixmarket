import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../models/mobile_models/slide.dart';
import '../../../res/strings.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      body: onBoardingBody(),
    );
  }

  Widget onBoardingBody() => const OnBoardingLayoutView();
}

class OnBoardingLayoutView extends StatefulWidget {
  const OnBoardingLayoutView({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _OnBoardingLayoutView();
}

class _OnBoardingLayoutView extends State<OnBoardingLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) => sliderLayout();

  Widget sliderLayout() {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemCount: sliderArrayList.length,
      itemBuilder: (ctx, i) => slideItem(i),
    );
  }

  void nextPage() {
    if (_pageController.page != null) {
      _pageController.animateToPage(_pageController.page!.toInt() + 1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  Widget slideItem(int index) {
    return ListView(
      shrinkWrap: true,
      children: [
        Stack(
          children: [
            Container(
              height: Get.height,
              width: double.infinity,
              decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage(sliderArrayList[index].sliderImageUrl))),
            ),
            Container(
              height: Get.height,
              width: double.infinity,
              color: Colors.black.withOpacity(0.6),
            ),
            Positioned(
                bottom: 48,
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24.0, bottom: Get.width * 0.4, right: Get.width * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sliderArrayList[index].sliderTopSubHeading.toUpperCase(),
                              style: const TextStyle(fontStyle: FontStyle.normal, color: Pallet.secondaryColor, fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              sliderArrayList[index].sliderHeading,
                              style: const TextStyle(fontStyle: FontStyle.normal, color: Colors.white, fontSize: 38, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          sliderArrayList[index].sliderSubHeading,
                          style: const TextStyle(fontStyle: FontStyle.normal, fontSize: 16, color: Pallet.whiteColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                buildDots(index: 0),
                                const SizedBox(width: 8),
                                buildDots(index: 1),
                                const SizedBox(width: 8),
                                buildDots(index: 2),
                              ],
                            ),
                            inFinalPage()
                                ? GestureDetector(
                                    onTap: () {
                                      Get.offAndToNamed(RouteStr.mobileLanding);
                                    },
                                    child: Container(
                                      height: 42,
                                      width: 42,
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Pallet.secondaryColor),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      nextPage();
                                    },
                                    child: Text(
                                      sliderArrayList[index].skipBtn,
                                      style: const TextStyle(fontStyle: FontStyle.normal, fontSize: 20, color: Pallet.secondaryColor, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ],
    );
  }

  buildDots({int? index, double? width}) {
    return AnimatedContainer(
      height: 9,
      width: index == _currentPage ? 20 : 9,
      decoration: BoxDecoration(color: index == _currentPage ? Pallet.secondaryColor : Colors.white, borderRadius: BorderRadius.circular(30)),
      duration: const Duration(milliseconds: 1000),
    );
  }

  bool inFinalPage() {
    if (_currentPage == sliderArrayList.length - 1) {
      return true;
    }
    return false;
  }
}
