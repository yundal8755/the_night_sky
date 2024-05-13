// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/pages/chat_room/chat_room_view_model.dart';
import 'package:everyones_tone/presentation/pages/report_page.dart';
import 'package:flutter/material.dart';

class ChatRoomDialogBox extends StatelessWidget {
  final Map<String, dynamic> chatData;

  const ChatRoomDialogBox({super.key, required this.chatData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! 신고 버튼
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ReportPage()));
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.neutrals90),
              child: Center(
                  child: Text(
                '신고',
                style: AppTextStyle.bodyMedium(AppColor.secondaryRed),
              ))),
        ),

        //! 채팅방 나가기 버튼
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();

            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                contentPadding: const EdgeInsets.all(12),
                backgroundColor: AppColor.neutrals90,
                content: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 4.5,
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! 안내 문구
                      Column(
                        children: [
                          Icon(
                            Icons.warning_rounded,
                            color: AppColor.neutrals60,
                            size: 48,
                          ),
                          Gap.size4,
                          Text('채팅방을 나가시겠습니까?',
                              style: AppTextStyle.titleLarge()),
                          Gap.size4,
                          Text(
                            '주고 받은 대화들은 모두 삭제됩니다.',
                            style: AppTextStyle.bodyMedium(AppColor.neutrals60),
                          ),
                        ],
                      ),

                      //! 버튼
                      Row(
                        children: [
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColor.neutrals60),
                                  child: Center(
                                      child: Text(
                                    '취소',
                                    style: AppTextStyle.bodyMedium(),
                                  ))),
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () async {
                                ChatRoomViewModel chatRoomViewModel =
                                    ChatRoomViewModel();
                                await chatRoomViewModel
                                    .deleteChatRoom(chatData);

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => BottomNavBarPage()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColor.primaryBlue),
                                child: Center(
                                  child: Text(
                                    '확인',
                                    style: AppTextStyle.bodyMedium(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.neutrals90),
              child: Center(
                  child: Text(
                '채팅방 나가기',
                style: AppTextStyle.bodyLarge(),
              ))),
        ),
      ],
    );
  }
}
