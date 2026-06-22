import 'dart:ffi';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:irujul_erp/models/login_model.dart';
import 'package:bizplugins_skillup/models/login_model.dart';
// import 'package:irujul_erp/utils/colors.dart';
// import 'package:irujul_erp/utils/common_widgets/app_bottom_sheet.dart';

// import '../models/branch_model.dart';

class AppManager {
  static final AppManager shared = AppManager._internal();
  final Connectivity _connectivity = Connectivity();

  String appUrl = "";
  LoginModel? loginModel;
  // BranchModel?  branchModel;
  factory AppManager() {
    return shared;
  }
  AppManager._internal();

  void greet(String name, [String greeting = 'Hello']) {
    print('$greeting, $name!');
  }

  // showActionSheet(List<String> arrList, String title, Function(int) onSelect, [bool enableSearch = false]) {
  //   Get.bottomSheet(AppBottomSheet(items: arrList, title: title, onSelect: (String value) {
  //     int index = arrList.indexOf(value);
  //     onSelect(index);
  //     Get.back();
  //   }, enableSearch: enableSearch,));
  // }

  String convertDateFormat(
      String inputDate, String currentFormat, String newFormat) {
    if (inputDate.isEmpty) {
      return "";
    }
    final DateFormat inputFormat = DateFormat(currentFormat);
    final DateFormat outputFormat = DateFormat(newFormat);
    DateTime dateTime = inputFormat.parse(inputDate);
    return outputFormat.format(dateTime);
  }

  static showToast(String message) {
    Fluttertoast.showToast(msg: message, timeInSecForIosWeb: 3);
  }

  Future<bool> isConnectedToInternet() async {
    List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      result = [ConnectivityResult.none];
    }
    return result[0] != ConnectivityResult.none;
  }

  bool isEndDateGreaterThanStartDate(String startDate, String endDate) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    DateTime sDate = dateFormat.parse(startDate);
    DateTime eDate = dateFormat.parse(endDate);
    if (eDate.isAfter(sDate)) {
      return true;
    }
    return false;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
