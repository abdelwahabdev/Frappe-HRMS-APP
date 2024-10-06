import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocalController extends GetxController {
  static MyLocalController get find => Get.find();

  final RxString selectedLang = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadSelectedLang();
  }

  Future<void> loadSelectedLang() async {
    final prefs = await SharedPreferences.getInstance();
    selectedLang.value = prefs.getString('selectedLang') ?? "ar";
    updateLocale(selectedLang.value);
  }

  void saveSelectedLang(String codeLang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLang', codeLang);
    selectedLang.value = codeLang;
    updateLocale(codeLang);
  }

  void toggleLang() {
    selectedLang.value = (selectedLang.value == "en") ? "ar" : "en";
    saveSelectedLang(selectedLang.value);
  }

  void updateLocale(String codeLang) {
    Locale locale = Locale(codeLang);
    Get.updateLocale(locale);
  }
}
