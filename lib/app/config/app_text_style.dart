import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyle {
  AppTextStyle(Color primaryBlue);

  /// 주로 AppBar의 Title에 주로 사용된다.
  /// 예시
  /// 홈, 채팅방, 음색 업로드, 메시지 보내기, 각종 navigationPage, 제목
  static TextStyle appBarTitle() => const TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColor.neutrals20,
        letterSpacing: -0.2,
      );

  /// 강조하는 텍스트에 주로 사용된다
  /// 예시
  /// PostPage -> 제목을 입력해주세요
  /// ProfilePage -> 닉네임,프로필,고객센터
  static TextStyle mainTitle(Color color) => TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: -0.2,
      );

  /// 주로 닉네임에 사용된다
  /// 예시
  /// HomePage -> 닉네임
  /// PostPage -> 취소
  static TextStyle bodyMedium(Color color) => TextStyle(
      fontFamily: 'PretendardVariable',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0.2);

  /// 주로 작은 텍스트중에 강조로 사용된다
  /// 예시
  /// 전송 버튼
  /// ProfilePage -> ListTile text
  static TextStyle bodyBold(Color color) => TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: -0.2,
      );

  /// 주로 이용약관에 사용된다
  /// 예시
  /// 이용약관
  static TextStyle bodyLight(Color color) => TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: color,
        letterSpacing: -0.2,
      );

  /// 주로 Label로 사용된다.
  /// 예시
  /// 게시글 제목 Label, 게시판 이름 Label
  static TextStyle labelMedium(Color color) => TextStyle(
        fontFamily: 'PretendardVariable',
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: color,
        letterSpacing: -0.2,
      );
}
