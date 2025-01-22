import 'package:cure_health_app/features/SplashScreen/splash_screen.dart';
import 'package:cure_health_app/features/homeScreen/home_page.dart';
import 'package:cure_health_app/features/homeScreen/home_screen.dart';
import 'package:cure_health_app/features/loginpage/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: SplashScreen(),
      home: LoginPage(),
    );
  }
}
