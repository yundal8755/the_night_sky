import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyle {
  AppTextStyle(Color primaryBlue);

  //! 페이지의 핵심이 되는 텍스트에 주로 사용한다
  /// MainAppBar, navigationPage -> 제목
  static TextStyle headlineLarge([Color color = AppColor.neutrals20]) =>
      TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: -0.2,
      );

  //! Bottom Sheet의 제목이 되는 텍스트에 주로 사용한다
  /// SubAppBar -> 제목
  static TextStyle headlineMedium([Color color = AppColor.neutrals20]) =>
      TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: -0.2,
      );

  //! 페이지에서 강조하고 싶은 텍스트에 주로 사용된다
  /// PostPage -> 제목을 입력해주세요, 제목
  /// PostingCard -> Title
  /// ProfilePage -> 닉네임
  static TextStyle titleLarge([Color color = AppColor.neutrals20]) => TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: -0.2,
      );

  //! 중요도가 비교적 높은 텍스트에 주로 사용된다
  /// HomePage -> 닉네임
  /// PostPage -> 닉네임
  /// SubAppBar -> 완료 버튼
  static TextStyle bodyLarge([Color color = AppColor.neutrals20]) => TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.2,
      );

  //! 중요도가 비교적 낮은 일반적인 텍스트에 주로 사용된다
  /// SubAppBar -> 취소 버튼
  /// HomePage -> 게시판 이름
  /// ProfilePage -> ListTile text
  /// PostPage -> 녹음 상태 알림
  /// ChatPage -> 메시지 상태 알림
  static TextStyle bodyMedium([Color color = AppColor.neutrals20]) => TextStyle(
      fontFamily: 'PretendardVariable',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0.2);

  //! 이용약관에 주로 사용된다
  /// SnsLoginPage -> 이용약관
  static TextStyle bodySmall([Color color = AppColor.neutrals20]) => TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: color,
        letterSpacing: 0.2,
      );

  //! 영역을 구분하는 텍스트에 주로 사용된다
  /// ProfilePage -> 안내 라벨 (프로필, 고객센터)
  static TextStyle labelLarge([Color color = AppColor.neutrals20]) => TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: -0.2,
      );

  //! 작은 Label에 주로 사용된다.
  /// PostPage -> '게시글 제목' Label
  static TextStyle labelMedium([Color color = AppColor.neutrals20]) =>
      TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.2,
      );

  static void helloWorld(int age) {}
}
