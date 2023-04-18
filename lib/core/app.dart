import 'package:get/get.dart';

import '../utils/shared_preferences.dart';

const bool live = true;

const String authToken =
    'kOoT3jVQAK73GAsRrftjnnXzXS6o7lfLi9iMENmJOx1nYbDPgaiqk7vs5lEpfXg4LMF+wFZWWommwTf1CrqTU1ZZz/my4WZxuReq/uDdBIs=dodroosos';
const appBaseUrl = 'https://api.brixmarket.com/';
// const appBaseUrl = 'https://iceztech.com/clients/brix/';
// const appBaseUrl = 'http://127.0.0.1/brix/';
// const appBaseUrl = 'http://192.168.137.1/brix/';
const baseImgPath = appBaseUrl + 'public/res/img';
const propertyImgPath = appBaseUrl + 'public/res/img/properties/';
const userImgPath = appBaseUrl + 'public/res/img/users/';
const cacImgPath = appBaseUrl + 'public/res/img/agency-cert/';
const idImgPath = appBaseUrl + 'public/res/img/user-ids/';
const defaultImage = 'assets/images/default_icon.jpeg';
const requestHeader = {'Authorization': 'Bearer $authToken'};

var context = Get.context;
var screenWidth = context?.width;
var screenHeight = context?.height;
