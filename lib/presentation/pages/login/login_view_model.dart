// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      // 일단 로그아웃하기
      await _auth.signOut();
      await _googleSignIn.signOut();

      var userDocRef =
          _firestore.collection('user').doc(FirestoreData.currentUserEmail);

      // 서브컬렉션 내의 모든 문서를 가져옵니다.
      var myChatSnapshot = await userDocRef.collection('myChat').get();
      for (var myChat in myChatSnapshot.docs) {
        await myChat.reference.delete();
      }

      // 채팅방 문서 자체를 삭제합니다.
      await userDocRef.delete();
    } catch (e) {
      // 오류 처리
      print("회원 탈퇴 중 오류 발생: $e");
    }
  }
}
