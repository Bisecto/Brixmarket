import 'package:brixmarket/view/screens/mobile/property_details_page.dart';
import 'package:flutter/material.dart';

import '../../../controllers/instance.dart';
import '../../../core/preloader.dart';
import '../../../models/property_model.dart';

class Single_Property extends StatelessWidget {
  String property_id;
   Single_Property({Key? key,required this.property_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
          future: propCtrl.getSingleproperty2(property_id),
          builder: (context, AsyncSnapshot snap) {

            //homeCtrl.property = property;

            if (snap.connectionState == ConnectionState.waiting) {
              return Preloader.loadingWidget();
            } else {
              homeCtrl.property = snap.data;
              return const PropertyPageMobile();
            }
          }),
    );
  }
}
