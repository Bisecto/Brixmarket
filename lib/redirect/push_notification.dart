import 'dart:convert';
import 'package:http/http.dart' as http;
sendPushNotification(String topic,String name,String body,String value) async {
  var headers = {
    'Authorization': 'key=AAAAichMink:APA91bF5PUjZaULOmM7aW9n4y2snOTJRwyxaasSmkRzPZxIZyKKB4k41uy6o1UNe82pmJrmMaHO_suWB9IO98igpSZSBxMFaPEDtKti3lfijZ7ILsXSQyLEx6Dl0Z_Rter86Bb-rYKvz',
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
  request.body = json.encode({
    "to": "/topics/$topic",
    "notification": {
      "title": name,
      "body": body
    },
    "data": {
      "value": value
    }
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
  print(response.reasonPhrase);
  }

}