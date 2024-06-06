// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
    // 구글 로그인 화면 이동
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    // 구글 계정 확인
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      return user;
    }
    return null;
  }

  //! 애플 로그인
  Future<User?> appleSignInMethod() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final AuthCredential appleCredential =
        OAuthProvider('apple.com').credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(appleCredential);
    final User? user = authResult.user;
    return user;
  }

  //! 사용자 정보 저장
  Future<bool> isUserRegistered(String email) async {
    final userDocument =
        FirebaseFirestore.instance.collection('user').doc(email);
    final doc = await userDocument.get();
    print('user Doc에 user.email 콜렉션 추가!');
    return doc.exists;
  }

  //! 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  //! 회원탈퇴
  Future<void> deleteUserAccount() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception("User is not logged in");
      }

      var userDocRef = _firestore.collection('user').doc(currentUser.email);

      var myChatSnapshot = await userDocRef.collection('myChat').get();
      for (var myChat in myChatSnapshot.docs) {
        await myChat.reference.delete();
      }

      var previousRepliesSnapshot =
          await userDocRef.collection('previousReplies').get();
      for (var previousReplies in previousRepliesSnapshot.docs) {
        await previousReplies.reference.delete();
      }

      // 채팅방 문서 자체를 삭제
      await userDocRef.delete();

      // 로그아웃하기
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print("회원 탈퇴 중 오류 발생: $e");
    }
  }
}
