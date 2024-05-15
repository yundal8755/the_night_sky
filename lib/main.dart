import 'package:everyones_tone/app/utils/audio_play_provider.dart';
import 'package:everyones_tone/app/utils/firestore_user_provider.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar/bottom_nav_bar_page.dart';
import 'package:everyones_tone/presentation/pages/edit_profile/edit_profile_manager.dart';
import 'package:everyones_tone/app/utils/record_status_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RecordStatusManager()),
        ChangeNotifierProvider(create: (context) => EditProfileManager()),
        ChangeNotifierProvider(create: (context) => AudioPlayProvider()),
        ChangeNotifierProvider(create: (context) => EditProfileManager()),
        ChangeNotifierProvider(create: (context) => FirestoreUserProvider()),
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
      title: 'Everyones Tone',
      home: BottomNavBarPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
