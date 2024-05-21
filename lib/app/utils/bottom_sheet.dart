import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum BottomSheetType {
  loginPage,
  replyPage,
  postPage,
  profilePage,
  dialogBoxTwoButton,
  dialogBoxOneButton
}

extension ModalSizeExtension on BottomSheetType {
  // 디바이스 전체 높이에 대한 요소의 높이 비율
  double get heightFactor {
    switch (this) {
      case BottomSheetType.dialogBoxOneButton:
        return 0.125;
      case BottomSheetType.dialogBoxTwoButton:
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
    isScrollControlled: true,
    backgroundColor: AppColor.neutrals80,
    barrierColor: Colors.black.withOpacity(0.75),
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
  ).then((_) {
    Provider.of<RecordStatusManager>(context, listen: false).resetToBefore();
  });
}
