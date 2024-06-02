import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/widgets/layout/background_gradient.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 0), () {
      setState(() {
        _visible = true;
      });
    });
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BottomNavBarPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width / 3;
    return BackgroundGradient(
      child: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          child: Image.asset(
            AppAssets.mainAppIconImage,
            width: iconSize,
            height: iconSize,
          ),
        ),
      ),
    );
  }
}
