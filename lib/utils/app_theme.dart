import 'package:flutter/material.dart';
import 'colors.dart';

@immutable
class DashboardCardTheme extends ThemeExtension<DashboardCardTheme> {
  final LinearGradient gradient;

  const DashboardCardTheme({required this.gradient});

  @override
  DashboardCardTheme copyWith({LinearGradient? gradient}) {
    return DashboardCardTheme(
      gradient: gradient ?? this.gradient,
    );
  }

  @override
  DashboardCardTheme lerp(ThemeExtension<DashboardCardTheme>? other, double t) {
    if (other is! DashboardCardTheme) return this;
    return DashboardCardTheme(
      gradient: LinearGradient.lerp(gradient, other.gradient, t)!,
    );
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(primary: primaryColor),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return primaryColor; // checked color
      }
      return Colors.grey.shade400; // unchecked border
    }),
    checkColor: MaterialStateProperty.all(Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: primaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade100,
    hintStyle: const TextStyle(color: Colors.black54),
    prefixIconColor: Colors.grey,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  extensions: const [
    DashboardCardTheme(
      gradient: LinearGradient(
        colors: [
          Color(0xFFB3E5FC),
          Color(0xFFE1BEE7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ],
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF020617),
  cardColor: const Color(0xFF1E293B),
  dividerColor: Colors.white24,
  colorScheme: const ColorScheme.dark(
    primary: const Color(0xFF0F172A),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white; // checked bg in dark
      }
      return Colors.white54; // unchecked border
    }),
    checkColor: MaterialStateProperty.all(
      Color(0xFF020617), // dark tick
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0F172A),
    foregroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF0F172A),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E293B),
    hintStyle: const TextStyle(color: Colors.white54),
    prefixIconColor: Colors.white70,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),
  extensions: const [
    DashboardCardTheme(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1E293B), // slate dark
          Color(0xFF020617), // deep dark
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ],
);
