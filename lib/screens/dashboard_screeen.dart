import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizplugins_skillup/controllers/dashboard_controller.dart';
import 'package:bizplugins_skillup/models/dashboard_model.dart';
import 'package:bizplugins_skillup/utils/app_manager.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:bizplugins_skillup/controllers/theme_controller.dart';
import 'package:bizplugins_skillup/screens/calendar_screen.dart';
import 'package:bizplugins_skillup/screens/profile_screen.dart';
import 'package:bizplugins_skillup/screens/awards_screen.dart';
import 'package:bizplugins_skillup/utils/app_theme.dart';
import 'package:bizplugins_skillup/screens/quiz/quiz_screen.dart';
import 'package:bizplugins_skillup/utils/common_widgets/confirm_dialog.dart';
import 'package:bizplugins_skillup/screens/pdf/pdf_list_screen.dart';
import 'package:bizplugins_skillup/utils/global_appbar.dart';
import '../utils/ApiManager/prefernces.dart';
import 'package:bizplugins_skillup/utils/routes.dart';
import 'package:bizplugins_skillup/screens/quiz/quiz_start_screen.dart';
import 'package:bizplugins_skillup/screens/leave/leave_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

const Color functionalCardColor = Color.fromARGB(255, 234, 241, 248);
const Color technicalCardColor = Color.fromARGB(255, 234, 241, 248);

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = Get.put(DashboardController());
  final themeController = Get.find<ThemeController>();

  final List<String> _titles = [
    'Home',
    'Quiz',
    // 'Awards',
     'Leave',
    'Calendar',
    'User Profile',
  ];

  @override
  void initState() {
    super.initState();
    controller.selectedIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: Obx(() => Text(
              _titles[controller.selectedIndex.value].toUpperCase(),
            )),
      ),
      drawer: _drawer(context),
      body: Obx(() {
        switch (controller.selectedIndex.value) { 
          case 0:
            return _dashboardBody(); // cards screen
          case 1:
            return const QuizStartScreen();
          case 2:
            // return const Awardscreen();
            return const LeaveScreen();
          case 3:
            return const CalendarScreen();
          case 4:
            return const ProfileScreen();
          default:
            return _dashboardBody();
        }
      }),
      bottomNavigationBar: Obx(() => _bottomNavBar()),
    );
  }

  Widget _dashboardBody() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _functionalCard(),
        const SizedBox(height: 16),
        // _technicalCard(),
      ],
    );
  }

  Widget _functionalCard() {
    return _GradientDashboardCard(
      title: "Functional",
      child: Column(
        children: [
          _moduleRow(
            "Sales",
            controller.salesCompleted,
            controller.salesTotal,
          ),
          //    _moduleRow(
          //   "Finance",
          //   controller.financeCompleted,
          //   controller.financeTotal,
          // ),
          // _moduleRow("Purchase", 0, 0),
          // _moduleRow("Accounts", 0, 0),
        ],
      ),
    );
  }

  // Widget _technicalCard() {
  //   return _GradientDashboardCard(
  //     title: "Technical",
  //     child: const Column(
  //       children: [
  //         _StaticModuleRow("API Settings", 0, 0),
  //         _StaticModuleRow("User Management", 0, 0),
  //         _StaticModuleRow("System Logs", 0, 0),
  //       ],
  //     ),
  //   );
  // }

  Widget _bottomNavBar() {
    final bgColor = Theme.of(context).bottomNavigationBarTheme.backgroundColor!;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: GNav(
        gap: 2,
        backgroundColor: bgColor, // THE FIX
        color: Colors.white70,
        activeColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        selectedIndex: controller.selectedIndex.value,
        onTabChange: controller.changeTab,
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.quiz, text: 'Quiz'),
          // GButton(icon: Icons.emoji_events, text: 'Awards'),
          GButton(icon: Icons.event_note, text: 'Leave'),
          GButton(icon: Icons.calendar_month, text: 'Calendar'),
          GButton(icon: Icons.person, text: 'Profile'),
        ],
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75, // control width
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            /// HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 10),
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/img_user.png'),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppManager.shared.loginModel?.defaultExecutiveName ??
                        "User",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppManager.shared.loginModel?.companyName ?? "Company",
                    style: const TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Obx(() => Icon(
                    themeController.isDarkMode.value
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  )),
              title: Obx(() => Text(
                    themeController.isDarkMode.value
                        ? "Light Mode"
                        : "Dark Mode",
                  )),
              onTap: themeController.toggleTheme,
            ),

            /// HOME
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: controller.goHome,
            ),

            /// FUNCTIONAL
            ExpansionTile(
              leading: Icon(
                Icons.business,
                color: themeController.isDarkMode.value ? Colors.white : null,
              ),
              iconColor: themeController.isDarkMode.value ? Colors.white : null,
              collapsedIconColor:
                  themeController.isDarkMode.value ? Colors.white : null,
              title: Text(
                "Functional",
                style: TextStyle(
                  color: themeController.isDarkMode.value ? Colors.white : null,
                ),
              ),
              children: controller.functionalMenus.map(_menuItem).toList(),
            ),

            /// TECHNICAL
            // ExpansionTile(
            //   leading: const Icon(Icons.settings),
            //   title: const Text("Technical"),
            //   children: controller.technicalMenus.map(_menuItem).toList(),
            // ),

            /// TRAINING PDF
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text("Training PDFs"),
              onTap: () {
                Get.back(); // close drawer
                Get.to(() => PdfListScreen());
              },
            ),
            const Divider(),

            /// LOGOUT
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              onTap: () => _confirmLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(DashboardMenuModel menu) {
    return ListTile(
      leading: Icon(
        menu.icon,
        color: themeController.isDarkMode.value ? Colors.white : null,
      ),
      title: Text(
        menu.title,
        style: TextStyle(
          color: themeController.isDarkMode.value ? Colors.white : null,
        ),
      ),
      onTap: () {
        Get.back();
        controller.onMenuTap(menu);
      },
    );
  }

  void _confirmLogout(BuildContext context) {
    ConfirmDialog.show(
      title: "Confirm Logout",
      message: "Are you sure you want to logout?",
      confirmText: "Logout",
      icon: Icons.logout,
      confirmColor: Colors.red,
      onConfirm: () async {
        await Preferences.clearAllData();
        AppManager.shared.loginModel = null;
        Get.offAllNamed(RouteName.loginScreen);
      },
    );
  }
}

class _GradientDashboardCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _GradientDashboardCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).extension<DashboardCardTheme>()!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: cardTheme.gradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.35),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

Widget _moduleRow(String title, int completed, int total) {
  final percent = total == 0 ? 0.0 : completed / total;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "$completed / $total",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: percent,
          minHeight: 6,
          backgroundColor: Colors.white.withOpacity(0.4),
          valueColor: AlwaysStoppedAnimation(
            percent == 1 ? Colors.green : Colors.black,
          ),
        ),
      ],
    ),
  );
}

class _StaticModuleRow extends StatelessWidget {
  final String title;
  final int completed;
  final int total;

  const _StaticModuleRow(this.title, this.completed, this.total);

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0.0 : completed / total;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "$completed / $total",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: percent,
            minHeight: 6,
            backgroundColor: Colors.white.withOpacity(0.4),
            valueColor: AlwaysStoppedAnimation(
                percent == 1 ? Colors.green : Colors.black),
          ),
        ],
      ),
    );
  }
}
