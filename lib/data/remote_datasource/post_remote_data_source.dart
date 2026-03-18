// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/data/model/post_model.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:intl/intl.dart';

class PostRemoteDataSource {
  PostRemoteDataSource(this.firebaseService);

  final FirebaseService firebaseService;

  FirebaseFirestore get _firestore => firebaseService.firestoreInstance;

  Future<void> uploadPostRemote(PostModel postModel) async {
    DocumentReference<PostModel> userRef =
        firebaseService.postsCollection.doc();

    await userRef.set(postModel);
    print('PostRemoteRepository 실행 완료!');
  }

  Stream<QuerySnapshot<PostModel>> postsStream() {
    return firebaseService.postsCollection
        .orderBy('dateCreated', descending: true)
        .snapshots();
  }

  Future<void> uploadPost({
    required String postTitle,
    required String localAudioUrl,
    required String userEmail,
    required String nickname,
    required String profilePicUrl,
  }) async {
    String audioUrl = await firebaseService.uploadAudioFileInstance(
      localPath: localAudioUrl,
      contentType: 'audio/x-m4a',
    );
    if (audioUrl.isEmpty) {
      print('오디오 파일 업로드 실패');
      return;
    }

    String dateCreated = DateFormat("MM/dd HH:mm:ss").format(DateTime.now());
    PostModel postModel = PostModel(
      nickname: nickname,
      postTitle: postTitle,
      audioUrl: audioUrl,
      userEmail: userEmail,
      profilePicUrl: profilePicUrl,
      dateCreated: dateCreated,
      boardName: '자유게시판',
    );

    print('PostRepository 실행 완료!');
    await uploadPostRemote(postModel);
  }
}
