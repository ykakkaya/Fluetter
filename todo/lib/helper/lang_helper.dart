import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class LanguageHelper {
  LanguageHelper._();
  static getDeviceLang(BuildContext context) {
    var lang = context.deviceLocale.countryCode!.toLowerCase();
    switch (lang) {
      case 'tr':
        return LocaleType.tr;
      case 'en':
        return LocaleType.en;
      case 'de':
        return LocaleType.de;
      default:
        return LocaleType.en;
    }
  }
}
