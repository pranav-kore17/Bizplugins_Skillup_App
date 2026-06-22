import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/controllers/sales_videos_controller.dart';
import 'package:bizplugins_skillup/models/dashboard_model.dart';
import 'package:bizplugins_skillup/utils/routes.dart';

class DashboardController extends GetxController {
  /// Bottom navigation selected index
  final RxInt selectedIndex = 0.obs;

  /// Change bottom tab
  void changeTab(int index) => selectedIndex.value = index;

  /// Get SalesVideosController instance
  late final SalesVideosController salesVideosController;

  @override
  void onInit() {
    super.onInit();

    /// Register controller once
    salesVideosController = Get.put(SalesVideosController(), permanent: true);
  }

  /// ---------------- Functional Menus ----------------
  final List<DashboardMenuModel> functionalMenus = const [
    DashboardMenuModel(
      title: "Sales",
      icon: Icons.arrow_right,
      route: RouteName.salesVideosScreen,
    ),
    // DashboardMenuModel(
    //   title: "Purchase",
    //   icon: Icons.arrow_right,
    //   route: RouteName.dashboardScreen,
    // ),
    // DashboardMenuModel(
    //   title: "Accounts",
    //   icon: Icons.arrow_right,
    //   route: RouteName.dashboardScreen,
    // ),
  ];

  /// ---------------- Technical Menus ----------------
  // final List<DashboardMenuModel> technicalMenus = const [
  //   DashboardMenuModel(
  //     title: "API Settings",
  //     icon: Icons.arrow_right,
  //     route: RouteName.dashboardScreen,
  //   ),
  //   DashboardMenuModel(
  //     title: "User Management",
  //     icon: Icons.arrow_right,
  //     route: RouteName.dashboardScreen,
  //   ),
  //   DashboardMenuModel(
  //     title: "System Logs",
  //     icon: Icons.arrow_right,
  //     route: RouteName.dashboardScreen,
  //   ),
  // ];

  /// ---------------- Sales Progress ----------------
  int get salesCompleted => salesVideosController.completedCount;

  int get salesTotal => salesVideosController.totalCount;

  /// ---------------- Finance Progress ----------------
  // int get financeCompleted => 0;

  // int get financeTotal => 0;

  /// ---------------- Navigation ----------------
  void onMenuTap(DashboardMenuModel menu) {
    Get.toNamed(menu.route);
  }

  void goHome() {
    Get.offAllNamed(RouteName.dashboardScreen);
  }

  void logout() {
    Get.offAllNamed(RouteName.loginScreen);
  }
}
