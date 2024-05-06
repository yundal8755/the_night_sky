// ignore_for_file: prefer_const_constructors

import 'package:everyones_tone/app/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatelessWidget {
  ChatModel chatModel;

  ChatRoomPage({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


// class ChatRoomPage extends StatelessWidget {
//   final ChatModel chatModel;

//   const ChatRoomPage({super.key, required this.chatModel});

//   @override
//   Widget build(BuildContext context) {
//     return BackgroundGradient(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               backgroundColor: Colors.transparent,
//               leading: BackButton(color: AppColor.neutrals20),
//               actions: [
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.more_vert,
//                       color: AppColor.neutrals20,
//                     ))
//               ],
//               expandedHeight: 200.0,
//               pinned: true,
//               flexibleSpace: FlexibleSpaceBar(
//                 centerTitle: true,
//                 title: Text('철저한 부엉이'),
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   String nickname =
//                       chatModel.postUserEmail == FirestoreData.currentUserEmail
//                           ? chatModel.replyUserNickname
//                           : chatModel.postUserNickname;
//                   String backgroundImage =
//                       chatModel.postUserEmail == FirestoreData.currentUserEmail
//                           ? chatModel.replyUserProfilePicUrl
//                           : chatModel.postUserProfilePicUrl;

//                   return ChatMessageTile(
//                     backgroundImage: backgroundImage,
//                     nickname: nickname,
//                   );
//                 },
//                 childCount: 10, // 생성할 항목의 수를 조정하세요.
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// @override
// Widget build(BuildContext context) {
//   if (FirestoreData.currentUser == null) {
//     bottomSheet(
//         context: context,
//         child: LoginPage(),
//         bottomSheetType: BottomSheetType.postPage);
//   }

//   // MediaQuery를 사용하여 화면의 너비와 높이를 얻습니다.
//   final double screenWidth = MediaQuery.of(context).size.width;
//   final double screenHeight = MediaQuery.of(context).size.height;

//   // Paint 객체 생성
//   final primaryPaint = Paint()
//     ..shader = AppColor.primaryGradient
//         .createShader(Rect.fromLTWH(0, 0, screenWidth, screenHeight / 256));

//   final textStyle = TextStyle(
//     fontSize: 24,
//     fontWeight: FontWeight.bold,
//     // foreground 속성을 사용하여 Paint 객체를 설정
//     foreground: primaryPaint,
//   );

//   return PopScope(
//     child: Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: MainAppBar(title: '채팅방'),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (FirestoreData.currentUser == null) const Text('로그인 해주세요!'),
//               if (FirestoreData.currentUser != null)
//                 Column(children: [
//                   Text(
//                     '당신의 음색을 녹음해주세요!',
//                     style: textStyle,
//                   ),
//                 ])
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
