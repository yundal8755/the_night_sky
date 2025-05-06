import 'package:everyones_tone/app/di/service_locator.dart';
import 'package:everyones_tone/app/utils/audio_play_provider.dart';
import 'package:everyones_tone/app/utils/firestore_user_provider.dart';
import 'package:everyones_tone/app/utils/edit_profile_manager.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/pages/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator(); // 의존성 등록 호출

  await Future.delayed(const Duration(microseconds: 300));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecordStatusManager()),
        ChangeNotifierProvider(create: (_) => EditProfileManager()),
        ChangeNotifierProvider(create: (_) => AudioPlayProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileManager()),
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
