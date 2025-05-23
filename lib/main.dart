import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'login_screen.dart';
import 'baby_screen.dart';
import 'mypage_screen.dart';
import 'schedule_screen.dart';
import 'pediatrics.dart';
import 'ai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '도담도담',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(title: '도담도담'),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/signin': (context) => SigninScreen(),
        '/baby': (context) => NewBabyScreen(),
        '/mypage': (context) => MyPageScreen(),
        '/home': (context) => ScheduleScreen(),
        '/babyedit': (context) => BabyEditScreen(babyId: ''),
        '/ai': (context) => Aiscreen(),
        '/pediatrics': (context) => PediatricsScreen(),
      },

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        supportedLocales: [
          Locale('en', ''),
          Locale('ko', ''),
        ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  final String title;
  const SplashScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'lib/assets/images/splash_image.png',
            height: 240,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}