import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyle {
  AppTextStyle(Color primaryBlue);

  //! 페이지의 핵심이 되는 텍스트에 주로 사용한다
  /// 게시글 제목
  static TextStyle headlineLarge([Color color = AppColor.neutrals20]) =>
      TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: 0.2,
      );

  //! Bottom Sheet의 제목이 되는 텍스트에 주로 사용한다
  /// MainAppBar 타이틀
  static TextStyle headlineMedium([Color color = AppColor.neutrals20]) =>
      TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: 0.2,
      );

  //! 페이지에서 강조하고 싶은 텍스트에 주로 사용된다
  /// subAppBar 타이틀, ProfilePage 닉네임,
  static TextStyle titleLarge([Color color = AppColor.neutrals20]) => TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: 0,
      );

  //! 중요도가 비교적 높은 텍스트에 주로 사용된다
  /// 완료 버튼,닉네임(강조
  static TextStyle titleMedium([Color color = AppColor.neutrals20]) =>
      TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0,
      );

  //! 중요도가 비교적 높은 텍스트에 주로 사용된다
  /// 완료 버튼,닉네임(강조
  static TextStyle titleSmall([Color color = AppColor.neutrals20]) =>
      TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0,
      );

  //! 중요도가 비교적 낮은 일반적인 텍스트에 주로 사용된다
  /// ProfilePage -> ListTile text
  /// PostPage -> 녹음 상태 알림
  /// ChatPage -> 메시지 상태 알림
  /// 닉네임, 취소 버튼,
  static TextStyle bodyLarge([Color color = AppColor.neutrals20]) => TextStyle(
      fontFamily: 'PretendardVariable',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0);

  //! 이용약관에 주로 사용된다
  /// SnsLoginPage -> 이용약관
  static TextStyle bodyMedium([Color color = AppColor.neutrals20]) => TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: color,
        letterSpacing: 0.2,
      );

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
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: -0.2,
      );

  //! 작은 Label에 주로 사용된다.
  /// PostPage -> '게시글 제목' Label
  /// 녹음 상태 알림, 메시지 전송 시간, 전체 메시지 개수
  static TextStyle labelMedium([Color color = AppColor.neutrals20]) =>
      TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: 0.2,
      );
}
