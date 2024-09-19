import 'dart:async';
import 'dart:io';

import 'package:brixmarket/core/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/utils.dart';

class Launch {
  Future<void> launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchInWebViewWithoutJavaScript(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchInWebViewWithoutDomStorage(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchUniversalLinkIos(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  Widget launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  static Future<void> sendEmail({required String email, String subject = ''}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{'subject': subject}),
    );
    if (!await launchUrl(emailLaunchUri)) {
      MSG.errorSnackBar('Cannot send email');
    }
  }

  static Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      MSG.errorSnackBar('Could not launch $url');
    }
  }

  static Future<void> makePhoneCall(String phone) async {
    final bool isCallService = await canLaunchUrl(Uri(scheme: 'tel', path: phone));
    if (isCallService) {
      final Uri launchUri = Uri(scheme: 'tel', path: phone);
      await launchUrl(launchUri);
    } else {
      MSG.errorSnackBar('Calling not supported');
    }
  }

  Widget emailWidget({required String email, String subject = '', required Widget child}) {
    return GestureDetector(
      onTap: () async => await sendEmail(email: email, subject: subject),
      child: child,
    );
  }

  Widget phoneWidget({required String phone, required Widget child}) {
    return InkWell(
      onTap: () async => await makePhoneCall(phone),
      child: child,
    );
  }

  Widget urlWidget({required String url, required Widget child}) {
    return InkWell(
      onTap: () async => await launchInBrowser(url),
      child: child,
    );
  }

  static Widget linkWidget({required String url, required Widget child}) {
    return Link(
      uri: Uri.parse(url),
      target: LinkTarget.blank,
      builder: (BuildContext ctx, FollowLink? openLink) {
        return child;
      },
    );
  }

  static Future<void> openWhatsapp({String text = '', required String phone}) async {
    var whatsapp = phone[0] == '0' ? '+234' + phone.replaceAll(' ', '').substring(1) : phone.replaceAll(' ', '');
    dnd(whatsapp);//+92xx enter like this
    var url = Uri.parse("whatsapp://send?phone=" + whatsapp + "&text=$text");
    var iosUrl = Uri.parse("https://wa.me/$whatsapp?text=${Uri.tryParse(text)}");
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(iosUrl)) {
        await launchUrl(iosUrl);
      } else {
        MSG.snackBar("Whatsapp not installed");
      }
    } else {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        MSG.snackBar("Whatsapp not installed");
      }
    }
  }
}

class OpenLink extends StatelessWidget {
  final String url;
  final Widget child;

  const OpenLink({Key? key, required this.url, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: Uri.parse(url),
      target: LinkTarget.blank,
      builder: (BuildContext ctx, FollowLink? openLink) {
        return child;
      },
    );
  }
}

class OpenUrl extends InkWell {
  final String url;
  final Widget widget;

  const OpenUrl({Key? key, required this.url, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await Launch.launchInBrowser(url),
      child: widget,
    );
  }
}

class OpenWhatsApp extends InkWell {
  final String phone;
  final String text;
  final Widget widget;

  const OpenWhatsApp({Key? key, required this.phone, this.text = '', required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await Launch.openWhatsapp(phone: phone, text: text),
      child: widget,
    );
  }
}

class MakeCall extends InkWell {
  final String phone;
  final Widget widget;

  const MakeCall({Key? key, required this.phone, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await Launch.makePhoneCall(phone),
      child: widget,
    );
  }
}

class SendEmail extends StatelessWidget {
  final String email;
  final String subject;
  final Widget child;

  const SendEmail({Key? key, required this.email, this.subject = '', required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await Launch.sendEmail(email: email, subject: subject),
      child: child,
    );
  }
}
