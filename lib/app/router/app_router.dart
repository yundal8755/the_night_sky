import 'package:everyones_tone/presentation/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/chat_room/chat_room_page.dart';
import 'package:everyones_tone/presentation/login/initial_login_page.dart';
import 'package:everyones_tone/presentation/login/sns_login_page.dart';
import 'package:everyones_tone/presentation/post/post_page.dart';
import 'package:everyones_tone/presentation/profile/edit_profile_page.dart';
import 'package:everyones_tone/presentation/profile/profile_page.dart';
import 'package:everyones_tone/presentation/profile/profile_setting_page.dart';
import 'package:everyones_tone/presentation/register_profile/register_profile_page.dart';
import 'package:everyones_tone/presentation/reply/reply_page.dart';
import 'package:everyones_tone/presentation/report/report_page.dart';
import 'package:everyones_tone/presentation/splash_page.dart';
import 'package:everyones_tone/presentation/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///
/// 라우터 이름
///
abstract final class AppRouteName {
  static const splash = 'splash';
  static const home = 'home';
  static const loginConsent = 'login_consent';
  static const loginMethod = 'login_method';
  static const registerProfile = 'register_profile';
  static const createPost = 'create_post';
  static const reply = 'reply';
  static const report = 'report';
  static const chatRoom = 'chat_room';
  static const profile = 'profile';
  static const profileSetting = 'profile_setting';
  static const profileEdit = 'profile_edit';
  static const webView = 'web_view';
}

///
/// 라우터 경로
///
abstract final class AppRoutePath {
  static const splash = '/';
  static const home = '/home';
  static const loginConsent = '/login';
  static const loginMethod = '/login/method';
  static const registerProfile = '/register-profile';
  static const createPost = '/post';
  static const reply = '/reply';
  static const report = '/report';
  static const chatRoom = '/chat-room';
  static const profile = '/profile';
  static const profileSetting = '/profile/setting';
  static const profileEdit = '/profile/edit';
  static const webView = '/webview';
}

///
/// 라우터 쿼리
///
abstract final class AppRouteQueryKey {
  static const email = 'email';
  static const docId = 'docId';
  static const title = 'title';
  static const url = 'url';
  static const postUserEmail = 'postUserEmail';
}

///
/// 라우터 경로 생성
///
abstract final class AppRouteLocation {
  static const splash = AppRoutePath.splash;
  static const home = AppRoutePath.home;
  static const loginConsent = AppRoutePath.loginConsent;
  static const loginMethod = AppRoutePath.loginMethod;
  static const createPost = AppRoutePath.createPost;
  static const profile = AppRoutePath.profile;
  static const profileSetting = AppRoutePath.profileSetting;
  static const profileEdit = AppRoutePath.profileEdit;

  static String registerProfile({required String email}) => Uri(
        path: AppRoutePath.registerProfile,
        queryParameters: {
          AppRouteQueryKey.email: email,
        },
      ).toString();

  static String reply({required String docId}) => Uri(
        path: AppRoutePath.reply,
        queryParameters: {
          AppRouteQueryKey.docId: docId,
        },
      ).toString();

  static String report({
    required String docId,
    required String postUserEmail,
  }) =>
      Uri(
        path: AppRoutePath.report,
        queryParameters: {
          AppRouteQueryKey.docId: docId,
          AppRouteQueryKey.postUserEmail: postUserEmail,
        },
      ).toString();

  static String webView({
    required String title,
    required String url,
  }) =>
      Uri(
        path: AppRoutePath.webView,
        queryParameters: {
          AppRouteQueryKey.title: title,
          AppRouteQueryKey.url: url,
        },
      ).toString();
}

///
/// 라우터
///
final GoRouter appRouter = GoRouter(
  initialLocation: AppRouteLocation.splash,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutePath.splash,
      name: AppRouteName.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutePath.home,
      name: AppRouteName.home,
      builder: (context, state) => BottomNavBarPage(),
    ),
    GoRoute(
      path: AppRoutePath.loginConsent,
      name: AppRouteName.loginConsent,
      builder: (context, state) => const InitialLoginPage(),
    ),
    GoRoute(
      path: AppRoutePath.loginMethod,
      name: AppRouteName.loginMethod,
      builder: (context, state) => SnsLoginPage(),
    ),
    GoRoute(
      path: AppRoutePath.registerProfile,
      name: AppRouteName.registerProfile,
      builder: (context, state) {
        final email = state.uri.queryParameters[AppRouteQueryKey.email];
        if (email == null || email.isEmpty) {
          return const _MissingParamPage(paramName: AppRouteQueryKey.email);
        }
        return RegisterProfilePage(userEmail: email);
      },
    ),
    GoRoute(
      path: AppRoutePath.createPost,
      name: AppRouteName.createPost,
      builder: (context, state) => const PostPage(),
    ),
    GoRoute(
      path: AppRoutePath.reply,
      name: AppRouteName.reply,
      builder: (context, state) {
        final docId = state.uri.queryParameters[AppRouteQueryKey.docId];
        if (docId == null || docId.isEmpty) {
          return const _MissingParamPage(paramName: AppRouteQueryKey.docId);
        }
        return ReplyPage(replyDocmentId: docId);
      },
    ),
    GoRoute(
      path: AppRoutePath.report,
      name: AppRouteName.report,
      builder: (context, state) {
        final docId = state.uri.queryParameters[AppRouteQueryKey.docId];
        final postUserEmail =
            state.uri.queryParameters[AppRouteQueryKey.postUserEmail];
        if (docId == null ||
            docId.isEmpty ||
            postUserEmail == null ||
            postUserEmail.isEmpty) {
          return const _MissingParamPage(paramName: 'docId, postUserEmail');
        }
        return ReportPage(
          currentDocumentId: docId,
          postUserEmail: postUserEmail,
        );
      },
    ),
    GoRoute(
      path: AppRoutePath.chatRoom,
      name: AppRouteName.chatRoom,
      builder: (context, state) {
        final chatData = state.extra;
        if (chatData is! Map<String, dynamic>) {
          return const _MissingParamPage(paramName: 'chatData');
        }
        return ChatRoomPage(chatData: chatData);
      },
    ),
    GoRoute(
      path: AppRoutePath.profile,
      name: AppRouteName.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: AppRoutePath.profileSetting,
      name: AppRouteName.profileSetting,
      builder: (context, state) => const ProfileSettingPage(),
    ),
    GoRoute(
      path: AppRoutePath.profileEdit,
      name: AppRouteName.profileEdit,
      builder: (context, state) => const EditProfilePage(),
    ),
    GoRoute(
      path: AppRoutePath.webView,
      name: AppRouteName.webView,
      builder: (context, state) {
        final title = state.uri.queryParameters[AppRouteQueryKey.title];
        final url = state.uri.queryParameters[AppRouteQueryKey.url];
        if (title == null || url == null || title.isEmpty || url.isEmpty) {
          return const _MissingParamPage(paramName: 'title, url');
        }
        return WebViewPage(page: url, title: title);
      },
    ),
  ],
);

///
/// 라우터 파라미터가 없을 때 보여주는 페이지
///
class _MissingParamPage extends StatelessWidget {
  final String paramName;

  const _MissingParamPage({required this.paramName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('잘못된 접근')),
      body: Center(
        child: Text('필수 파라미터가 없습니다: $paramName'),
      ),
    );
  }
}
