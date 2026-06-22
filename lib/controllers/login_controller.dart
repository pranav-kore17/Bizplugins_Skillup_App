import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/login_model.dart';
import '../utils/ApiManager/Repository/repository.dart';
import '../utils/ApiManager/prefernces.dart';
import '../utils/app_manager.dart';
import '../utils/routes.dart';
import 'package:bizplugins_skillup/utils/common_widgets/app_loader.dart';

class LoginController extends GetxController {

  /// Repository
  final AppRepository _repository = AppRepository();

  /// Text Controllers
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();

  /// States
  final RxBool rememberMe = true.obs;
  final RxBool isLoading = false.obs;

  /// ---------------------------
  /// Load saved credentials
  /// ---------------------------
  Future<void> loadSavedCredentials() async {
    userName.text = await Preferences.getLoginUsername();
    password.text = await Preferences.getLoginPassword();
  }

  /// ---------------------------
  /// Login API
  /// ---------------------------
  Future<void> loginAPI(BuildContext context) async {

    FocusManager.instance.primaryFocus?.unfocus();

    if (!_validateLogin()) return;

    try {
      AppLoader.show(context);

      final response =
          await _repository.loginAPI(userName.text.trim(), password.text.trim());

      AppLoader.hide();

      _handleLoginResponse(response);

    } catch (e) {

      AppLoader.hide();

      AppManager.showToast("Server error. Please try again later");
    }
  }

  /// ---------------------------
  /// Handle API Response
  /// ---------------------------
  Future<void> _handleLoginResponse(dynamic response) async {

    if (response["error"] != null) {
      AppManager.showToast(response["error"]["message"]);
      return;
    }

    if (response["status"] == 200 && response["Data"] != null) {

      AppManager.showToast(response["message"]);

      final loginModel = LoginModel.fromJson(response["Data"]);

      AppManager.shared.loginModel = loginModel;

      await Preferences.saveAcceessToken(loginModel.accessToken!);

      await _handleRememberMe();

      Get.offAllNamed(RouteName.dashboardScreen);

      return;
    }

    /// Validation errors
    if (response["Data"] != null) {

      String output = response["Data"].entries.map((entry) {

        String key = entry.key;
        String value = entry.value.join(", ");

        return "$key: $value";

      }).join(", ");

      AppManager.showToast(output);

    } else {

      AppManager.showToast(
          "Something went wrong! Please try again later");
    }
  }

  /// ---------------------------
  /// Remember Me Logic
  /// ---------------------------
  Future<void> _handleRememberMe() async {

    if (rememberMe.value) {

      await Preferences.saveLoginUsername(userName.text);
      await Preferences.saveLoginPassword(password.text);

    } else {

      await Preferences.clearLoginUsername();
      await Preferences.clearLoginPassword();
    }
  }

  /// ---------------------------
  /// Validation
  /// ---------------------------
  bool _validateLogin() {

    if (userName.text.trim().isEmpty) {
      AppManager.showToast("Please enter username");
      return false;
    }

    if (password.text.trim().isEmpty) {
      AppManager.showToast("Please enter password");
      return false;
    }

    return true;
  }

  /// ---------------------------
  /// Dispose
  /// ---------------------------
  @override
  void onClose() {
    userName.dispose();
    password.dispose();
    super.onClose();
  }
}