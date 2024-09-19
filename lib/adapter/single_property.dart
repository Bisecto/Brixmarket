import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:brixmarket/models/single_property_model.dart';

import '../core/app.dart';
class SinglePropertyApi {

  final StreamController<SinglePropertyModel> getSIngleProperty = StreamController();
  Future<void> get_SingleProperty(String propertyID) async {
    var url = Uri.parse('${appBaseUrl}property/get-single-property/$propertyID');
    var headers = {
      'Authorization': 'Bearer kOoT3jVQAK73GAsRrftjnnXzXS6o7lfLi9iMENmJOx1nYbDPgaiqk7vs5lEpfXg4LMF+wFZWWommwTf1CrqTU1ZZz/my4WZxuReq/uDdBIs=dodroosos',
      'Cookie': 'PHPSESSID=efe427461bf8353458f882c0d7143ce3'
    };
    final res =
    await http.get(url,headers: await formDataHeader());
    //print(res.body);
    final json = await jsonDecode(res.body);
    //print(res);
    SinglePropertyModel singlePropertyModel = SinglePropertyModel.fromJson(json);
    getSIngleProperty.add(singlePropertyModel);
  }
}