import 'package:everyones_tone/app/enums/record_status.dart';
import 'package:everyones_tone/presentation/widgets/record/record_status_manager.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/audio_play_button.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/before_record_button.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/recording_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordStatusButtonPage extends StatelessWidget {
  const RecordStatusButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordStatusManager = Provider.of<RecordStatusManager>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<RecordStatusManager>(
        builder: (context, model, child) {
          switch (model.recordingStatusNotifier.value) {
            case RecordStatus.before:
              return BeforeRecordButton(recordStatusManager: recordStatusManager);
            case RecordStatus.recording:
              return RecordingButton(recordStatusManager: recordStatusManager);
            case RecordStatus.complete:
              return AudioPlayButton(recordStatusManager: recordStatusManager);
            default:
              return Container();
          }
        },
      ),
    );
  }
}
