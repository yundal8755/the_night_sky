import 'dart:math';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:flutter/material.dart';

class EditProfileInfoViewModel extends ChangeNotifier {

  //! 리스트 모움잡
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
    '기쁜',
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
    '양귀비',
    '오리',
    '토끼',
    '참나무',
    '침착맨'
  ];
  List<String> randomProfileImages = [
    AppAssets.profileRandomImage1,
    AppAssets.profileRandomImage2,
    AppAssets.profileRandomImage3,
    AppAssets.profileRandomImage4,
    AppAssets.profileRandomImage5,
  ];

  ValueNotifier<String> nickname = ValueNotifier<String>('');
  ValueNotifier<String> profilePicUrl = ValueNotifier<String>('');

  EditProfileInfoViewModel() {
    generateRandomNickname();
    generateRandomProfileImage(); // 초기 프로필 이미지 설정
  }

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
}
