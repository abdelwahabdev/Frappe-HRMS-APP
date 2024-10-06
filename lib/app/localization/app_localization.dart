import 'package:bio_attend/app/localization/ar_lang.dart';
import 'package:get/get.dart';

import 'en_lang.dart';

class AppLocalization implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en': en, 'ar': ar};
}
