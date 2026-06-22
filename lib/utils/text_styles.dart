import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle fontRegularStyle(
    {Color? color,
      double? fontSize,
      TextDecoration? decoration,
      double? decorationThickness,
      Color? decorationColor,
      FontWeight? fontWeight}) {
  return GoogleFonts.poppins(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness);
}

TextStyle fontSemiBoldStyle(
    {Color? color, double? fontSize, TextDecoration? decoration}) {
  return GoogleFonts.poppins(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      decoration: decoration);
}

TextStyle fontBoldStyle(
    {Color? color, double? fontSize, TextDecoration? decoration}) {
  return GoogleFonts.poppins(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      decoration: decoration);
}