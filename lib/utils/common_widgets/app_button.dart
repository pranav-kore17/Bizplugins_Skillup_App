import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/utils/text_styles.dart';

class AppButton extends StatelessWidget {
  final String btnName;
  final Function() onPressed;
  double? radius;
  double? height;
  double? width;
  double? textSize;

  AppButton({
    super.key,
    required this.btnName,
    required this.onPressed,
    this.radius,
    this.height,
    this.width,
    this.textSize,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        height: height != null ? height! : 50,
        width: width != null ? width! : double.infinity,
        decoration: BoxDecoration(
          color: successColor,
          borderRadius: BorderRadius.circular(radius ?? 10.0),
        ),
        child: Center(
          child: Text(
            btnName,
            style: fontRegularStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
