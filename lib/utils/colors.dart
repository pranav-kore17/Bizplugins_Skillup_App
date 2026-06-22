import 'package:flutter/cupertino.dart';

/// PRIMARY COLORS
// const Color primaryPurple = Color(0xFF7C6DD3);
// const Color primaryColor = Color(0xFF0F6B73);
// const Color primaryColor = Color(0xFF009688);
const Color primaryColor = Color(0xFF0288D1);

const Color primaryPurple = Color(0xFF3F51B5);
const Color primaryBlue = Color(0xff4FC3F7);
const Color primaryOrange = Color(0xFFFC943E);
const Color primaryRed = Color(0xFFE53935);

/// STATUS COLORS
const Color successColor = Color(0xFF32AB58);
const Color errorColor = Color(0xFFAB3232);

/// BACKGROUND COLORS
const Color appBackground = Color(0xffFAFAFA);
const Color inputBg = Color(0xFFF7F7FA);
const Color lightPurpleBg = Color(0xFFF4F3FF);
const Color lightOrangeBg = Color(0xFFFFF1E6);
const Color inputOrangeBg = Color(0xFFFFE8D6);

/// UI COLORS
const Color menuSelectedColor = Color(0xff8B2B2B);
const Color softOrangeColor = Color(0xFFFFB74D);

/// NEUTRAL COLORS
const Color neutral = Color(0xFFE7E7E7);
const Color darkBackground = Color(0xFF1A3464);

const Color videoProgressColor = Color(0xFF4CAF50);

/// Badge colors - Light mode
const Color salesBadgeLightBg = Color(0xFFF4F3FF);
const Color salesBadgeLightText = Color(0xFF6C63FF);

/// Badge colors - Dark mode
const Color salesBadgeDarkBg = Color(0xFF2A275F);
const Color salesBadgeDarkText = Color(0xFFB8B5FF);

/// APP BACKGROUND GRADIENT
const LinearGradient appBackgroundGradient = LinearGradient(
  colors: [
    Color(0xFFFFF7EC),
    Color(0xFFFFE8C6),
    Color(0xFFFFCC80),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

/// LOGIN HEADER GRADIENT
const LinearGradient loginHeaderGradient = LinearGradient(
  colors: [
    Color(0xFFF97204),
    Color(0xFFFF9800),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient appBackgroundGradientSoft = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF0F6B73),
    Color(0xFF2A8F98),
    Color(0xFF6FC3C8),
  ],
);