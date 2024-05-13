// ignore_for_file: file_names

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/presentation/pages/chat_room/chat_room_page.dart';
import 'package:everyones_tone/presentation/pages/chat_thumbnail/chat_thumbnail_view_model.dart';
import 'package:everyones_tone/presentation/widgets/atoms/profile_circle_image.dart';
import 'package:flutter/material.dart';

class ChatThumbnailTile extends StatelessWidget {
  final Map<String, dynamic> chatData;
  final String partnerProfilePicUrl;
  final String partnerNickname;

  const ChatThumbnailTile({
    super.key,
    required this.chatData,
    required this.partnerProfilePicUrl,
    required this.partnerNickname,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoomPage(
                chatData: chatData,
              ),
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ProfileCircleImage(
                    backgroundImage: partnerProfilePicUrl, radius: 32),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(partnerNickname, style: AppTextStyle.bodyLarge()),
                    FutureBuilder<int>(
                      future: ChatThumbnailViewModel()
                          .fetchMessageCount(chatData['chatId']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('전체 메시지: 0개',
                              style: TextStyle(color: AppColor.neutrals40));
                        }
                        if (snapshot.hasError) {
                          return const Text('전체 메시지: 0개',
                              style: TextStyle(color: AppColor.neutrals40));
                        }
                        return Text('전체 메시지: ${snapshot.data}개',
                            style: const TextStyle(color: AppColor.neutrals40));
                      },
                    )
                  ],
                )
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: AppColor.neutrals40),
          ],
        ),
      ),
    );
  }
}
