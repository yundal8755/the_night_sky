# 목차
- [요약](#요약)
- [구현 결과](#구현-결과)
- [폴더 구조](#폴더-구조)
- [프로젝트 구조](#프로젝트-구조)
- [코드](#코드)
- [회고](#회고)

# 요약
| Index                | Detail                                                  |
|----------------------|---------------------------------------------------------|
| 구현 기간            | 2024.03.27~ 2024.06.02                                  |
| 기여                 | 기획, 디자인, 개발 (100%)                               |
| 사용된 핵심 패키지   | provider(상태관리), audioplayers, record, firebase_core |
| IDE                  | Visual Studio Code 1.89.1                               |
| Flutter SDK          | 3.22.1 (stable)                                         |
| Dart SDK             | 3.4.1                                                   |
| DevTools             | 2.34.3                                                  |
| 디바이스             | iphone 12 pro (iOS 17.4.1), SM-G965N(Android 13)           |
| 테스트 환경          | macOS Monterey(14.0)                                  |
| 기능                 | - Firebase Authentication Google, Apple 로그인 <br> - 음성 게시글 업로드 <br> - 음성 게시글 답장을 통해 채팅 기능 <br> - 프로필 사진 및 닉네임 변경 기능 |

## 구현 결과
| 홈 페이지 | 게시글 업로드 (실명 모드)         | 게시글 업로드 (익명 모드) |
|--------------------|-------------------|----------------------|
| ![IMG_1999](https://github.com/Yundal0/everyones_tone/assets/101382788/1621b1e8-255d-4419-ba4e-356595caa176)             | ![IMG_2001](https://github.com/Yundal0/everyones_tone/assets/101382788/e5c6a9d1-e587-4f60-9661-117bd2c14601) | ![IMG_2002](https://github.com/Yundal0/everyones_tone/assets/101382788/b15ae0a1-da6f-4596-87b9-e304266de972)
               |
| 채팅방 목록 페이지 (데이터x) | 채팅방 목록 페이지 (데이터o) | 채팅방 |
| ![IMG_2005](https://github.com/Yundal0/everyones_tone/assets/101382788/ae766316-4c20-4cae-970d-b39bc5aa3719)             | ![IMG_2003](https://github.com/Yundal0/everyones_tone/assets/101382788/36b700c4-2222-48f6-adc5-815b30b7593a)            | ![IMG_2004](https://github.com/Yundal0/everyones_tone/assets/101382788/db511457-1eaf-4fb5-a6c4-e94b80f7ec2c)               |
| 로그인 페이지 | 내 정보 페이지 | 프로필 변경 페이지 |
| ![IMG_2008](https://github.com/Yundal0/everyones_tone/assets/101382788/34ff1097-471b-4947-b034-dbf3bbe7cd48)             | ![IMG_2006](https://github.com/Yundal0/everyones_tone/assets/101382788/b4c318e5-3475-4f6a-acca-c689410e3a1a)            | ![IMG_2007](https://github.com/Yundal0/everyones_tone/assets/101382788/c24c8bd9-40d0-4d65-820e-f6b48f0a15f3)               |

## 폴더 구조
 |-- lib
 |   |-- app
 |   |   |-- config
 |   |   |-- constants
 |   |   |-- enums
 |   |   |-- models
 |   |   |-- repository
 |   |   |-- utils
 |   |-- presentation
 |   |   |-- pages
 |   |   |   |-- chat_room
 |   |   |   |-- chat_thumbnail
 |   |   |   |-- login
 |   |   |   |-- post
 |   |   |   |-- profile
 |   |   |   |-- register_profile
 |   |   |   |-- reply
 |   |   |-- widgets
 |   |   |   |-- app_bar
 |   |   |   |-- audio_player
 |   |   |   |-- custom_buttons
 |   |   |   |-- layout
 |   |   |   |-- record_buttons
 |   |   |   |--  tiles
 |

## 코드

## 회고
