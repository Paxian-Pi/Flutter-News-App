import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _splash(),
    );
  }
}

Widget _splash() {
  return AnimatedSplashScreen(
    duration: 200,
    splash: null,
    nextScreen: const Login(),
    splashTransition: SplashTransition.fadeTransition,
    backgroundColor: const Color(0xFFE2E5FF),
  );
}
