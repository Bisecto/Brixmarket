import 'dart:async';
import 'dart:convert';

import 'package:brixmarket/controllers/property_controller.dart';
import 'package:brixmarket/view/screens/mobile/property_details_page.dart';
import 'package:flutter/material.dart';

import '../../../controllers/instance.dart';
import '../../../core/preloader.dart';
import '../../../models/property_model.dart';
import '../../../models/singleProperty_model.dart'as single;
import 'package:http/http.dart' as http;

import '../../../services/provider.dart';
class Single_Property extends StatefulWidget {
  String property_id;
   Single_Property({Key? key,required this.property_id}) : super(key: key);

  @override
  State<Single_Property> createState() => _Single_PropertyState();
}

class _Single_PropertyState extends State<Single_Property> {



  @override
  void initState() {
    // TODO: implement initState
    print(widget.property_id);
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
          future: propCtrl.fetchSingleProperty(widget.property_id),
          builder: (context, AsyncSnapshot snap) {
            //homeCtrl.property = property;
            if (snap.connectionState == ConnectionState.waiting) {
              return Preloader.loadingWidget();
            } else if(snap.connectionState == ConnectionState.done) {

              //homeCtrl.single_property = properties;
              return  PropertyPageMobile();
            }else{
              return Preloader.loadingWidget();
            }
          }),
    );
  }
}
