import 'package:flutter/services.dart';

class WhatsApp {
  /// Creates a [WhatsAppUnilink] instance.
  ///
  /// Call the [toString] method to get the WhatsApp URL.
  const WhatsApp({
    this.phoneNumber,
    this.text,
  });

  /// Destination phone number.
  ///
  /// The [phoneNumber] string will be internally converted to a format that the
  /// WhatsApp API expect: any brackets, dashes, plus signs, and leading zeros
  /// or any other non-digit characters will be removed.
  final String? phoneNumber;

  /// The message to the user.
  ///
  /// WhatsApp will include your message in [text], and it will automatically
  /// appear in the text field of a chat.
  ///
  /// [text] is encoded using percent-encoding to make it safe for literal use
  /// as a URI component.
  final String? text;

  /// Create a WhatsApp URL link.
  @override
  String toString() {
    final sb = StringBuffer('https://wa.me/');
    phoneNumber?.use(_formatPhoneNumber).use(sb.write);
    text?.use((s) => sb.write('?text=${Uri.encodeComponent(s)}'));
    return sb.toString();
  }

  /// Keep only the numbers and remove any leading zeros
  static String _formatPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'\D'), '').replaceAll(RegExp('^0+'), '');
  }
}

extension on String? {
  T? use<T>(T Function(String s) f) {
    if (this != null) return f(this!);
  }
}

class Whatsapp2 {
  String mobileNo = "7985533639";
  String msg = "Hello";

  static const MethodChannel _channel = const MethodChannel('flutter_open_whatsapp');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> sendToNumber(mobileNo, msg) async {
    await _channel.invokeMethod('sendSingleMessage', {'mobileNo': mobileNo, 'message': msg});
  }
}
