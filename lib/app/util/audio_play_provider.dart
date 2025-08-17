// ignore_for_file: file_names

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentPlayingUrl;
  bool _isPlaying = false;

  AudioPlayProvider() {
    _audioPlayer.onPlayerComplete.listen((event) {
      _isPlaying = false;
      _currentPlayingUrl = null; // 재생이 완료되면 현재 재생 중인 URL을 초기화합니다.
      notifyListeners(); // 상태 변경을 알립니다.
    });
  }

  String? get currentPlayingUrl => _currentPlayingUrl;
  bool get isPlaying => _isPlaying;

  Future<void> togglePlay(String audioUrl) async {
    if (_currentPlayingUrl == audioUrl && _isPlaying) {
      await _audioPlayer.stop();
      _isPlaying = false;
      _currentPlayingUrl = null; // 재생 중지 시에도 현재 재생 중인 URL을 초기화합니다.
    } else {
      await _audioPlayer.stop(); // 현재 재생 중인 오디오가 있다면 정지
      await _audioPlayer.play(UrlSource(audioUrl));
      _currentPlayingUrl = audioUrl;
      _isPlaying = true;
    }
    notifyListeners();
  }

    Future<void> stopPlaying() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _currentPlayingUrl = null;
    notifyListeners();
  }
}
