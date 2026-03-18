import 'package:everyones_tone/app/constant/app_assets.dart';
import 'package:everyones_tone/app/router/app_router.dart';
import 'package:everyones_tone/presentation/common/widget/layout/background_gradient.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
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
      if (!mounted) return;
      context.go(AppRouteLocation.home);
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
