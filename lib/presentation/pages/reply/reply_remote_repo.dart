// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/models/reply_model.dart';

class ReplyRemoteRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> uploadReply(ReplyModel replyModel) async {
    //! 세팅하기
    /// 최초 메신저의 post data 가져오기
    DocumentSnapshot postUserInfo =
        await firestore.collection('post').doc(replyModel.replyDocmentId).get();

    /// chat doc
    final DocumentReference chatRef = firestore.collection('chat').doc();

    /// field값 - dateCreated
    await chatRef.set({'dateCreated': replyModel.dateCreated});

    //! participants SubCollection
    /// postUserInfo
    chatRef
        .collection('participants')
        .doc('postUser_${postUserInfo['userEmail']}')
        .set({
      'nickname': postUserInfo['nickname'],
      'userEmail': postUserInfo['userEmail'],
      'profilePicUrl': postUserInfo['profilePicUrl'],
      'postTitle': postUserInfo['postTitle']
    });

    /// replyUserInfo
    chatRef
        .collection('participants')
        .doc('replyUser_${replyModel.userEmail}')
        .set({
      'nickname': replyModel.nickname,
      'userEmail': replyModel.userEmail,
      'profilePicUrl': replyModel.profilePicUrl
    });

    //! messages SubCollection
    /// originalMessageInfo
    chatRef
        .collection('messages')
        .doc('1번째_메시지_${postUserInfo['userEmail']}')
        .set({
      'audioUrl': postUserInfo['audioUrl'],
      'dateCreated': postUserInfo['dateCreated']
    });

    /// replyMessageInfo
    chatRef.collection('messages').doc('2번째_메시지_${replyModel.userEmail}').set({
      'audioUrl': replyModel.audioUrl,
      'dateCreated': replyModel.dateCreated
    });
  }
}
