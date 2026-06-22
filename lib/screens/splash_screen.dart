import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(RouteName.loginScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // no bg image
      body: Center(
        child: Image(
          image: AssetImage("assets/images/splasescreen.png"),
          width: 240,
        ),
      ),
    );
  }
}