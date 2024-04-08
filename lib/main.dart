import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:everyones_tone/presentation/pages/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:everyones_tone/presentation/pages/edit_profile_info/edit_profile_info_view_model.dart';
import 'package:everyones_tone/presentation/pages/login/login_provider.dart';
import 'package:everyones_tone/presentation/pages/record/record_view_model.dart';
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
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => RecordViewModel()),
        ChangeNotifierProvider(create: (context) => EditProfileInfoViewModel()),
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
      home: BottomNavBar(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PretendardVariable',
        textTheme: TextTheme(
          headlineLarge: AppTextStyle.headlineLarge(),
          headlineMedium: AppTextStyle.headlineMedium(),
          titleLarge: AppTextStyle.titleLarge(),
          bodyLarge: AppTextStyle.bodyLarge(),
          bodyMedium: AppTextStyle.bodyMedium(),
          bodySmall: AppTextStyle.bodySmall(),
          labelLarge: AppTextStyle.labelLarge(),
        ),
      ),
    );
  }
}
