import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/app/provider/audio_play_provider.dart';
import 'package:everyones_tone/app/provider/firestore_user_provider.dart';
import 'package:everyones_tone/app/provider/edit_profile_manager.dart';
import 'package:everyones_tone/app/router/app_router.dart';
import 'package:everyones_tone/app/util/record_status_manager.dart';
import 'package:everyones_tone/presentation/login/login_view_model.dart';
import 'package:everyones_tone/presentation/report/report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  await Future.delayed(const Duration(microseconds: 300));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // iOS 알림 권한 요청
  // await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // FCM 토큰 설정
  // String? fcmToken = await FirebaseMessaging.instance.getToken();
  // debugPrint('===== FCM TOKEN : $fcmToken =====');

  // FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
  //   if (message != null && message.notification != null) {
  //     debugPrint(
  //         'Foreground 알림 수신: ${message.notification!.title} - ${message.notification!.body}');
  //   }
  // });

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
  //   if (message != null && message.notification != null) {
  //     debugPrint(
  //         'Background 알림 수신: ${message.notification!.title} - ${message.notification!.body}');
  //   }
  // });

  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   if (message != null && message.notification != null) {
  //     debugPrint(
  //         'Terminate 알림 수신: ${message.notification!.title} - ${message.notification!.body}');
  //   }
  // });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordStatusManager()),
        ChangeNotifierProvider(create: (_) => EditProfileManager()),
        ChangeNotifierProvider(create: (_) => AudioPlayProvider()),
        ChangeNotifierProvider(create: (_) => FirestoreUserProvider()),
        ChangeNotifierProvider(create: (_) => ReportViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '밤하늘',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
