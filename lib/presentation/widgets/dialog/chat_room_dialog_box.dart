// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/pages/chat_room/chat_room_view_model.dart';
import 'package:everyones_tone/presentation/pages/report_page.dart';
import 'package:everyones_tone/presentation/widgets/buttons/custom_elevated_button.dart';
import 'package:everyones_tone/presentation/widgets/dialog/custom_dialog.dart';
import 'package:flutter/material.dart';

class ChatRoomDialogBox extends StatelessWidget {
  final Map<String, dynamic> chatData;

  const ChatRoomDialogBox({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          backgroundColor: AppColor.neutrals90,
          text: '채팅방 나가기',
          textColor: AppColor.neutrals20,
          onPressed: () {
            Navigator.of(context).pop();

            showDialog(
              barrierColor: AppColor.neutrals90.withOpacity(0.95),
              context: context,
              builder: (BuildContext context) => CustomDialog(
                title: '채팅방을 나가시겠습니까?',
                message: '주고 받은 대화들은 모두 삭제됩니다.',
                mainButtonTitle: '나가기',
                onConfirm: () async {
                  ChatRoomViewModel chatRoomViewModel = ChatRoomViewModel();
                  await chatRoomViewModel.deleteChatRoom(chatData);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => BottomNavBarPage()));
                },
              ),
            );
          },
        ),
        CustomElevatedButton(
          backgroundColor: AppColor.neutrals90,
          text: '신고',
          textColor: AppColor.secondaryRed,
          onPressed: () {
            Navigator.of(context).pop();

            showDialog(
              barrierColor: AppColor.neutrals90.withOpacity(0.95),
              context: context,
              builder: (BuildContext context) => CustomDialog(
                title: '신고하기',
                message: '해당 이용자를 신고하시겠습니까?',
                mainButtonTitle: '신고하기',
                onConfirm: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReportPage()));
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
