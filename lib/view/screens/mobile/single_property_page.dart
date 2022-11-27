import 'dart:async';
import 'dart:convert';

import 'package:brixmarket/controllers/property_controller.dart';
import 'package:brixmarket/view/screens/mobile/property_details_page.dart';
import 'package:brixmarket/view/screens/mobile/single_property_detail.dart';
import 'package:flutter/material.dart';

import '../../../controllers/instance.dart';
import '../../../core/preloader.dart';
import '../../../models/property_model.dart';
import '../../../models/singleProperty_model.dart' as single;
import 'package:http/http.dart' as http;
import 'package:brixmarket/models/single_property_model.dart' as singleProperty;
import '../../../services/provider.dart';
import 'package:brixmarket/adapter/single_property.dart';

class Single_Property extends StatefulWidget {
  String property_tiitle;
  String property_id;

  Single_Property(
      {Key? key, required this.property_id, required this.property_tiitle})
      : super(key: key);

  @override
  State<Single_Property> createState() => _Single_PropertyState();
}

class _Single_PropertyState extends State<Single_Property> {
  StreamController<singleProperty.SinglePropertyModel>
      _singlePropertyStreamController = StreamController.broadcast();

  getSingleProperty(String propertyId) async {
    SinglePropertyApi singlePropertyApi = SinglePropertyApi();
    await singlePropertyApi.get_SingleProperty(propertyId);
    setState(() {
      _singlePropertyStreamController = singlePropertyApi.getSIngleProperty;
      //isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.property_id);
    getSingleProperty(widget.property_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.property_tiitle),
      ),
      body: StreamBuilder<singleProperty.SinglePropertyModel>(
          stream: _singlePropertyStreamController.stream,
          builder: (context, snapdata) {
            //homeCtrl.property = property;
            if (snapdata.connectionState == ConnectionState.waiting) {
              return Preloader.loadingWidget();
            } else {
              //homeCtrl.single_property = properties;
              singleProperty.Property property = snapdata.data!.data.property;
              singleProperty.User user=snapdata.data!.data.property.user;
              return SinglePropertyDetailPage(
                  feature: property.features,
                  images: property.media,
                  price: property.price,
              review: property.reviews,
              property: property,
              location: property.location,
              landMark: '',
              amenities: property.amenities,
              title: property.title,
              property_id: property.id,
              contact: user.phoneNumber,
              userImage: user.image,);
            }
          }),
    );
  }
}
