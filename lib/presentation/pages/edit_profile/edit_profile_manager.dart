import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/repository/firestore_data.dart';
import 'package:flutter/material.dart';

class EditProfileManager extends ChangeNotifier {
  //! 랜덤 리스트
  List<String> adjectiveWords = [
    '행복한',
    '즐거운',
    '멋진',
    '아름다운',
    '빛나는',
    '활기찬',
    '용기있는',
    '창의적인',
    '따뜻한',
    '사랑스러운',
    '친절한',
    '정직한',
    '우아한',
    '평화로운',
    '자유로운',
    '성실한',
    '강인한',
    '넉넉한',
    '영리한',
    '유능한',
    '정열적인',
    '세련된',
    '재미있는',
    '신선한',
    '감사하는',
    '희망찬',
    '밝은',
    '당당한',
    '차분한',
    '열정적인',
    '독창적인',
    '매력적인',
    '우수한',
    '놀라운',
    '화려한',
    '슬픈',
    '기쁜',
    '조용한',
    '건강한',
    '복잡한',
    '간단한',
    '빠른',
    '느린',
    '젊은',
    '똑똑한',
    '엉뚱한',
    '겸손한',
    '보통의'
  ];

  List<String> noneWords = [
    '강아지',
    '고양이',
    '나무',
    '장미',
    '사자',
    '호랑이',
    '바나나',
    '딸기',
    '매미',
    '벚꽃',
    '기린',
    '코끼리',
    '사과',
    '배추',
    '펭귄',
    '제비',
    '해바라기',
    '단풍나무',
    '수박',
    '토마토',
    '양귀비',
    '물고기',
    '늑대',
    '달팽이',
    '백합',
    '오리',
    '토끼',
    '참나무',
    '침착맨',
    '소나무',
    '단풍',
    '민들레',
    '달맞이',
    '구절초',
    '튤립',
    '철쭉',
    '산딸기',
    '국화',
    '금잔화',
    '팬지',
    '코스모스',
    '붓꽃',
    '옥잠화',
    '해바라기',
    '꽃게',
    '도룡뇽',
    '북극곰',
    '낙타',
    '까치',
    '도마뱀',
    '수탉',
    '암탉',
    '황새',
    '캥거루',
    '고슴도치',
    '돌고래',
    '나비',
    '미어캣',
    '여우',
    '족제비',
    '다람쥐',
    '문어',
    '망둥어',
    '도가니',
    '참새',
    '까마귀',
    '앵무새',
    '두루미',
    '까치밥',
    '허수아비',
    '거북이',
    '파충류',
    '고라니',
    '청개구리',
    '오소리',
    '멧돼지',
    '사슴',
    '가재',
    '새우',
    '오징어',
    '미역',
    '잉어',
    '복숭아',
    '앵두',
    '코알라',
    '판다',
    '모란',
    '선인장'
  ];

  List<String> randomProfileImages = [
    AppAssets.profileRandomImage01,
    AppAssets.profileRandomImage02,
    AppAssets.profileRandomImage03,
    AppAssets.profileRandomImage04,
    AppAssets.profileRandomImage05,
    AppAssets.profileRandomImage06,
    AppAssets.profileRandomImage07,
    AppAssets.profileRandomImage08,
    AppAssets.profileRandomImage09,
    AppAssets.profileRandomImage10,
    AppAssets.profileRandomImage11,
    AppAssets.profileRandomImage12,
    AppAssets.profileRandomImage13,
    AppAssets.profileRandomImage14,
    AppAssets.profileRandomImage15,
    AppAssets.profileRandomImage16,
    AppAssets.profileRandomImage17,
    AppAssets.profileRandomImage18,
    AppAssets.profileRandomImage19,
    AppAssets.profileRandomImage20,
  ];

  //! 변수 설정
  ValueNotifier<String> nickname = ValueNotifier<String>('');
  ValueNotifier<String> profilePicUrl = ValueNotifier<String>('');

  //! Constructor
  EditProfileManager() {
    generateRandomNickname();
    generateRandomProfileImage();
  }

  //!
  void generateRandomNickname() {
    final random = Random();
    final adjective = adjectiveWords[random.nextInt(adjectiveWords.length)];
    final none = noneWords[random.nextInt(noneWords.length)];
    nickname.value = '$adjective $none';
  }

  void generateRandomProfileImage() {
    final random = Random();
    profilePicUrl.value =
        randomProfileImages[random.nextInt(randomProfileImages.length)];
  }

  //!
  Future<void> editUserData({
    required String nickname,
    required String profilePicUrl,
  }) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    DocumentReference userRef =
        _firestore.collection('user').doc(FirestoreData.currentUserEmail);

    // nickname과 profilePicUrl 필드만 업데이트합니다.
    await userRef.update({
      'nickname': nickname,
      'profilePicUrl': profilePicUrl,
    });

    notifyListeners();
  }
}
