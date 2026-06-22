import 'package:get/get.dart';
import 'package:bizplugins_skillup/screens/splash_screen.dart';
import 'package:bizplugins_skillup/screens/login_screen.dart';
import 'package:bizplugins_skillup/screens/dashboard_screeen.dart';
import 'package:bizplugins_skillup/screens/sales/sales_videos_page.dart';

class RouteName {
  static const splashScreen = '/splash_screen';
  static const loginScreen = '/login_screen';
  static const dashboardScreen = '/dashboard_screen';
  static const salesVideosScreen = '/sales_videos';
}

final getPages = [
  GetPage(
      name: RouteName.splashScreen,
      page: () => const SplashScreen()
  ),
  GetPage(
      name: RouteName.loginScreen,
      page: () => const LoginScreen()
  ),
  GetPage(
      name: RouteName.dashboardScreen,
      page: () => const DashboardScreen()
  ),
  GetPage(
    name: RouteName.salesVideosScreen,
    page: () => const SalesVideosPage(),
  ),
];