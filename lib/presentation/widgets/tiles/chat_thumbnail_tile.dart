// ignore_for_file: file_names

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/presentation/pages/chat_room/chat_room_page.dart';
import 'package:everyones_tone/presentation/pages/chat_thumbnail/chat_thumbnail_view_model.dart';
import 'package:everyones_tone/presentation/widgets/profile_circle_image.dart';
import 'package:flutter/material.dart';

class ChatThumbnailTile extends StatelessWidget {
  final Map<String, dynamic> chatData;
  final String profilePicUrl;
  final String nickname;

  const ChatThumbnailTile({
    super.key,
    required this.chatData,
    required this.profilePicUrl,
    required this.nickname,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomPage(
              chatData: chatData,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ProfileCircleImage(
                    backgroundImage: profilePicUrl, radius: 32),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nickname, style: AppTextStyle.bodyLarge()),
                    Gap.size02,
                    Text(
                      '제목: ${chatData['postTitle']}',
                      style: AppTextStyle.labelMedium(AppColor.neutrals40),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                FutureBuilder<int>(
                  future: ChatThumbnailViewModel()
                      .fetchMessageCount(chatData['chatId']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('');
                    }
                    if (snapshot.hasError) {
                      return const Text('');
                    }
                    return Text('${snapshot.data}',
                        style: AppTextStyle.labelMedium(AppColor.neutrals40));
                  },
                ),
                Gap.size06,
                const Icon(Icons.arrow_forward_ios, color: AppColor.neutrals40),
              ],
            )
          ],
        ),
      ),
    );
  }
}
