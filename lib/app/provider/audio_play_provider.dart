// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class AudioPlayProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentPlayingUrl;
  bool _isPlaying = false;

  AudioPlayProvider() {
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _isPlaying = false;
        _currentPlayingUrl = null;
        notifyListeners();
      } else if (state.playing) {
        _isPlaying = true;
        notifyListeners();
      } else {
        _isPlaying = false;
        notifyListeners();
      }
    });

    _audioPlayer.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace stackTrace) {
      debugPrint('A stream error occurred: $e');
      _isPlaying = false;
      _currentPlayingUrl = null;
      notifyListeners();
    });
  }

  String? get currentPlayingUrl => _currentPlayingUrl;
  bool get isPlaying => _isPlaying;

  Future<void> togglePlay(String audioUrl) async {
    try {
      if (_currentPlayingUrl == audioUrl && _isPlaying) {
        await _audioPlayer.pause();
        // _isPlaying 상태는 listener에서 처리됨
      } else {
        // 이미 다른 것이 재생 중이거나 정지 상태인 경우
        if (_currentPlayingUrl != audioUrl) {
          // 로컬 캐싱 우회책 유지 (iOS AVPlayer 이슈 대응)
          String targetUrl = audioUrl;
          if (audioUrl.startsWith('http')) {
             targetUrl = await _getLocalAudioPath(audioUrl);
          }
          
          if (targetUrl.startsWith('http')) {
            await _audioPlayer.setUrl(targetUrl);
          } else {
            await _audioPlayer.setFilePath(targetUrl);
          }
          _currentPlayingUrl = audioUrl;
        }
        await _audioPlayer.play();
      }
    } catch (e) {
      debugPrint("Error loading audio: $e");
      _isPlaying = false;
      _currentPlayingUrl = null;
      notifyListeners();
    }
  }

  Future<void> stopPlaying() async {
    await _audioPlayer.stop();
    _isPlaying = false;
    _currentPlayingUrl = null;
    notifyListeners();
  }

  Future<String> _getLocalAudioPath(String audioUrl) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = '${base64UrlEncode(utf8.encode(audioUrl))}.m4a';
      final file = File('${tempDir.path}/$fileName');

      if (await file.exists()) {
        return file.path;
      }

      final httpClient = HttpClient();
      final request = await httpClient.getUrl(Uri.parse(audioUrl));
      final response = await request.close();
      if (response.statusCode == 200) {
        final bytes = await consolidateHttpClientResponseBytes(response);
        await file.writeAsBytes(bytes);
        return file.path;
      }
    } catch (e) {
      debugPrint('Audio download error: $e');
    }
    return audioUrl;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
