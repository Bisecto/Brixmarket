import 'package:firebase_database/firebase_database.dart';

import '../controllers/home_controller.dart';
import '../utils/utils.dart';

class ChatUser {
  String chatKey;
  String userId;
  String name;
  String image;
  String lastMessage;
  String lastMessageTime;
  String sender;
  bool fromMe;
  bool seen;
  bool delivered;

  ChatUser(
      {this.chatKey = '',
      this.userId = '',
      this.name = '',
      this.image = '',
      this.lastMessage = '',
      this.lastMessageTime = '',
      this.sender = '',
      this.fromMe = false,
      this.seen = false,
      this.delivered = false});

  factory ChatUser.fromJson(json) => ChatUser(
        chatKey: json['chatkey'],
        userId: json['userid'],
        name: json['name'],
        image: json['image'],
        lastMessage: json['message'],
        sender: json['sender'],
        fromMe: json['sender'] == HomeController.userId,
        lastMessageTime: Utils.formatDateTime(json['updated_at']),
        seen: json['seen'].toString() == '1' || json['seen'].toString() == 'true',
        delivered: json['delivered'].toString() == '1' || json['delivered'].toString() == 'true',
      );

  static Map<String, dynamic> toJson({chatKey, userId, name, image, lastMessage}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatkey'] = chatKey;
    data['userid'] = userId;
    data['name'] = name;
    data['image'] = image == null || image == '' ? 'default.jpg' : image;
    data['message'] = lastMessage;
    if (Utils.userFirebase) {
      data['updated_at'] = ServerValue.timestamp;
    }
    data['seen'] = Utils.userFirebase ? false : '0';
    data['delivered'] = Utils.userFirebase ? false : '0';
    data['sender'] = HomeController.userId;
    return data;
  }
}
