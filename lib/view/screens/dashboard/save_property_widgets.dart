import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instance.dart';
import '../../../core/preloader.dart';
import '../../../models/property_model.dart';
import '../../../res/strings.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/properties_grid.dart';

class SavedPropertiesWidget extends StatelessWidget {
  final double? constraints;
  const SavedPropertiesWidget({Key? key, this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dashPadding = Get.width * 0.04;
    return Container(
      height: Get.height,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 0),
      child: Scrollbar(
        controller: cPropCtrl.scrollController4,
        isAlwaysShown: true,
        interactive: true,
        child: ListView(
          shrinkWrap: true,
          controller: cPropCtrl.scrollController4,
          padding: EdgeInsets.fromLTRB(dashPadding, 0, dashPadding, 0),
          children: [
            FutureBuilder(
                initialData: propCtrl.mySavedProperties,
                future: propCtrl.getSavedProperties(),
                builder: (context, AsyncSnapshot snap) {
                  List<Property> myProperties = snap.data ?? [];
                  return Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: Column(
                      children: [
                        const CustomText(
                          text: 'My Favorites',
                          color: Colors.black,
                          weight: FontWeight.bold,
                          size: 18,
                        ),
                        const SizedBox(height: 40),
                        const Divider(),
                        snap.connectionState == ConnectionState.waiting && myProperties.isEmpty
                            ? SizedBox(height: Get.height * 0.8, child: Center(child: Preloader.loadingWidget()))
                            : myProperties.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/empty.png'),
                                      TextStyles.richTexts(
                                        decoration: TextDecoration.underline,
                                        onPress1: () {
                                          Get.toNamed(RouteStr.webProperties);
                                        },
                                        size: 16,
                                        text1: 'You don\'t have any property listed. ',
                                        text2: 'Browse List',
                                      )
                                    ],
                                  )
                                : Obx(() => PropertiesGrade(properties: propCtrl.mySavedProperties.value)),
                        const SizedBox(height: 100)
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
