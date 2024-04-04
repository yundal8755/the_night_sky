// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:everyones_tone/app/constants/enum/record_status.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordViewModel with ChangeNotifier {
  // 클래스 생성자에서 audioPlayer 초기화
  // 초기화하는 이유는 LateInitializationError를 방지하기 위해
  RecordViewModel() {
    // AudioPlayer 객체 초기화
    audioPlayer = AudioPlayer();

    // 오디오 재생 완료 리스너 추가
    // 해당 코드 덕분에 재생, 일시정지 상태가 계속 유지됨
    audioPlayer.onPlayerComplete.listen((event) {
      isPlaying = false;
      isPlayingNotifier.value = false;
      notifyListeners();
    });
  }

  // 녹음 관련 변수
  final record = AudioRecorder();
  final ValueNotifier<RecordStatus> recordingStatusNotifier =
      ValueNotifier<RecordStatus>(RecordStatus.before);
  String? _audioFilePath;

  // Timer 변수
  Timer? _countdownTimer;
  ValueNotifier<int> remainingTimeNotifier = ValueNotifier<int>(30);

  // Audio 재생 변수
  bool isPlaying = false;
  ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
  late AudioPlayer audioPlayer;

  //! 녹음 시작
  Future<void> startRecording() async {
    try {
      if (await record.hasPermission()) {
        // 녹음 파일을 앱 전용 디렉토리에 저장하기
        final directory = await getApplicationDocumentsDirectory();
        final String fileName =
            '녹음_${DateTime.now().millisecondsSinceEpoch}.mp4';
        final path = '${directory.path}/$fileName';

        // 녹음 시작
        await record.start(const RecordConfig(), path: path);
        _audioFilePath = path;
        recordingStatusNotifier.value = RecordStatus.recording;

        notifyListeners();
        print('음성 녹음 시작!');
        print('음성 녹음 상태: ${recordingStatusNotifier.value}');
        print('음성 녹음 파일 경로: $_audioFilePath');

        // 타이머 시작
        _startTimer();
      } else {
        print('음성 녹음 권한을 허락해주세요!');
      }
    } catch (e) {
      print('Error Start Recording: $e');
    }
  }

  //! 녹음중 - 타이머
  void _startTimer() {
    remainingTimeNotifier.value = 30;
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingTimeNotifier.value > 0) {
          remainingTimeNotifier.value--;
        } else {
          // 타이머 종료시 녹음 자동 중지
          stopRecording();
          timer.cancel();
        }
      },
    );
  }

  //! 녹음 중지
  Future<void> stopRecording() async {
    try {
      // 녹음을 중지하고, 녹음 파일 경로 반환받기
      final path = await record.stop();
      _audioFilePath = path;
      _countdownTimer?.cancel();
      recordingStatusNotifier.value = RecordStatus.complete;

      notifyListeners();
      print('음성 녹음 완료!');
      print('음성 녹음 상태: ${recordingStatusNotifier.value}');
      print('음성 녹음 파일 경로: $_audioFilePath');

      // 타이머 시간 리셋
      remainingTimeNotifier.value = 30;
    } catch (e) {
      print('Error Stopping record: $e');
    }
  }

  //! 음성 재생, 일시정지
  Future<void> audioPlay() async {
    if (_audioFilePath == null) {
      print('오디오 파일 경로가 설정되지 않았습니다.');
      return;
    }

    if (isPlaying) {
      // 재생 중이면 오디오 일시정지
      await audioPlayer.pause();
    } else {
      // 오디오 파일 재생
      await audioPlayer.play(UrlSource('file://$_audioFilePath'));
    }

    // 재생 상태를 토글하고, 이 변경을 알립니다.
    isPlaying = !isPlaying;
    isPlayingNotifier.value = isPlaying;
    notifyListeners();
  }

  //! 음성 삭제
  Future<void> resetRecording() async {
    // 오디오가 재생 중인 경우 일시정지를 기다립니다.
    if (isPlaying) {
      await audioPlayer.stop();
      isPlaying = false;
      isPlayingNotifier.value = false;
    }

    _audioFilePath = null;
    recordingStatusNotifier.value = RecordStatus.before;

    notifyListeners();
    print('음성 녹음 삭제 완료!');
    print('음성 녹음 상태: ${recordingStatusNotifier.value}');
    print('음성 녹음 파일 경로: $_audioFilePath');
  }
}
