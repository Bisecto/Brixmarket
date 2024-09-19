import 'package:brixmarket/controllers/home_controller.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatMessage {
  String chatKey;
  String message;
  String sender;
  String time;
  bool fromMe;
  bool seen;
  bool delivered;

  ChatMessage({this.chatKey = '', this.message = '', this.time = '', this.sender = '', this.fromMe = false, this.seen = false, this.delivered = false});

  factory ChatMessage.fromJson(json) => ChatMessage(
        chatKey: json['chatkey'],
        message: json['message'].toString().replaceAll('&#039;', '\'').replaceAll('&bull;', '.').replaceAll('&yen;', '¥').replaceAll('&pound;', '£').replaceAll('&euro;', '€').replaceAll('&lt;', '<').replaceAll('&gt;', '>').replaceAll('&amp;', '&').replaceAll('&ldquo;', '"').replaceAll('&rdquo;', '"').replaceAll('&lsquo;', '\'').replaceAll('&rsquo;', '\''),//.toString().replaceAll(from, replace),
        sender: json['sender'],
        fromMe: json['sender'] == HomeController.userId,
        time: Utils.formatDateTime(json['created_at']),
        seen: json['seen'].toString() == '1' || json['seen'].toString() == 'true' && json['sender'] != HomeController.userId,
        delivered: json['delivered'].toString() == '1' || json['delivered'].toString() == 'true' && json['sender'] != HomeController.userId,
      );

  static Map<String, dynamic> toJson({chatKey, message}) {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['chatkey'] = chatKey;
    map['message'] = message;
    map['seen'] = Utils.userFirebase ? false : '0';
    map['delivered'] = Utils.userFirebase ? false : '0';
    map['sender'] = HomeController.userId;
    if (Utils.userFirebase) {
      map['created_at'] = ServerValue.timestamp;
    }
    return map;
  }
}
