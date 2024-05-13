import 'package:everyones_tone/app/enums/record_status.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/audio_play_button.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/before_record_button.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/recording_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordStatusButton extends StatelessWidget {
  final bool isChatRoomPage;
  final bool isLastMessageMine;
  final VoidCallback? onPressed;

  const RecordStatusButton({
    super.key,
    this.onPressed,
    this.isLastMessageMine = false,
    this.isChatRoomPage = false,
  });

  @override
  Widget build(BuildContext context) {
    final recordStatusManager =
        Provider.of<RecordStatusManager>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<RecordStatusManager>(
        builder: (context, model, child) {
          switch (model.recordingStatusNotifier.value) {
            case RecordStatus.before:
              return BeforeRecordButton(
                  isLastMessageMine: isLastMessageMine,
                  recordStatusManager: recordStatusManager);
            case RecordStatus.recording:
              return RecordingButton(recordStatusManager: recordStatusManager);
            case RecordStatus.complete:
              return AudioPlayButton(
                recordStatusManager: recordStatusManager,
                isChatRoomPage: isChatRoomPage,
                onPressed: onPressed,
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
