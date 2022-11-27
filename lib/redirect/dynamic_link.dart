

import '../core/app.dart';
import '../res/strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/utils.dart';
import 'package:brixmarket/models/single_property_model.dart' as single;
class FirebaseDynamicLinkService {
  static Future<String> createDynamicLink(
      single.Property property,
      String images,
      bool short
      ) async {
    String _linkMessage;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://brixmarket.page.link',

        ///website domain below
        link: Uri.parse('https://brixmarket.com/property?id=${property.id}'),
        androidParameters: AndroidParameters(
          fallbackUrl: Uri.parse(Str.downloadAndroidLink),
          packageName: 'com.brixx.brixmarket',
          minimumVersion: 8,
        ),

        iosParameters: IosParameters(
          fallbackUrl: Uri.parse(Str.downloadIOSLink),
          bundleId: 'com.brixx.brixmarket',
          minimumVersion: '1.0.12',
          appStoreId: '1645681904',
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: '${property.title}\nPrice: ${Utils.amount(property.price)}',
            imageUrl:Uri.parse(propertyImgPath+images.toString())
        )
    );
    Uri url;
    //if (short) {
    print(propertyImgPath+images.toString());
    final ShortDynamicLink shortDynamicLink =
    await parameters.buildShortLink();
    url = shortDynamicLink.shortUrl;
    print('$url+==============================');
    // } else {
    //  url = await parameters.buildUrl();
    // }
    _linkMessage = url.toString();
    print('${property.id}=============++++++++++++++++++++++++++++');
    return _linkMessage;
    //final Uri dynamicUrl = await parameters.buildUrl();
  }
}
