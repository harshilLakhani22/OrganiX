import 'dart:ui';

import 'package:get/get.dart';
import 'package:organix/core/local_languages/supported_languages/english.dart';
import 'package:organix/core/local_languages/supported_languages/gujarati.dart';
import 'package:organix/core/local_languages/supported_languages/hindi.dart';

class Languages extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US' : English.english,
    'guj_IN' : Gujarati.gujarati,
    'hn_IN' : Hindi.hindi,
  };
}

final List locales = [
  {
    'name': 'ENGLISH',
    'locale': const Locale('en', 'US'),
  },
  {
    'name': 'ગુજરાતી',
    'locale': const Locale('guj', 'IN'),
  },
  {
    'name': 'हिंदी',
    'locale': const Locale('hn', 'IN'),
  },
];