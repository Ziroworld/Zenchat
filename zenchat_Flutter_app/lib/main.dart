import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zenchat/Theme/dark_mode.dart';
import 'package:zenchat/Theme/light_mode.dart';
import 'package:zenchat/auth/auth.dart';
import 'package:zenchat/auth/login_or_register.dart';
import 'package:zenchat/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
