import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizplugins_skillup/utils/app_manager.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/utils/routes.dart';
import 'package:bizplugins_skillup/utils/common_widgets/confirm_dialog.dart';
import '../utils/ApiManager/Repository/repository.dart';
import '../utils/ApiManager/prefernces.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppManager.shared.loginModel;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// PROFILE IMAGE
              CircleAvatar(
                radius: 45,
                backgroundColor: primaryColor.withOpacity(0.15),
                backgroundImage: const AssetImage(
                  'assets/images/img_user.png',
                ),
              ),

              const SizedBox(height: 14),

              /// USER NAME
              Text(
                user?.defaultExecutiveName ?? "User Name",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              /// COMPANY
              Text(
                user?.companyName ?? "Company Name",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 2),

              /// BRANCH
              Text(
                user?.branchName ?? "Branch Name",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 20),

              const Divider(),

              const SizedBox(height: 10),

              /// USER INFO ROWS
              _buildInfoRow(
                  Icons.person, "Executive", user?.defaultExecutiveName ?? "-"),

              _buildInfoRow(
                  Icons.business, "Company", user?.companyName ?? "-"),

              _buildInfoRow(
                  Icons.location_city, "Branch", user?.branchName ?? "-"),

              const SizedBox(height: 20),

              /// LOGOUT BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _confirmLogout(context);
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// INFO ROW WIDGET
  static Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: primaryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$title : $value",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
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
        Get.offAllNamed(RouteName.loginScreen);
      },
    );
  }
}
