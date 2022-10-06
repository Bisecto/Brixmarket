import 'dart:async';

import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/core/app.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import '../../models/property_model.dart';
import '../../redirect/push_notification.dart';
import '../../res/strings.dart';
import '../../services/provider.dart';
import '../../utils/utils.dart';
import '../../view/screens/mobile/chat_details_page.dart';
import '../instance.dart';

mixin Chat {
  ScrollController scrollController = ScrollController();
  var otherUserName = '';
  var otherUserId = '';
  var otherUserImage = '';
  var chatKey = '';

  var thisUserName = '';
  var thisUserId = '';
  var thisUserImage = '';

  generateChatKey(String s1, String s2) {
    if (s1.compareTo(s2) < 0) {
      return '${s1}_$s2';
    } else {
      return '${s2}_$s1';
    }
  }

  chatWithSeller(Property property) {
    thisUserId = user.id ?? '';
    thisUserName = accountName(user: user);
    thisUserImage = user.image ?? '';

    otherUserId = property.user?.id ?? '';
    otherUserName = accountName(user: property.user!);
    otherUserImage = property.user?.image ?? '';

    chatKey = generateChatKey(thisUserId, otherUserId);

    homeCtrl.property = property;
    print(thisUserId);
    print(otherUserId);
    Get.toNamed(RouteStr.chat);
  }

  chatFromUserList(ChatUser chatUser) {
    thisUserId = user.id ?? '';
    thisUserName = accountName(user: user);
    thisUserImage = user.image ?? '';

    otherUserId = chatUser.userId;
    otherUserName = chatUser.name;
    otherUserImage = chatUser.image;

    chatKey = chatUser.chatKey;
    //Get.toNamed(RouteStr.chat);
    Navigator.push(
      context!,
      MaterialPageRoute(builder: (context) => const ChatDetailPage()),
    );
  }

  bool scroll = true;

  sendMessage() async {
    var message = EditCtrl.chatMessage.text.trim();
    if (message.isNotEmpty) {
      var thisUserMap = ChatUser.toJson(
          chatKey: chatKey,
          userId: thisUserId,
          name: thisUserName,
          image: thisUserImage,
          lastMessage: message);
      var otherUserMap = ChatUser.toJson(
          chatKey: chatKey,
          userId: otherUserId,
          name: otherUserName,
          image: otherUserImage,
          lastMessage: message);
      var chatMap = ChatMessage.toJson(chatKey: chatKey, message: message);

      if (Utils.userFirebase) {
        FirebaseDatabase.instance
            .ref('Brix')
            .child('ChatUsers')
            .child(thisUserId)
            .push()
            .set(thisUserMap);
        FirebaseDatabase.instance
            .ref('Brix')
            .child('ChatUsers')
            .child(otherUserId)
            .push()
            .set(otherUserMap);
        FirebaseDatabase.instance
            .ref('Brix')
            .child('ChatMessages')
            .child(chatKey)
            .push()
            .set(chatMap);
        EditCtrl.chatMessage.text = '';
      } else {
        Provider().postData('chat/save-message', chatMap).then((value) {
          var added = (value as List)
              .map((event) => ChatMessage.fromJson(event))
              .toList();
          chatMessageStreamCtrl.sink.add(added);
          scroll = true;
        });
        Provider().postData('chat/save-user', thisUserMap);
        Provider().postData('chat/save-user', otherUserMap);

          await sendPushNotification(otherUserId, thisUserName, EditCtrl.chatMessage.text, 'Message_Notification');
        EditCtrl.chatMessage.text = '';}
    }
  }

  late Timer messageTimer;
  late Stream<List<ChatMessage>?> chatMessagesStream;
  final StreamController chatMessageStreamCtrl =
      StreamController<List<ChatMessage>>();

  fetchChatMessages() async {
    if (!chatMessageStreamCtrl.hasListener) {
      chatMessagesStream =
          (chatMessageStreamCtrl.stream as Stream<List<ChatMessage>?>)
              .asBroadcastStream();
    }
    if (Utils.userFirebase) {
      var added = await FirebaseDatabase.instance
          .ref('Brix')
          .child('ChatMessages')
          .child(chatKey)
          .orderByChild('time')
          .orderByPriority()
          .onValue
          .map((event) => ChatMessage.fromJson(event.snapshot.value))
          .toList();
      chatMessageStreamCtrl.sink.add(added);
    } else {
      Provider().getData('chat/messages/$chatKey').then((value) {
        var added = (value as List)
            .map((event) => ChatMessage.fromJson(event))
            .toList();
        chatMessageStreamCtrl.sink.add(added);
        homeCtrl.scroll = true;
        Provider().getData('chat/seen/$chatKey/${user.id}');
      });
      messageTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        Provider().getData('chat/messages/$chatKey').then((value) {
          var added = (value as List)
              .map((event) => ChatMessage.fromJson(event))
              .toList();
          chatMessageStreamCtrl.sink.add(added);
        });
      });
    }
  }

  late Timer userTimer;
  late Stream<List<ChatUser>?> chatUserStream;
  final StreamController chatUserStreamCtrl =
      StreamController<List<ChatUser>>();

  fetchChatUsers() async {
    if (!chatUserStreamCtrl.hasListener) {
      chatUserStream = (chatUserStreamCtrl.stream as Stream<List<ChatUser>?>)
          .asBroadcastStream();
    }
    if (Utils.userFirebase) {
      var added = await FirebaseDatabase.instance
          .ref('Brix')
          .child('ChatUsers')
          .child(chatKey)
          .orderByChild('time')
          .onValue
          .map((event) => ChatMessage.fromJson(event.snapshot.value))
          .toList();
      chatUserStreamCtrl.sink.add(added);
    } else {
      Provider().getData('chat/users/${user.id}').then((value) {
        var added =
            (value as List).map((event) => ChatUser.fromJson(event)).toList();
        chatUserStreamCtrl.sink.add(added);
      });
      userTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        Provider().getData('chat/users/${user.id}').then((value) {
          var added =
              (value as List).map((event) => ChatUser.fromJson(event)).toList();
          chatUserStreamCtrl.sink.add(added);
        });
      });
    }
  }
}
