import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:brixmarket/view/widgets/material_search_bar/src/widgets/mobile_app_widgets/property_container.dart';
import 'package:flutter/material.dart';

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
      body: FutureBuilder(
          future: propCtrl.getProperties(),
          builder: (context, AsyncSnapshot snap) {
            List<Property> properties = snap.data ?? [];
            return snap.connectionState == ConnectionState.waiting
                ? Preloader.loadingWidget()
                :
            ListView.builder(
                itemCount: 1,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Property property = properties[index];
                  if (property.id==widget.proertyID) {
                    return
                      buildPremiumList(
                          showMore: true, property: property, home2: true);
                  } else {
                    return Container(
                      child: TextStyles.richTexts(
                        decoration: TextDecoration.underline,
                        onPress1: () {
                          Navigator.pop(context);
                          //Get.toNamed(RouteStr.webProperties);
                        },
                        size: 16,
                        text1: 'The property you requested for is no longer available',
                        text2: 'Browse List',
                      ),
                    );
                  }
                });
          }),
    );
  }
}
