import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static saveClientServerData(dynamic details) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ClientServerData", jsonEncode(details));
    prefs.setString("ServerDataSaveTime", DateTime.now().toString());
  }

  static getClientServerData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String details = prefs.getString("ClientServerData") ?? "";
    if (details.isEmpty) {
      return null;
    }
    dynamic data = jsonDecode(details);
    return data;
  }

  static shouldShowServerPinDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? strDate = prefs.getString("ServerDataSaveTime");
    if (strDate != null && strDate!.isNotEmpty) {
      DateTime parsedDate = DateTime.parse(strDate);
      DateTime now = DateTime.now();
      Duration difference = now.difference(parsedDate);
      if (difference.inHours > 24) {
        print("The date is more than 24 hours ago.");
        return true;
      } else {
        print("The date is within the last 24 hours.");
        return false;
      }
    } else {
      return true;
    }
  }

  static saveAcceessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("AccessToken", token);
  }

  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.get("AccessToken");
    return token ?? "";
  }

  static saveIsFirstTimeLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("IsFirstTimeLaunch", false);
  }

  static Future<bool> isFirstTimeLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic isLaunch = prefs.get("IsFirstTimeLaunch") ?? true;
    return isLaunch;
  }

  static saveLoginUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("LoginUsername", username);
  }

  static getLoginUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("LoginUsername") ?? "";
    return username;
  }

  static saveLoginPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("LoginPassword", password);
  }

  static getLoginPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString("LoginPassword") ?? "";
    return password;
  }

  static clearLoginUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("LoginUsername");
    prefs.remove("LoginPassword");
  }

  static clearLoginPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("LoginPassword");
  }

  static clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("AccessToken");
    prefs.remove("UserDetails");
  }

  static saveUserDetails(dynamic details) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("UserDetails", jsonEncode(details));
  }

  static getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String details = prefs.getString("UserDetails") ?? "";
    if (details.isEmpty) {
      return null;
    }
    dynamic data = jsonDecode(details);
    return data;
  }
}
