// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:everyones_tone/app/style/app_color.dart';
import 'package:everyones_tone/app/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// 웹 엽서 편집 웹뷰 화면
/// Flutter -> Web: window.initNightSkyCard(payload) 로 데이터 주입
/// Web -> Flutter: NightSkyBridge.postMessage(json) 로 결과 수신
///
class NightSkyCardWebView extends StatefulWidget {
  final String postId;
  final String postTitle;
  final String audioUrl;
  final String nickname;
  final String profilePicUrl;
  final String userEmail;
  final String dateCreated;

  final void Function(String generatedUrl) onComplete;
  final void Function() onCancelled;
  final void Function() onError;

  const NightSkyCardWebView({
    super.key,
    required this.postId,
    required this.postTitle,
    required this.audioUrl,
    required this.nickname,
    required this.profilePicUrl,
    required this.userEmail,
    required this.dateCreated,
    required this.onComplete,
    required this.onCancelled,
    required this.onError,
  });

  @override
  State<NightSkyCardWebView> createState() => _NightSkyCardWebViewState();
}

class _NightSkyCardWebViewState extends State<NightSkyCardWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  // 채널명 - 웹 사이드와 반드시 동일해야 함
  static const String _bridgeChannelName = 'NightSkyBridge';

  // 웹 엽서 제작 페이지 URL (실제 서버 주소로 변경)
  static const String _cardEditorUrl = 'https://www.giggle.kr/';

  @override
  void initState() {
    super.initState();
    _initWebViewController();
  }

  /// 웹뷰 초기화
  void _initWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.neutrals90)
      // Web -> Flutter: JavascriptChannel 등록
      ..addJavaScriptChannel(
        _bridgeChannelName,
        onMessageReceived: _handleBridgeMessage,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: _onPageFinished,
          onWebResourceError: (WebResourceError error) {
            print('[NightSkyBridge] WebResourceError: ${error.description}');
            if (mounted) setState(() => _hasError = true);
          },
          onHttpError: (HttpResponseError error) {
            print('[NightSkyBridge] HTTP error: ${error.response?.statusCode}');
            if (mounted) setState(() => _hasError = true);
          },
        ),
      )
      ..loadRequest(Uri.parse(_cardEditorUrl));
  }

  /// 페이지 로드 완료 -> Flutter 데이터를 JS로 주입
  Future<void> _onPageFinished(String url) async {
    if (mounted) setState(() => _isLoading = false);

    final payload = jsonEncode({
      'postId': widget.postId,
      'postTitle': widget.postTitle,
      'audioUrl': widget.audioUrl,
      'nickname': widget.nickname,
      'profilePicUrl': widget.profilePicUrl,
      'userEmail': widget.userEmail,
      'dateCreated': widget.dateCreated,
    });

    // 백슬래시, 작은따옴표를 이스케이프하여 JS injection을 안전하게 처리
    final escapedPayload =
        payload.replaceAll(r'\', r'\\').replaceAll("'", r"\'");

    try {
      await _controller.runJavaScript(
        "if (typeof window.initNightSkyCard === 'function') {"
        "  window.initNightSkyCard(JSON.parse('$escapedPayload'));"
        "} else {"
        "  console.warn('[NightSkyBridge] initNightSkyCard is not defined.');"
        "}",
      );
    } catch (e) {
      print('[NightSkyBridge] JS injection error: $e');
      _handleError();
    }
  }

  /// Web -> Flutter 브릿지 메시지 핸들러
  void _handleBridgeMessage(JavaScriptMessage message) {
    try {
      final Map<String, dynamic> data =
          jsonDecode(message.message) as Map<String, dynamic>;
      final String type = data['type'] as String? ?? '';
      final Map<String, dynamic> payload =
          (data['payload'] as Map<String, dynamic>?) ?? {};

      switch (type) {
        case 'CARD_COMPLETE':
          final url = payload['generatedWebUrl'] as String?;
          if (url == null || url.isEmpty) {
            _handleError();
            return;
          }
          if (mounted) Navigator.of(context).pop();
          widget.onComplete(url);

        case 'CARD_CANCELLED':
          if (mounted) Navigator.of(context).pop();
          widget.onCancelled();

        case 'CARD_ERROR':
          _handleError();

        default:
          print('[NightSkyBridge] Unknown message type: $type');
      }
    } on FormatException catch (e) {
      print('[NightSkyBridge] JSON parse error: $e');
      _handleError();
    } catch (e) {
      print('[NightSkyBridge] Unexpected bridge error: $e');
      _handleError();
    }
  }

  /// 에러 처리
  void _handleError() {
    if (mounted) Navigator.of(context).pop();
    widget.onError();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutrals90,
      appBar: AppBar(
        backgroundColor: AppColor.neutrals90,
        elevation: 0,
        leading: BackButton(
          color: AppColor.neutrals20,
          onPressed: () {
            Navigator.of(context).pop();
            widget.onCancelled();
          },
        ),
        title: Text('웹 엽서 만들기', style: AppTextStyle.headlineMedium()),
      ),
      body: Stack(
        children: [
          // 웹 리소스 오류 화면
          if (_hasError)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.wifi_off_rounded,
                    color: AppColor.neutrals40,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '페이지를 불러올 수 없어요.',
                    style: AppTextStyle.bodyLarge(AppColor.neutrals40),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasError = false;
                        _isLoading = true;
                      });
                      _controller.reload();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryBlue,
                      foregroundColor: AppColor.neutrals20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('다시 시도', style: AppTextStyle.bodyLarge()),
                  ),
                ],
              ),
            )
          else
            WebViewWidget(controller: _controller),

          // 로딩 오버레이
          if (_isLoading && !_hasError)
            const ColoredBox(
              color: AppColor.neutrals90,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColor.primaryBlue,
                  strokeWidth: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
