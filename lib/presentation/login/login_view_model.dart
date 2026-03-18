// ignore_for_file: file_names, avoid_print

import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:everyones_tone/data/remote_datasource/auth_remote_data_source.dart';

class LoginViewModel extends ChangeNotifier {
  final authRepository = getIt<AuthRemoteDataSource>();

  bool _termsAccepted = false;
  bool _privacyAccepted = false;

  bool get termsAccepted => _termsAccepted;
  bool get privacyAccepted => _privacyAccepted;

  //! 이용약관 체크박스
  void setTermsAccepted(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

  void setPrivacyAccepted(bool value) {
    _privacyAccepted = value;
    notifyListeners();
  }

  bool get isFormValid => _termsAccepted && _privacyAccepted;

  //! 구글 로그인
  Future<User?> googleSignInMethod() async {
    return authRepository.googleSignInMethod();
  }

  //! 애플 로그인
  Future<User?> appleSignInMethod() async {
    return authRepository.appleSignInMethod();
  }

  //! 사용자 정보 저장
  Future<bool> isUserRegistered(String email) async {
    return authRepository.isUserRegistered(email);
  }

  //! 로그아웃
  Future<void> signOut() async {
    await authRepository.signOut();
  }

  //! 회원탈퇴
  Future<void> deleteUserAccount() async {
    await authRepository.deleteUserAccount();
  }
}
