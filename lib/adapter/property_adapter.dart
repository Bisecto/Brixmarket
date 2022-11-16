import 'dart:convert';

import '../models/property_model.dart';
import 'package:http/http.dart' as http;

Future<List<Property>> getProperty() async {
  // Give your sever URL of get_employees_details.php file
  var url = 'https://api.brixmarket.com/property/get-home-properties';

  final response = await http.post(Uri.parse(url));
  if (response.statusCode == 200) {
    print("[Precious]");
    print("Requested data"+response.body);
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    print(parsed);

    return parsed.map<Property>((json) => Property.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Data');
  }
}
Future<String> getProper()async{
  var headers = {
    'Cookie': 'PHPSESSID=bbe26ac2108e29d8e168e148898e95e8'
  };
  var request = http.Request('POST', Uri.parse('https://api.brixmarket.com/property/get-home-properties'));
  request.bodyFields = {};
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print('[Precious:https://api.brixmarket.com/property/get-home-properties]');
    print(await response.stream.bytesToString());

    return response.stream.bytesToString();
  }
  else {
    print(response.reasonPhrase);
    return response.reasonPhrase.toString();
  }

}