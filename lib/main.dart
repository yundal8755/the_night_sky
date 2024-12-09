import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/app/utils/audio_play_provider.dart';
import 'package:everyones_tone/app/utils/firestore_user_provider.dart';
import 'package:everyones_tone/app/utils/edit_profile_manager.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/pages/login/login_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint('===== FCM TOKEN : $fcmToken =====');

  FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
    if (message != null && message.notification != null) {
      debugPrint(
          'Foreground 알림 수신: ${message.notification!.title} - ${message.notification!.body}');
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    if (message != null && message.notification != null) {
      debugPrint(
          'Background 알림 수신: ${message.notification!.title} - ${message.notification!.body}');
    }
  });

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null && message.notification != null) {
      debugPrint(
          'Terminate 알림 수신: ${message.notification!.title} - ${message.notification!.body}');
    }
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordStatusManager()),
        ChangeNotifierProvider(create: (_) => EditProfileManager()),
        ChangeNotifierProvider(create: (_) => AudioPlayProvider()),
        ChangeNotifierProvider(create: (_) => FirestoreUserProvider()),
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
    return MaterialApp(
      title: '밤하늘',
      home: BottomNavBarPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
