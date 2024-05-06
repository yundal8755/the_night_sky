// ignore_for_file: file_names

import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/constants/app_assets.dart';
import 'package:everyones_tone/app/models/chat_model.dart';
import 'package:everyones_tone/presentation/pages/chat/chat_room_page.dart';
import 'package:everyones_tone/presentation/widgets/atoms/profile_circle_image.dart';
import 'package:flutter/material.dart';

class ChatThumbnailTile extends StatelessWidget {
  final ChatModel chatModel;
  final String backgroundImage;
  final String nickname;
  final String chatId;

  const ChatThumbnailTile(
      {super.key,
      required this.backgroundImage,
      required this.nickname,
      required this.chatId,
      required this.chatModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoomPage(chatModel: chatModel,),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const ProfileCircleImage(
                  backgroundImage: AppAssets.profileRandomImage1,
                  radius: 32,
                  opacity: 0,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nickname,
                      style: AppTextStyle.bodyMedium(),
                    ),
                    Text(chatId, style: const TextStyle(color: AppColor.neutrals20))
                  ],
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColor.neutrals20,
            )
          ],
        ),
      ),
    );
  }
}
