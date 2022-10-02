import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:brixmarket/view/widgets/material_search_bar/src/widgets/mobile_app_widgets/property_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'controllers/instance.dart';
import 'core/preloader.dart';
import 'models/property_model.dart';

class Testing extends StatefulWidget {
  String proertyID;

  Testing({Key? key, required this.proertyID}) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Brixmarket'),
      ),
      body: Container(
        child: FutureBuilder(
            future: propCtrl.getProperties(),
            builder: (context, AsyncSnapshot snap) {
              List<Property> properties = snap.data ?? [];
              // property.title!.trim().toLowerCase().contains(
              //     SearchValue.trim().toLowerCase())

              return snap.connectionState == ConnectionState.waiting
                  ? Preloader.loadingWidget()
                  :  ListView.builder(
                  itemCount: properties.length,
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 20),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          const SizedBox(height: 16),
                          const Align(
                              alignment: Alignment.topLeft,
                              child: CustomText(
                                  color: Colors.blueGrey,
                                  text: 'Property',
                                  weight: FontWeight.bold,
                                  size: 16)),
                          const Divider(color: Colors.black12),
                          propCtrl.exploreFilterProperties.isEmpty
                              ? Column(children: [
                            SizedBox(
                              height: Get.height * 0.2,
                            ),
                            const CustomText(
                                color: Colors.blueGrey,
                                text: 'No Results Found or property is no longer avaiable',
                                weight: FontWeight.w400,
                                size: 18),
                            const SizedBox(height: 10),
                          ])
                              : const SizedBox.shrink(),
                        ],
                      );
                    } else {
                      if (properties[index].id
                          ==widget.proertyID) {
                        return buildPremiumList(
                            showMore: true,
                            property: properties[index]);
                      } else {
                        return Container();
                      }
                    }
                  });
            }),
      )
    );
  }
}
