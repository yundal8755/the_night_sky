import 'package:everyones_tone/app/enums/record_status.dart';
import 'package:everyones_tone/presentation/pages/record/record_view_model.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/audio_play_button.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/before_record_button.dart';
import 'package:everyones_tone/presentation/widgets/buttons/record_buttons/recording_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordViewModel = Provider.of<RecordViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<RecordViewModel>(
        builder: (context, model, child) {
          switch (model.recordingStatusNotifier.value) {
            case RecordStatus.before:
              return BeforeRecordButton(recordViewModel: recordViewModel);
            case RecordStatus.recording:
              return RecordingButton(recordViewModel: recordViewModel);
            case RecordStatus.complete:
              return AudioPlayButton(recordViewModel: recordViewModel);
            default:
              return Container();
          }
        },
      ),
    );
  }
}
