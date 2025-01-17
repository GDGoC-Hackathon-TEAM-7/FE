import 'package:flutter/material.dart';

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
        // '/home': (context) => HomeScreen(),
        // '/detail': (context) => DetailScreen(),
      },

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
        Navigator.of(context).pushReplacementNamed('/home');
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