import 'package:brixmarket/utils/utils.dart';
import 'package:flutter/material.dart';

class AppNotification {
  String title;
  String description;
  String time;
  String tag;
  bool seen;
  Color background;
  IconData? icon = Icons.notifications_outlined;
  Color? iconColor;

  AppNotification({
    this.title = "",
    this.seen = false,
    this.description = "",
    this.time = "",
    this.tag = '',
    this.background = Colors.black26,
    this.iconColor = Colors.black54,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) => AppNotification(
        title: asT(json, 'title').toString().replaceAll('&#039;', '\'').replaceAll('&bull;', '.').replaceAll('&yen;', '¥').replaceAll('&pound;', '£').replaceAll('&euro;', '€').replaceAll('&lt;', '<').replaceAll('&gt;', '>').replaceAll('&amp;', '&').replaceAll('&ldquo;', '"').replaceAll('&rdquo;', '"').replaceAll('&lsquo;', '\'').replaceAll('&rsquo;', '\''),
        description: asT(json, 'description').replaceAll('&#039;', '\'').toString().replaceAll('&bull;', '.').replaceAll('&yen;', '¥').replaceAll('&pound;', '£').replaceAll('&euro;', '€').replaceAll('&lt;', '<').replaceAll('&gt;', '>').replaceAll('&amp;', '&').replaceAll('&ldquo;', '"').replaceAll('&rdquo;', '"').replaceAll('&lsquo;', '\'').replaceAll('&rsquo;', '\''),
        time: asT(json, 'created_at'),
        seen: asT(json, 'seen'),
        tag: asT(json, 'tag'),
        iconColor: asT(json, 'iconColor'),
        background: asT(json, 'background'),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'time': time,
      };
}

asT(Map<String, dynamic> json, String s) {
  var value = json[s];
  var seen = json['seen'].toString();
  if (s == 'created_at') {
    value = Utils.formatDateTime(value);
  } else if (s == 'seen') {
    value = value.toString() == '1';
  } else if (s == 'background') {
    return seen == '1' ? Colors.green.withOpacity(0.15) : Colors.red.withOpacity(0.15);
  } else if (s == 'iconColor') {
    return seen == '1' ? Colors.black54 : Colors.red[900];
  } else if (s == 'icon') {
    return Icons.notifications;
  }
  return value;
}
