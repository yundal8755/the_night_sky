import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/app/service/firebase_service.dart';
import 'package:everyones_tone/data/model/chat_model.dart';
import 'package:everyones_tone/data/model/chat_message_model.dart';
import 'package:everyones_tone/data/model/post_model.dart';
import 'package:everyones_tone/data/model/user_model.dart';
import 'package:intl/intl.dart';

///
/// 답장 관련 원격 데이터 소스
///
class ReplyRemoteDataSource {
  ReplyRemoteDataSource();

  final firebaseService = getIt<FirebaseService>();

  FirebaseFirestore get firestore => firebaseService.firestoreInstance;

  /// 입력받은 정보를 DB에 업로드
  Future<void> uploadReply({
    required String localAudioUrl,
    required UserModel replyUser,
    required String replyDocumentId,
  }) async {
    final DocumentSnapshot<PostModel> postUserData =
        await firebaseService.postsCollection.doc(replyDocumentId).get();

    String replyUserAudioUrl = await firebaseService.uploadAudioFileInstance(
      localPath: localAudioUrl,
      contentType: 'audio/x-m4a',
    );
    if (replyUserAudioUrl.isEmpty) {
      print('오디오 파일 업로드 실패');
      return;
    }

    final postData = postUserData.data();
    if (postData == null) {
      print('게시글 정보를 찾을 수 없습니다.');
      return;
    }

    String postAudioUrl = postData.audioUrl;
    String postDateCreated = postData.dateCreated;
    String postTitle = postData.postTitle;
    String postUserEmail = postData.userEmail;
    String postUserNickname = postData.nickname;
    String postUserProfilePicUrl = postData.profilePicUrl;

    String replyUserEmail = replyUser.userEmail;
    String replyUserNickname = replyUser.nickname;
    String replyUserProfilePicUrl = replyUser.profilePicUrl;
    String dateCreated = DateFormat("MM/dd HH:mm:ss").format(DateTime.now());

    ChatModel chatModel = ChatModel(
      dateCreated: dateCreated,
      postTitle: postTitle,
      postUserEmail: postUserEmail,
      postUserNickname: postUserNickname,
      postUserProfilePicUrl: postUserProfilePicUrl,
      replyUserEmail: replyUserEmail,
      replyUserNickname: replyUserNickname,
      replyUserProfilePicUrl: replyUserProfilePicUrl,
    );

    ChatMessageModel postMessageModel = ChatMessageModel(
      audioUrl: postAudioUrl,
      dateCreated: postDateCreated,
      userEmail: postUserEmail,
    );

    ChatMessageModel replyMessageModel = ChatMessageModel(
      audioUrl: replyUserAudioUrl,
      dateCreated: dateCreated,
      userEmail: replyUserEmail,
    );

    print('ReplyRepository 실행 완료!');

    await uploadReplyRemote(
      chatModel,
      postMessageModel,
      replyMessageModel,
      replyDocumentId,
    );
  }

  /// chat Collection에 새로운 Document 생성 및 ID 할당
  Future<void> uploadReplyRemote(
      ChatModel chatModel,
      ChatMessageModel postMessageModel,
      ChatMessageModel replyMessageModel,
      String replyDocmentId) async {
    /// Chat Doc 생성 및 ID 할당
    final DocumentReference chatRef =
        firestore.collection(FirestoreCollection.chat.name).doc();
    chatModel.chatId = chatRef.id;

    /// Chat Field 생성
    await chatRef.set(chatModel.toMap());

    /// Post Message 정보 저장 및 ID 할당
    final DocumentReference postMessageRef =
        chatRef.collection(FirestoreSubCollection.message.name).doc();
    postMessageModel.chatId = chatRef.id;
    postMessageModel.messageId = postMessageRef.id;
    await postMessageRef.set(postMessageModel.toMap());

    /// user - myChat SubCollection 생성
    await createUserChatSubcollection(postMessageModel.userEmail, chatRef.id);

    /// Reply Message 정보 저장 및 ID 할당
    final DocumentReference replyMessageRef =
        chatRef.collection(FirestoreSubCollection.message.name).doc();
    replyMessageModel.chatId = chatRef.id;
    replyMessageModel.messageId = replyMessageRef.id;
    await replyMessageRef.set(replyMessageModel.toMap());

    await createUserChatSubcollection(replyMessageModel.userEmail, chatRef.id);
    await createPreviousRepliesSubcollection(
        replyMessageModel.userEmail, chatRef.id, replyDocmentId);
  }

  /// user - myChat SubCollection 생성
  Future<void> createUserChatSubcollection(
    String userEmail,
    String chatId,
  ) async {
    final DocumentReference userRef =
        firestore.collection(FirestoreCollection.user.name).doc(userEmail);

    // myChat SubCollection
    final CollectionReference myChatRef =
        userRef.collection(FirestoreSubCollection.myChat.name);
    final DocumentReference myChatNewDocRef = myChatRef.doc(chatId);

    await myChatNewDocRef.set({
      'chatId': chatId,
    });
  }

  /// user - previousReplies SubCollection 생성
  Future<void> createPreviousRepliesSubcollection(
      String userEmail, String chatId, String replyDocumentId) async {
    final DocumentReference userRef =
        firestore.collection(FirestoreCollection.user.name).doc(userEmail);

    // previousReplies SubCollection
    final CollectionReference previousRepliesRef =
        userRef.collection(FirestoreSubCollection.previousReplies.name);
    final DocumentReference previousRepliesNewDocRef =
        previousRepliesRef.doc(replyDocumentId);

    await previousRepliesNewDocRef.set({
      'previousReplyDocumentId': replyDocumentId,
    });
  }
}
