import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final bool showBackButton;
  final VoidCallback? onBack;

  const GlobalAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return AppBar(
      centerTitle: true,
      elevation: 0,

      /// TITLE
      title: title,

      /// LEFT ICON (MENU or BACK)
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              tooltip: "Back",
              onPressed: onBack ?? () => Get.back(),
            )
          : Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                tooltip: "Menu",
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),

      /// RIGHT ACTIONS
      actions: [
        Obx(() {
          final isDark = themeController.isDarkMode.value;

          return IconButton(
            tooltip: isDark ? "Light Mode" : "Dark Mode",
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) =>
                  RotationTransition(turns: anim, child: child),
              child: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
                key: ValueKey(isDark),
              ),
            ),
            onPressed: themeController.toggleTheme,
          );
        }),

        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}