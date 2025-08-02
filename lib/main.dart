import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/foundation.dart';
import 'core/theme/app_theme.dart';
import 'views/portfolio_home_view.dart';
import 'bindings/portfolio_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Add delay for web to ensure assets are loaded
  if (kIsWeb) {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      // Add this to save locale changes
      saveLocale: true,
      // Use dependency injection to force rebuilds
      child: const AppWrapper(),
    ),
  );
}

// Wrapper to ensure proper rebuilding on locale changes
class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MyApp(key: ValueKey(context.locale.languageCode));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Mohamed Mounir - Portfolio',
          debugShowCheckedModeBanner: false,

          // Localization
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          // Theme
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,

          // Responsive Framework
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),

          // Routes
          home: const PortfolioHomeView(),
          initialBinding: PortfolioBinding(),
        );
      },
    );
  }
}
