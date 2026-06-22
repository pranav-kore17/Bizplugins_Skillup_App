import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:bizplugins_skillup/utils/ApiManager/Repository/repository.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/utils/text_styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final double? height;
  final Icon? icon;
  final TextInputType? keyboardType;
  final bool? isDropDown;
  final Function? onTap;
  final bool? secureText;
  final int? maxLength;
  final int? maxLines;
  final bool? isDatePicker;
  final bool? makeDisable;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(String)? onDateSelect;
  final Function? onSubmitted;
  final Function(String)? onTextChange;
  final bool? isTimePicker;
  final TextInputAction? textInputAction;
  const AppTextField({
    super.key,
      this.controller,
      required this.placeholder,
      this.height,
      this.icon,
      this.keyboardType,
      this.isDropDown,
      this.onTap,
      this.secureText,
      this.maxLength,
      this.maxLines,
      this.isDatePicker,
      this.makeDisable,
      this.initialDate,
      this.onDateSelect,
      this.isTimePicker,
      this.firstDate,
      this.lastDate,
      this.onTextChange,
      this.textInputAction,
    this.onSubmitted
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: TextField(
        focusNode: (isDatePicker ?? false) ||
                (makeDisable ?? false) ||
                (isTimePicker ?? false)
            ? AlwaysDisabledFocusNode()
            : null,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: makeDisable,
          border: InputBorder.none,
          labelText: placeholder,
          labelStyle: fontRegularStyle(fontSize: 14),
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(color: errorColor, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(
                color: (makeDisable ?? false) ? Colors.grey : errorColor,
                width: 0.5),
          ),
          // prefixIcon: (isDatePicker ?? false) ? const Icon(Icons.calendar_month, color: errorColor,) : null,
          suffixIcon: icon ??
              ((isDropDown ?? false)
                  ? const Icon(Icons.arrow_drop_down)
                  : ((isDatePicker ?? false)
                      ? const Icon(Icons.calendar_month, color: Colors.grey)
                      : ((isTimePicker ?? false)
                          ? const Icon(Icons.access_time, color: Colors.grey)
                          : null))),
        ),
        readOnly: isDropDown ?? false,
        obscureText: secureText ?? false,
        inputFormatters: keyboardType == TextInputType.number
            ? [
                FilteringTextInputFormatter
                    .digitsOnly, // Restricts input to digits only
              ]
            : null,
        onTap: () {
          if (makeDisable ?? false) {
            return;
          }
          if (isDatePicker ?? false) {
            _showDatePicker();
            return;
          }
          if ((isDropDown ?? false) && onTap != null) {
            onTap!();
            return;
          }
          if (isTimePicker ?? false) {
            _showTimePicker();
            return;
          }
        },
        maxLength: maxLength,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        onChanged: (text) {
          if (onTextChange != null) {
            onTextChange!(text);
          }
        },
        textInputAction: textInputAction,
        onSubmitted: (v) {
          if (textInputAction == TextInputAction.next) {
            FocusScope.of(context).nextFocus();
          }
          if (onSubmitted != null) {
            onSubmitted!();
          }
        },
      ),
    );
  }

  _showDatePicker() {
    showDatePicker(
        context: Get.context!,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(1901, 1),
        lastDate: lastDate ?? DateTime(2040, 1),
        builder: (context, picker) {
          return Theme(
            //TODO: change colors
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: primaryColor,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: picker!,
          );
        }).then((selectedDate) {
      if (selectedDate != null) {
        String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
        if (onDateSelect != null) {
          onDateSelect!(formattedDate);
        }
      }
    });
  }

  _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
        builder: (context, picker) {
          return Theme(
            //TODO: change colors
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: primaryColor,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
            ),
            child: picker!,
          );
        });
    if (picked != null) {
      controller?.text = "${picked.hour}:${picked.minute}";
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
