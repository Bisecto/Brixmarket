import 'package:brixmarket/core/preloader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/instance.dart';
import '../../../controllers/mobile_app_controllers/homepage_controller.dart';
import '../../../models/property_model.dart';
import '../../widgets/appbar_menus.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/material_search_bar/src/widgets/mobile_app_widgets/property_container.dart';

class SavedPages extends StatefulWidget {
  const SavedPages({Key? key}) : super(key: key);

  @override
  State<SavedPages> createState() => _SavedPagesState();
}

class _SavedPagesState extends State<SavedPages> {
  List<String> propertyID=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
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
            child: const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 14, 0, 14),
              child: Icon(Icons.arrow_back),
            ),
          ),
          title: const CustomText(
            color: Colors.white,
            size: 18,
            text: 'Favourites',
          ),
          actions:  [
            AppBarMenu(
              logout: true,
              myAccount: true,
              //clearSave: true,
              propertyIDS:homeCtrl.user.value.savedProperties!,
            ),
          ],
        ),
        body: FutureBuilder(
            future: propCtrl.getSavedProperties(),
            builder: (context, AsyncSnapshot snap) {
              List<Property> properties = snap.data ?? [];
              return Obx(() => propCtrl.mySavedProperties.value.isEmpty && snap.connectionState == ConnectionState.waiting
                  ? Center(
                      child: Preloader.loadingWidget(),
                    )
                  : propCtrl.mySavedProperties.value.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(child: Image.asset('assets/images/favourite.PNG')),
                            TextStyles.richTexts(
                              centerText: true,
                              color: Colors.blueGrey,
                              decoration: TextDecoration.underline,
                              onPress1: () => Get.find<MobileHomeController>().bottomNavIndex.value = 1,
                              onPress2: () {},
                              size: 16,
                              text1: 'You don\'t have any saved property listed.\n',
                              text2: 'Browse list',
                            )
                          ],
                        )
                      : SizedBox(
                          height: Get.height,
                          child: SizedBox(
                            child: ListView.builder(
                                itemCount: propCtrl.mySavedProperties.value.length,
                                padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 20),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return buildPremiumList(showMore: true, property: propCtrl.mySavedProperties.value[index], borderColor: Colors.grey);
                                }),
                          ),
                        ));
            }),
      ),
    );
  }
}
