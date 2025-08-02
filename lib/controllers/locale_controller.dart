import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

class LocaleController extends GetxController {
  final RxString currentLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with current locale
    final context = Get.context;
    if (context != null) {
      currentLanguage.value = context.locale.languageCode;
    }
  }

  void toggleLanguage() async {
    final context = Get.context;
    if (context == null) return;

    final currentLocale = context.locale;
    final newLocale = currentLocale.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');

    try {
      // Update our controller state immediately
      currentLanguage.value = newLocale.languageCode;

      if (kIsWeb) {
        // For web (especially production), use more aggressive approach
        await _changeLocaleWeb(context, newLocale);
      } else {
        // For mobile platforms
        await _changeLocaleMobile(context, newLocale);
      }
    } catch (e) {
      debugPrint('Error changing locale: $e');
      // Revert on error
      currentLanguage.value = currentLocale.languageCode;
    }
  }

  Future<void> _changeLocaleWeb(BuildContext context, Locale newLocale) async {
    // For web builds, especially production
    if (kReleaseMode) {
      // Production web build - most aggressive approach
      await context.setLocale(newLocale);

      // Force multiple updates with different timing
      await Future.microtask(() async {
        Get.updateLocale(newLocale);
        Get.forceAppUpdate();

        // Additional rebuild after a short delay
        await Future.delayed(const Duration(milliseconds: 50));
        Get.forceAppUpdate();

        // Final rebuild to ensure everything is updated
        await Future.delayed(const Duration(milliseconds: 100));
        Get.forceAppUpdate();
      });
    } else {
      // Debug web build
      await context.setLocale(newLocale);
      Get.updateLocale(newLocale);
      Get.forceAppUpdate();
    }
  }

  Future<void> _changeLocaleMobile(
      BuildContext context, Locale newLocale) async {
    // Simpler approach for mobile
    await context.setLocale(newLocale);
    Get.updateLocale(newLocale);
  }

  String get currentLanguageCode => currentLanguage.value;
  bool get isArabic => currentLanguage.value == 'ar';
  bool get isEnglish => currentLanguage.value == 'en';
}
