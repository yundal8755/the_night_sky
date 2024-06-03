
<h1 style="text-align: center;">밤하늘 - 목소리로 소통하는 음성 SNS</h1>

<table style="margin: 0 auto;">
  <tr>
    <td style="padding: 0 20px;">
      <img width="240" src="https://velog.velcdn.com/images/yun_dal/post/3e2e5955-b727-40d0-9ec3-77160c752733/image.png" />
    </td>
    <td style="padding: 0 20px;">
      <img width="240" src="https://velog.velcdn.com/images/yun_dal/post/e5659ec8-1c5a-4839-bce9-cbd11f3fb927/image.png" />
    </td>
    <td style="padding: 0 20px;">
      <img width="240" src="https://velog.velcdn.com/images/yun_dal/post/408437b4-036f-4404-b170-980dfcdd42c8/image.png" />
    </td>
  </tr>
</table>
</br>

- **밤하늘**은 목소리로 생각과 감정을 공유하고 소통하고자 하는 모든 분들을 위한 음성 기반 SNS입니다.
- 주요 기능은 다음과 같습니다
    - 음성 게시글 작성: 프로필 사진과 닉네임, 음성을 담은 게시글을 업로드하여 다른 사용자들과 소통 가능
    - 음성 메시지 답장: 마음에 드는 게시글에 음성 메시지 전송 가능
    - 음성 채팅: 답장을 통해 시작된 채팅방에서 음성 메시지로 대화 가능
- **밤하늘**은 단순한 텍스트 소통을 넘어, 목소리로 감동과 진정성을 전하는 새로운 소통의 장을 제공합니다.
<br></br>


# 목차
- [요약](#요약)
- [구현 결과](#구현-결과)
- [폴더 구조](#폴더-구조)
- [프로젝트 특징](#프로젝트-특징)
- [프로젝트 문서 및 회고록](#프로젝트-문서-및-회고록)
<br></br>


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
| 디바이스             | iPhone 12 pro (iOS 17.4.1), SM-G965N(Android 13)           |
| 테스트 환경          | macOS Monterey(14.0)                                  |
| 기능                 | - Firebase Authentication Google, Apple 로그인 <br> - 음성 게시글 업로드 <br> - 음성 게시글 답장을 통해 채팅 기능 <br> - 프로필 사진 및 닉네임 변경 기능 |


# 구현 결과

| 홈 페이지 | 게시글 업로드 (실명 모드) | 게시글 업로드 (익명 모드) |
|:--------------------------:|:--------------------------:|:--------------------------:|
| ![IMG_1999](https://github.com/Yundal0/everyones_tone/assets/101382788/1621b1e8-255d-4419-ba4e-356595caa176) | ![IMG_2001](https://github.com/Yundal0/everyones_tone/assets/101382788/e5c6a9d1-e587-4f60-9661-117bd2c14601) | ![IMG_2002](https://github.com/Yundal0/everyones_tone/assets/101382788/b15ae0a1-da6f-4596-87b9-e304266de972) |

| 채팅방 목록 페이지 (데이터x) | 채팅방 목록 페이지 (데이터o) | 채팅방 |
|:--------------------------:|:--------------------------:|:--------------------------:|
| ![IMG_2005](https://github.com/Yundal0/everyones_tone/assets/101382788/ae766316-4c20-4cae-970d-b39bc5aa3719) | ![IMG_2003](https://github.com/Yundal0/everyones_tone/assets/101382788/36b700c4-2222-48f6-adc5-815b30b7593a) | ![IMG_2004](https://github.com/Yundal0/everyones_tone/assets/101382788/db511457-1eaf-4fb5-a6c4-e94b80f7ec2c) |

| 로그인 페이지 | 내 정보 페이지 | 프로필 변경 페이지 |
|:--------------------------:|:--------------------------:|:--------------------------:|
| ![IMG_2008](https://github.com/Yundal0/everyones_tone/assets/101382788/34ff1097-471b-4947-b034-dbf3bbe7cd48) | ![IMG_2006](https://github.com/Yundal0/everyones_tone/assets/101382788/b4c318e5-3475-4f6a-acca-c689410e3a1a) | ![IMG_2007](https://github.com/Yundal0/everyones_tone/assets/101382788/c24c8bd9-40d0-4d65-820e-f6b48f0a15f3) |


# 폴더 구조

```bash
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
```
<br></br>


# 프로젝트 특징
### MVVM 아키텍처 적용  
- Model: 데이터 정의 및 관리를 담당. 
- View: 사용자 입력을 처리하고, ViewModel에 이벤트를 전달.
- ViewModel: 비즈니스 로직을 처리하고, Repository를 통해 데이터를 가져오거나 저장.
- Repository: Firestore와 상호작용하여 데이터를 가져오거나 저장.

</br>


### 적용 예시
- [Post]
    - PostModel: 글 작성자 정보와 음성URL, 게시글 제목 그리고 생성 날짜 데이터를 저장.
    - PostPage: 입력받은 게시글 제목, 유저 정보, 음성 녹음 정보를 ViewModel로 전달.
    - PostViewModel: PostModel을 제작하고, 로컬 오디오 파일을 Firebase Storage URL로 변환 후 Firestore에 업로드.
    - PostRepository: Firestore와 상호작용하여 ChatModel 데이터를 Firestore에 저장.
- [Reply]
    - ChatModel: 글 작성자 정보와 게시글 제목, 답장자 정보 그리고 채팅 생성일 데이터를 저장.
    - ReplyPage: 답장할 게시글의 Chat Doc ID와 답장자의 유저 정보, 녹음 정보를 입력받은 후에 ViewModel로 전달.
    - ReplyViewModel: ChatModel을 제작하고, 로컬 오디오 파일을 Firebase Storage URL로 변환 후 Firestore에 업로드.
    - ReplyRepository: Firestore와 상호작용하여 ChatModel 데이터를 Firestore에 저장.
- [ChatRoom]
    - ChatMessageModel: 채팅 ID, 메시지 ID, 오디오URL, 사용자 이메일 등의 데이터를 저장.
    - ChatRoomPage: 상대방의 프로필 사진과 닉네임, 음성 메시지를 확인할 수 있고, 녹음한 음성 메시지 정보를 입력받아 ViewModel로 전달하는 페이지.
    - ChatRoomViewModel: 채팅방 메시지를 정렬, 채팅방 나가기, 채팅 데이터 실시간 스트리밍 그리고 Repository로 데이터를 전달.
    - ChatRoomRepository: Firestore와 상호작용하여 ChatMessageModel을 저장하고 불러오는 역할 수행.
<br></br>


# 프로젝트 문서 및 회고록
- <a href="https://equable-jitterbug-e9a.notion.site/438c19dcb0d04bd8bd6586fbf1cecee6">밤하늘 포트폴리오</a>
- <a href="https://equable-jitterbug-e9a.notion.site/94af09276a7549e79912577fb6144708?v=e1ab4856173049daac90f2c6e3435ba3&pvs=74">밤하늘 개발일지</a>
- <a href="https://equable-jitterbug-e9a.notion.site/b11ed3e7f92d4761b47f75a2835fc891?v=803502e0855942839298fa77cbf58499">밤하늘 문제해결일지</a>
<br></br>
