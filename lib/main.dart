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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';
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

  // FCM 토큰 설정
  // String? fcmToken = await FirebaseMessaging.instance.getToken();
  // debugPrint('===== FCM TOKEN : $fcmToken =====');

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 패키지 초기화
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initialization();
    _permissionWithNotification();
    _testAlert();
  }

  /// Local Notifications 초기화 설정 (iOS)
  void _initialization() async {
    DarwinInitializationSettings ios = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    InitializationSettings settings = InitializationSettings(iOS: ios);
    await _local.initialize(settings);
  }

  /// Local Noti 알림 권한 설정
  void _permissionWithNotification() async {
    if (await Permission.notification.isDenied &&
        !await Permission.notification.isPermanentlyDenied) {
      await [Permission.notification].request();
    }
  }

  /// 테스트 전송 환경 설정
  NotificationDetails details = const NotificationDetails(
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  /// 테스트 알림 날려보기 (성공하면 사용 가능)
  void _testAlert() async {
    await _local.show(1, "title", "body", details);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '밤하늘',
      home: BottomNavBarPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
