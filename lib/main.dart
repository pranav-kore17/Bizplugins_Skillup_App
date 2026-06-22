import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bizplugins_skillup/utils/routes.dart';
import 'screens/splash_screen.dart';
import 'package:bizplugins_skillup/controllers/theme_controller.dart';
import 'package:bizplugins_skillup/utils/app_theme.dart';
import 'dart:io';

/// SSL override (for test servers only)
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage
  await GetStorage.init();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController =
        Get.put(ThemeController(), permanent: true);

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          
          initialRoute: RouteName.splashScreen,
          getPages: getPages,

          theme: lightTheme,
          darkTheme: darkTheme,

          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
        ));
  }
}
