# 밤하늘

## 목차
1. [요약](#요약)
2. [구현 결과](#구현-결과)
3. [폴더 구조](#폴더-구조)
4. [프로젝트 구조](#프로젝트-구조)
5. [코드](#코드)
6. [회고](#회고)

## 요약
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
| 기능                 | - Firebase Authentication Google, Apple 로그인 |
|                      | - 음성 게시글 업로드                                 |
|                      | - 음성 게시글 답장을 통해 채팅 기능                      |
|                      | - 프로필 사진 및 닉네임 변경 기능           |

## 구현 결과
| 홈 페이지(데이터 X) | 홈 페이지         | 검색 페이지(입력 전) |
|--------------------|-------------------|----------------------|
| 이미지             | 이미지            | 이미지               |
| 검색 페이지 (검색어 입력) | 검색 결과 페이지 (검색된 결과X) | 검색 결과 페이지(유저) |
| 이미지             | 이미지            | 이미지               |
| 검색 결과 페이지 (리포지토리) | 검색 결과 페이지 (이슈) | 검색 결과 페이지 (PR) |
| 이미지             | 이미지            | 이미지               |

## 폴더 구조
 |-- lib
     |-- app
     |   |-- config
     |   |-- constants
     |   |-- enums
     |   |-- models
     |   |-- repository
     |   |-- utils
 |-- presentation
     |-- pages
     |   |-- chat_room
     |   |-- chat_thumbnail
     |   |-- login
     |   |-- post
     |   |-- profile
     |   |-- register_profile
     |   |-- reply
     |-- widgets
     |   |-- app_bar
     |   |-- audio_player
     |   |-- custom_buttons
     |   |-- layout
     |   |-- record_buttons
     |   |-- tiles
 |

## 코드

## 회고
