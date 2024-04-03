import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/app/utils/firestore_data.dart';
import 'package:everyones_tone/presentation/widgets/atoms/text_field.dart';
import 'package:everyones_tone/presentation/widgets/molecules/sub_app_bar.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  final _currentUser = FirestoreData().currentUser;
  PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SubAppBar(),

          //! Body
          if (_currentUser == null)
            const Center(
              child: Text('로그인 해주세요!'),
            ),

          if (_currentUser != null)
            Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '게시글 제목',
                        style: AppTextStyle.labelMedium(),
                      ),
                    ],
                  ),
                ),
                const CustomTextField(),
              ],
            ),
        ],
      ),
    );
  }
}
