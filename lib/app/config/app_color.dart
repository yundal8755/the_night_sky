import 'package:flutter/material.dart';

abstract class AppColor {
  const AppColor._();

  // 무채색
  static const neutrals20 = Color(0xFFE1E1E1);
  static const neutrals40 = Color(0xFFAAAAAA);
  static const neutrals60 = Color(0xFF626262);
  static const neutrals80 = Color(0xFF1F1F1F);
  static const neutrals90 = Color(0xFF131313);

  // 메인색
  static const primaryBlue = Color(0xFF118EEF);
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColor.primaryBlue, Color(0xFFdd12e1)],
  );

  // 보조색
  static const secondaryRed = Color(0xFFfc325d);
  static const secondaryOrange = Color(0xFFFF9800);
  static const secondaryYellow = Color(0xFFFFEB3B);
  static const secondaryGreen = Color(0xFF4CAF50);
  static const secondaryIndigo = Color(0xFF3F51B5);
  static const secondaryPurple = Color(0xFF9C27B0);

  // 배경색
  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF02121e), Colors.black87],
  );
}
