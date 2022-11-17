import 'package:brixmarket/core/app.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme/color.dart';
import '../../controllers/instance.dart';
import '../../models/property_model.dart';
import '../../res/strings.dart';

class PropertyCard1 extends StatelessWidget {
  final Property property;
  final double height;
  final double width;
  const PropertyCard1({Key? key, required this.property, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = property.media!.isNotEmpty ? property.media![0].media! : '';

    return GestureDetector(
      onTap: () {
        homeCtrl.property = property;
        //Get.toNamed(RouteStr.mobileProperty);
      },
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(propertyImgPath + image)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black12, Colors.black87]),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                color: Pallet.secondaryColor,
                child: Text(
                  property.status ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(property.title ?? '',
                  maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 8),
              Text('${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                  maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
              const SizedBox(height: 16),
              Text(Utils.amount(property.price ?? 0), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Pallet.secondaryColor)),
            ]),
          )),
    );
  }
}
