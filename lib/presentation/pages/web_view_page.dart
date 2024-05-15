import 'package:everyones_tone/app/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _webViewController;
  final String notionPage = 'https://equable-jitterbug-e9a.notion.site/7b94d449c8af4511a4bba304f3a9a44e';

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(notionPage));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.neutrals90,
        leading: const BackButton(color: AppColor.neutrals20),
        title: const Text(
          '웹뷰',
          style: TextStyle(color: AppColor.neutrals20),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: WebViewWidget(controller: _webViewController),
      ),
    );
  }
}
