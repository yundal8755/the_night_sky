import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_gap.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/presentation/widgets/custom_buttons/dialog_button.dart';
import 'package:flutter/material.dart';

class DialogWidget {
  static void showSingleOptionDialog(BuildContext context, String message) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.75),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.neutrals70,
          title: Text(
            '경고',
            style: AppTextStyle.titleMedium(),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message, style: AppTextStyle.bodyMedium()),
              ],
            ),
          ),
          actions: <Widget>[
            DialogButton(
                backgroundColor: AppColor.neutrals60,
                text: '확인',
                onTap: () => Navigator.of(context).pop())
          ],
        );
      },
    );
  }

  static void showTwoOptionDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required VoidCallback onTap}) {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.75),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.neutrals70,
          title: Text(
            title,
            style: AppTextStyle.titleMedium(),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message, style: AppTextStyle.bodyMedium()),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: DialogButton(
                  backgroundColor: AppColor.primaryBlue,
                  text: '확인',
                  onTap: onTap,
                )),
                Gap.size12,
                Flexible(
                    child: DialogButton(
                        backgroundColor: AppColor.neutrals60,
                        text: '취소',
                        onTap: () => Navigator.of(context).pop())),
              ],
            )
          ],
        );
      },
    );
  }
}
