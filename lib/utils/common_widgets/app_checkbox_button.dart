import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizplugins_skillup/utils/text_styles.dart';

class AppCheckboxButton extends StatelessWidget {
  String title  = "";
  bool isSelected = false;
  Function onTap;
  AppCheckboxButton({super.key, required this.title, required this.isSelected,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          SizedBox(
            width: 25,
            height: 25,
            child: Image.asset(isSelected ?"assets/images/check.png" : "assets/images/unchecked.png"),
          ),
          SizedBox(width: 10,),
          Expanded(child: Text(title, style: fontRegularStyle(fontSize: 13),))
        ],
      ),
    );
  }
}
