import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:brixmarket/controllers/home_controller.dart';
import 'package:brixmarket/models/property_model.dart';
import 'package:brixmarket/models/user_model.dart';
import 'package:brixmarket/utils/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:universal_io/io.dart';

import '../config/theme/color.dart';
import '../controllers/instance.dart';
import '../core/app.dart';
import '../res/strings.dart';
import '../services/provider.dart';
import '../view/screens/mobile/landing_page.dart';
import '../view/widgets/custom_text.dart';
import 'device_info.dart';

class Utils {
  static int count = 0;
  static final NumberFormat numberFormat = NumberFormat("#,##0", "en_US");

  static bool isMobileApp = !kIsWeb; // && !Platform.isWindows;
  static final bool userFirebase = !Platform.isWindows && false;

  static int getTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String reference() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(4);
  }

  static String amount(amount) {
    var f = NumberFormat('#,##0', 'en_US');
    try {
      amount = int.parse(amount.toString());
      return '₦' + f.format(amount);
    } catch (e) {
      return '₦ 0.00';
    }
  }

  static String stringToDate(String datetime) {
    var date = DateTime.parse(datetime);
    return DateFormat('y-m-d').format(date);
  }

  static String formatDateTime(time) {
    var timeNow = DateTime.now();
    dynamic timeToFormat;

    if (time.runtimeType == String) {
      timeToFormat = DateTime.parse(time);
    } else if (time.runtimeType == int) {
      timeToFormat = DateTime.fromMillisecondsSinceEpoch(time);
    }

    var yearN = DateFormat('y').format(timeNow);
    var dayN = DateFormat('d').format(timeNow);

    var yearT = DateFormat('y').format(timeToFormat);
    var dayT = DateFormat('d').format(timeToFormat);

    if (yearN != yearT) {
      return DateFormat('d MMM y, h:ma').format(timeToFormat);
    } else if (dayN != dayT) {
      return DateFormat('d MMM, h:ma').format(timeToFormat);
    } else {
      return DateFormat('h:ma').format(timeToFormat);
    }
  }

  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) return false;
    return hasMatch(s, r'^(?:[+0][1-9])?[0-9]{10,12}$');
  }

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static Future initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = DeviceInfo.readWebBrowserInfo(
            await DeviceInfo.deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData = DeviceInfo.readAndroidBuildData(
              await DeviceInfo.deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          deviceData = DeviceInfo.readIosDeviceInfo(
              await DeviceInfo.deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          deviceData = DeviceInfo.readLinuxDeviceInfo(
              await DeviceInfo.deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          deviceData = DeviceInfo.readMacOsDeviceInfo(
              await DeviceInfo.deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          deviceData = DeviceInfo.readWindowsDeviceInfo(
              await DeviceInfo.deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    return deviceData;
  }

  static authInputWidth(width) {
    return width <= 870
        ? (width <= 600 && width >= 480 ? 210.0 : 430.0)
        : 210.0;
  }

  static imagePicker(File? imageFile) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
    }
    return imageFile;
  }

  // static Future<File> filePicker() async {
  //   File? imageFile;
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     imageFile = File(result.files.single.path!);
  //   }
  //   return imageFile ?? File('');
  // }

  static Future<List<File>> filesPicker2() async {
    dynamic imageFiles;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      dialogTitle: 'Multiple selection is allowed',
      type: FileType.image,
    );
    try {
      if (result != null) {
        imageFiles = result.paths.map((path) => File(path!)).toList();
      }
    } catch (e) {
      dnd(e);
    }
    return imageFiles ?? [];
  }

  static Future<List<Uint8List?>> filesPicker() async {
    List<Uint8List?> imageFiles = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      dialogTitle: 'Multiple selection is allowed',
      type: FileType.image,
    );
    if (result != null) {
      imageFiles = result.files.map((file) => file.bytes).toList();
      if (imageFiles[0] == null) {
        imageFiles =
            result.paths.map((path) => File(path!).readAsBytesSync()).toList();
      }
    }
    return imageFiles;
  }

  static Future<Uint8List> singleFilePicker() async {
    Uint8List? imageFiles;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      dialogTitle: 'Select an image',
      type: FileType.image,
    );
    if (result != null) {
      imageFiles = result.files.first.bytes;
      imageFiles ??= await File(result.paths.first!).readAsBytes();
    }
    return imageFiles ?? Uint8List(0);
  }

  // static Future<File> imgUrlToFileIO(String imgUrl) async {
  //   var i = Random();
  //   Directory tmpDir = await getTemporaryDirectory();
  //   String tmpPath = tmpDir.path;
  //   File file = File(tmpPath + (i.nextInt(100)).toString() + '.jpg');
  //   http.Response response = await http.get(Uri.parse(imgUrl));
  //
  //   await file.writeAsBytes(response.bodyBytes);
  //   return file;
  // }

  static Future<Uint8List> imgUrlToFile(String imgUrl) async {
    http.Response response = await http.get(Uri.parse(imgUrl));
    return response.bodyBytes;
  }

  static Widget savedPropertyIcon(propertyId,
      {double size = 18.0, user, Color? color, required List state}) {
    if (state.contains(propertyId)) {
      return Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Pallet.secondaryColor.withOpacity(0.2),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(6)),
          child: Image.asset(ImgStr.loadingLove1, height: size, width: size));
    }
    if (homeCtrl.user.value.savedProperties != null) {
      if (homeCtrl.user.value.savedProperties!.contains(propertyId)) {
        return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Pallet.secondaryColor.withOpacity(0.2),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(6)),
            child: Icon(Icons.favorite, color: Colors.red, size: size));
      }
    }
    return Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: Pallet.secondaryColor.withOpacity(0.2),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6)),
        child: Icon(Icons.favorite_border,
            color: color ?? Colors.black87, size: size));
  }

  static Widget savedPropertyText(propertyId, {double size = 16.0}) {
    if (homeCtrl.user.value.savedProperties != null) {
      if (homeCtrl.user.value.savedProperties!.contains(propertyId)) {
        return CustomText(
            color: Colors.black.withOpacity(0.6),
            text: 'saved',
            weight: FontWeight.w200,
            size: size);
      }
    }
    return CustomText(
        color: Colors.black.withOpacity(0.4),
        text: 'save for later',
        weight: FontWeight.w200,
        size: size);
  }

  static savePropertyTextIcon(Property property, {user, required List state}) {
    return InkWell(
      onTap: () => homeCtrl.saveProperty(property),
      child: Container(
        margin: const EdgeInsets.only(right: 25),
        child: Row(
          children: [
            Utils.savedPropertyIcon(property.id,
                size: 18, user: user, state: state),
            const SizedBox(width: 8),
            Utils.savedPropertyText(property.id, size: 16),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  static double homeFeatureHeight() {
    return isMobile()
        ? Get.width * 1.35
        : isTablet()
            ? Get.width * 0.9
            : !isDesktop()
                ? Get.width * 0.5
                : Get.width * 0.4;
  }

  static void gotoHomePage({enableGoBack = false}) {
    if (isMobileApp && enableGoBack) {
      Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (context) => const MobileLandingPage()),
      );
      //Get.toNamed(RouteStr.mobileLanding);
    } else if (isMobileApp) {
      Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (context) => const MobileLandingPage()),
      );
      //Get.offAndToNamed(RouteStr.mobileLanding);
    } else if (enableGoBack) {
      Get.toNamed(RouteStr.webHome);
    } else {
      Get.offAndToNamed(RouteStr.webHome);
    }
  }

  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      dnd('Location services are disabled.');
      //Todo: alert to enable location

    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        dnd('Location permissions are denied');
        //Todo: alert to enable location
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      dnd('Location permissions are permanently denied, we cannot request permissions.');
      //Todo: alert to enable location
      return null;
    }
    try {
      if (Platform.isAndroid) {
        Position? position = await Geolocator.getLastKnownPosition(
            forceAndroidLocationManager: false);
        return position;
      } else {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true);
        return position;
      }
    } catch (e) {
      dnd('Location position Error: ' + e.toString());
    }
    return null;
  }

  static Future<String?> getState() async {
    var position = await getCurrentLocation();
    if (position == null) {
      dnd(position);
      return '...';
    }
    var address =
        await getAddressFromLatLng(position.latitude, position.longitude);

    if (address == null) return '...';
    saveLocation(
      lng: position.longitude,
      lat: position.latitude,
      country: address.country,
      state: address.administrativeArea,
      city: address.locality,
      street: address.street,
    );

    return homeCtrl.currentLocation.value =
        '${address.country}, ${address.administrativeArea}';
  }

  static saveLocation({lng, lat, country, state, city, street}) async {
    SharedPref.putString('country', country);
    SharedPref.putString('state', state);
    SharedPref.putString('city', city);
    SharedPref.putString('street', street);
    String location = '$state, $country';
    if (HomeController.isLogin.value) {
      var map = User.map(
        longitude: lng,
        latitude: lat,
        address: street,
        state: state,
        city: city,
        country: country,
        location: location,
      );
      var response = await Provider().postData('user/update-location', map);
      if (response.runtimeType != Null) {
        homeCtrl.loginUser(User.fromJson(response));
        return User.fromJson(response);
      }
    }
  }

  static Future<Placemark?> getAddressFromLatLng(lat, lng) async {
    Placemark? place;
    try {
      var response = await Provider().getData(
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&sensor=true&key=AIzaSyBshGRGOCF3iXJLxZzYbsBob_oc8dtlIcI",
          thirdPartyRequest: true);
      var body = jsonDecode(response.body);
      var country = '';
      var state = '';
      var city = '';
      var town = '';
      var lga = '';
      for (var googleLocation in body['results'][0]['address_components']) {
        List type = googleLocation['types'];
        String name = googleLocation['long_name'];
        if (type.contains('country')) country = name;
        if (type.contains('locality')) city = name;
        if (type.contains('administrative_area_level_2')) lga = name;
        if (type.contains('administrative_area_level_1')) state = name;
      }
      place = Placemark(
        country: country,
        administrativeArea: state,
        subAdministrativeArea: lga,
        locality: city,
        street: body['results'][0]['formatted_address'],
      );
    } catch (ex) {
      dnd(ex);

      try {
        List<Placemark> marks = await placemarkFromCoordinates(lat, lng);
        place = marks[0];
        return place;
      } catch (e) {
        dnd(e);
        place = null;
      }
    }
    return place;
  }
}

void dnd(data) {
  if (kDebugMode) {
    print('[] ' + Utils.count.toString() + ': ' + data.toString());
  }
  Utils.count++;
}

bool isMobile() {
  return Get.width <= 480;
}

bool isTablet() {
  return Get.width > 480 && Get.width <= 780;
}

bool isTabletDown() {
  return Get.width <= 780;
}

bool isDesktopSmall() {
  return Get.width > 780 && Get.width <= 1080;
}

bool isDesktop() {
  return Get.width > 1080;
}

bool isNotDeskTop() {
  return Get.width <= 1080;
}
