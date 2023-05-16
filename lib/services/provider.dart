import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../core/app.dart';
import '../core/dialogs.dart';
import '../core/preloader.dart';
import '../models/api_response_model.dart';
import '../res/strings.dart';
import '../utils/utils.dart';

var timeOutDuration = const Duration(seconds: 30);
var timeOutDuration2 = const Duration(seconds: 45);

class Provider extends GetConnect {
  Future<dynamic> getData(String url,
      {Map<String, dynamic>? params, thirdPartyRequest = false}) async {
    // await Connectivity().checkConnection().then((connected) async => connected ? true : Get.toNamed(noInternet));
    url =  appBaseUrl + url;
    // dnd(url);
    try {
      var response = await http
          .post(Uri.parse(url),
              body: params,
              headers: thirdPartyRequest ?? await formDataHeader())
          .timeout(timeOutDuration,
              onTimeout: () => http.Response('Request time out', 408));
      return thirdPartyRequest ? response : processResponse(response);
    } catch (e, t) {
      // dnd('$e Trace: $t');
      Preloader.hide();
      //dnd('Request Error: ' + e.toString());
      return null;
    }
  }

  Future<dynamic> postData(
    String url,
    Map<String, dynamic> data, {
    String? baseUrl,
    Map<String, String>? header,
  }) async {
    //await Connectivity().checkConnection().then((connected) async => connected ? null : Get.toNamed(noInternet));
    url = appBaseUrl + url;
    // dnd(data);
    dnd(url);
    var head = header ?? await formDataHeader();
    try {
      var response = await http
          .post(Uri.parse(url), body: data, headers: head)
          .timeout(timeOutDuration,
              onTimeout: () => http.Response('Request time out', 408));

      dnd(response.body);

      return processResponse(response);
    } catch (e, t) {
      // dnd('$e Trace: $t');
      Preloader.hide();
      // dnd('Request error: ' + e.toString());
      return null;
    }
  }

  Future postFileIO(url, File? imagePath, {Map<String, dynamic>? data}) async {
    await Connectivity().checkConnection().then((connected) async =>
        connected ? null : Get.toNamed(RouteStr.mobileNoInternet));
    url = appBaseUrl + url;
    // dnd(data);
    // dnd(url);
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (data != null) {
        data.forEach((key, value) {
          request.fields[key] = value;
        });
        request.headers.addAll(await formDataHeader());
        request.files.add(
            await http.MultipartFile.fromPath('profile_pic', imagePath!.path));
      }

      var httpResponse = await request.send();
      var response = await http.Response.fromStream(httpResponse);

      return processResponse(response);
    } catch (e, t) {
      // dnd('$e Trace: $t');
      Preloader.hide();
      //  dnd(e);
    }
  }

  Future postFiles(url, List<Uint8List> imagePaths,
      {Map<String, dynamic>? data}) async {
    await Connectivity().checkConnection().then((connected) async =>
        connected ? null : Get.toNamed(RouteStr.mobileNoInternet));
    url = appBaseUrl + url;
    // dnd(data);
    // dnd(url);
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (data != null) {
        data.forEach((key, value) {
          request.fields[key] = value;
        });
      }
      request.headers.addAll(await formDataHeader());
      for (var imagePath in imagePaths) {
        request.files.add(http.MultipartFile.fromBytes('images[]', imagePath,
            filename: 'profileImage.jpg'));
      }
      var httpResponse = await request.send();
      var response = await http.Response.fromStream(httpResponse).timeout(
          timeOutDuration2,
          onTimeout: () => http.Response('Request time out', 408));
      return processResponse(response);
    } catch (e, t) {
      dnd('$e Trace: $t');
      Preloader.hide();
      dnd(e);
    }
  }

  Future postFile(url, List<Uint8List> imagePaths,
      {Map<String, dynamic>? data}) async {
    await Connectivity().checkConnection().then((connected) async =>
        connected ? null : Get.toNamed(RouteStr.mobileNoInternet));
    url = appBaseUrl + url;
    // dnd(data);
    // dnd(url);
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      if (data != null) {
        data.forEach((key, value) {
          request.fields[key] = value;
        });
      }
      request.headers.addAll(await formDataHeader());

      for (var imagePath in imagePaths) {
        request.files.add(http.MultipartFile.fromBytes('images', imagePath,
            filename: 'image.jpg'));
      }

      var httpResponse = await request.send();
      var response = await http.Response.fromStream(httpResponse).timeout(
          timeOutDuration2,
          onTimeout: () => http.Response('Request time out', 408));
      return processResponse(response);
    } catch (e, t) {
      // dnd('$e Trace: $t');
      Preloader.hide();
      //  dnd(e);
    }
  }

  processResponse(http.Response response) {
    // dnd(response.body);
    try {
      if (response.statusCode == 200) {
        // print('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
        // print(response.body);
        ApiResponse apiResponse =
            ApiResponse.fromJson(jsonDecode(response.body));
        if (!apiResponse.status) {
          try {
            if (apiResponse.causes.isNotEmpty) {
              Preloader.hide();
              // for (var causes in apiResponse.causes.entries) {
              MSG.errorSnackBar(apiResponse.message.toString());

              // }
            } else {
              Preloader.hide();
              MSG.errorSnackBar(apiResponse.message.toString());
            }
          } catch (e, t) {
            // dnd('$e Trace: $t');
            Preloader.hide();
            MSG.errorSnackBar(apiResponse.message.toString());

            // dnd(e);
          }
        } else {
          return apiResponse.data ?? true;
        }
      } else if (response.statusCode == 408) {
        Preloader.hide();
        // MSG.errorSnackBar(response.body.toString());
      } else {
        Preloader.hide();
        // MSG.errorSnackBar(response.body.toString());
      }
    } catch (e, t) {
      Preloader.hide();
      // dnd('$e Trace: $t');
      // MSG.errorSnackBar('Connection error, try again');
      // dnd(e);
      return null;
    }
    return null;
  }
}
