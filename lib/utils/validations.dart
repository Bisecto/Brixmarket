import 'package:brixmarket/res/strings.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:get/utils.dart';

class Val {
  static String email(String text) {
    return text.isEmpty
        ? Str.required
        : text.isEmail
            ? Str.noText
            : Str.invalidEmail;
  }

  static String phone(String text, {foreign = false, require = true}) {
    return text.isEmpty && require
        ? Str.required
        : foreign && text.isPhoneNumber
            ? Str.noText
            : Utils.isPhoneNumber(text)
                ? Str.noText
                : Str.invalidPhone;
  }

  static String name(String text, {minLength = 3}) {
    return text.isEmpty
        ? Str.required
        : text.length >= 3
            ? Str.noText
            : Str.invalidName;
  }

  static String number(String text, {minLength = 3}) {
    return text.isEmpty
        ? Str.required
        : !text.isNumericOnly
            ? Str.invalidNumber
            : text.length <= minLength
                ? Str.invalidName
                : Str.noText;
  }

  static password(String text) {
    return text.isEmpty
        ? Str.required
        : text.length > 6
            ? Str.noText
            : Str.passwordToShot;
  }
}
