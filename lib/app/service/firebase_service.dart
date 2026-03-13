import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/data/post/dto/post_model.dart';
import 'package:everyones_tone/data/user/dto/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

///
/// Firestore 컬렉션 이름
///
enum FirestoreCollection {
  user,
  post,
  chat,
  report;
}

///
/// Firebase Service
/// Firestore 컬렉션 참조 및 파일 업로드 메서드 제공
///
final class FirebaseService {
  FirebaseService._();

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static User? get currentUser => auth.currentUser;
  static String? get currentUserEmail => currentUser?.email;

  /// Firestore 컬렉션 참조
  static CollectionReference<UserModel> get users =>
      firestore.collection(FirestoreCollection.user.name).withConverter(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );
  static CollectionReference<PostModel> get posts =>
      firestore.collection(FirestoreCollection.post.name).withConverter(
            fromFirestore: (snapshot, _) =>
                PostModel.fromJson(snapshot.data()!),
            toFirestore: (post, _) => post.toJson(),
          );
  static CollectionReference<Map<String, dynamic>> get chats =>
      firestore.collection(FirestoreCollection.chat.name);
  static CollectionReference<Map<String, dynamic>> get reports =>
      firestore.collection(FirestoreCollection.report.name);

  /// Firestore에서 현재 사용자 데이터 가져오기
  static Future<UserModel?> fetchCurrentUser() async {
    final userEmail = currentUserEmail;
    if (userEmail == null) {
      return null;
    }
    final doc = await users.doc(userEmail).get();
    return doc.data();
  }

  /// Firestore에서 사용자가 특정 게시글에 이미 댓글을 남겼는지 확인
  static Future<bool> hasRepliedBefore(
    String userEmail,
    String replyDocumentId,
  ) async {
    final userDoc = await users.doc(userEmail).get();
    if (!userDoc.exists) {
      return false;
    }

    final previousReplies =
        await userDoc.reference.collection('previousReplies').get();
    for (var doc in previousReplies.docs) {
      if (doc.id == replyDocumentId) {
        return true;
      }
    }

    return false;
  }

  ///
  /// TODO : 적합한 dart 파일로 분리하기
  /// 오디오 파일 업로드
  static Future<String> uploadAudioFile({
    required String localPath,
    String folder = 'audio_url',
    String? contentType,
  }) async {
    final file = File(localPath);
    try {
      final fileName = '$folder/${DateTime.now().millisecondsSinceEpoch}.m4a';
      final ref = storage.ref().child(fileName);

      UploadTask uploadTask;
      if (contentType != null && contentType.isNotEmpty) {
        uploadTask = ref.putFile(
          file,
          SettableMetadata(contentType: contentType),
        );
      } else {
        uploadTask = ref.putFile(file);
      }

      await uploadTask.whenComplete(() => null);
      return await ref.getDownloadURL();
    } catch (e) {
      return '';
    }
  }
}
