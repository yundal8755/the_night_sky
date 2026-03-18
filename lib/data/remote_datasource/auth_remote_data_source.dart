// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

///
/// 인증 관련 원격 데이터 소스
///
class AuthRemoteDataSource {
  AuthRemoteDataSource(this.googleSignIn);

  final firebaseService = getIt<FirebaseService>();

  final GoogleSignIn googleSignIn;

  FirebaseAuth get _auth => firebaseService.authInstance;
  FirebaseFirestore get _firestore => firebaseService.firestoreInstance;

  Stream<User?> userChanges() => _auth.userChanges();

  /// 구글 로그인
  Future<User?> googleSignInMethod() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

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

  /// 애플 로그인
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

  /// 사용자 정보 저장
  Future<bool> isUserRegistered(String email) async {
    final userDocument = firebaseService.usersCollection.doc(email);
    final doc = await userDocument.get();
    print('user Doc에 user.email 콜렉션 추가!');
    return doc.exists;
  }

  /// 사용자 프로필 등록
  Future<void> registerUserDataRemote(UserModel userModel) async {
    DocumentReference<UserModel> userRef =
        FirebaseService.users.doc(userModel.userEmail);
    await userRef.set(userModel);
  }

  /// 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
  }

  /// 회원탈퇴
  Future<void> deleteUserAccount() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception("User is not logged in");
      }

      var userDocRef = _firestore
          .collection(FirestoreCollection.user.name)
          .doc(currentUser.email);

      var myChatSnapshot =
          await userDocRef.collection(FirestoreSubCollection.myChat.name).get();
      for (var myChat in myChatSnapshot.docs) {
        await myChat.reference.delete();
      }

      var previousRepliesSnapshot = await userDocRef
          .collection(FirestoreSubCollection.previousReplies.name)
          .get();
      for (var previousReplies in previousRepliesSnapshot.docs) {
        await previousReplies.reference.delete();
      }

      await userDocRef.delete();

      await _auth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      print("회원 탈퇴 중 오류 발생: $e");
    }
  }
}
