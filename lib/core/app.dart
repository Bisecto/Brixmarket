import 'package:get/get.dart';

import '../utils/shared_preferences.dart';

const bool live = true;

Future<Map<String, String>> formDataHeader([String? token]) async {
  final accessToken = token ?? await SharedPref.getString('token');
  return {
    if (accessToken.isNotEmpty) 'Authorization': 'Bearer $accessToken',
  };
}
const headers = {
  'Authorization': 'Bearer kOoT3jVQAK73GAsRrftjnnXzXS6o7lfLi9iMENmJOx1nYbDPgaiqk7vs5lEpfXg4LMF+wFZWWommwTf1CrqTU1ZZz/my4WZxuReq/uDdBIs=dodroosos',
  'Cookie': 'PHPSESSID=1hkes2gigv5uifp7to76ihto1s'
};
// const String authToken =
//     'kOoT3jVQAK73GAsRrftjnnXzXS6o7lfLi9iMENmJOx1nYbDPgaiqk7vs5lEpfXg4LMF+wFZWWommwTf1CrqTU1ZZz/my4WZxuReq/uDdBIs=dodroosos';
const appBaseUrl = 'https://api.brixmarket.site/';
const appUrl = 'https://brixmarket.site';
const imageBaseUrl = 'https://dfy7hoxi61jci.cloudfront.net/';
// const appBaseUrl = 'https://iceztech.com/clients/brix/';
// const appBaseUrl = 'http://127.0.0.1/brix/';
// const appBaseUrl = 'http://192.168.137.1/brix/';
// const baseImgPath = imageBaseUrl;
// const propertyImgPath = imageBaseUrl;
// const userImgPath = imageBaseUrl;
// const cacImgPath = imageBaseUrl;
// const idImgPath = imageBaseUrl;

const baseImgPath = imageBaseUrl;
const propertyImgPath = imageBaseUrl + 'properties/';
const userImgPath = imageBaseUrl + 'users/';
const cacImgPath = imageBaseUrl + 'agency-cert/';
const idImgPath = imageBaseUrl + 'user-ids/';

const defaultImage = 'assets/images/default_icon.jpeg';
//const requestHeader = {'Authorization': 'Bearer $authToken'};

var context = Get.context;
var screenWidth = context?.width;
var screenHeight = context?.height;
