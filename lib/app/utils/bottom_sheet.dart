import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';

enum BottomSheetType { loginPage, replyPage, postPage, profilePage, dialogBox }

extension ModalSizeExtension on BottomSheetType {
  // 디바이스 전체 높이에 대한 요소의 높이 비율
  double get heightFactor {
    switch (this) {
      case BottomSheetType.dialogBox:
        return 0.20;
      case BottomSheetType.loginPage:
        return 0.30;
      case BottomSheetType.replyPage:
        return 0.5;
      case BottomSheetType.postPage:
        return 0.85;
      case BottomSheetType.profilePage:
        return 0.925;
      default:
        return 1.0;
    }
  }
}

Future<void> bottomSheet({
  required BuildContext context,
  required Widget child,
  required BottomSheetType bottomSheetType,
}) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColor.neutrals80,
    barrierColor: Colors.black.withOpacity(0.75),
    isScrollControlled: true,
    isDismissible: true, // 밖의 영역 터치시 자동으로 창이 닫힘
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (BuildContext context) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height:
              MediaQuery.of(context).size.height * bottomSheetType.heightFactor,
          padding: const EdgeInsets.all(2),
          child: child);
    },
  );
}
