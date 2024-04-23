import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swift_street/Views/home_page.dart';
import 'package:swift_street/Views/login_screen.dart';
import 'package:swift_street/services/auth/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _checkUserStatus();
  }

  // This method handles asynchronous initialization
  void _checkUserStatus() async {
    Widget? screen;
    if (AuthService().currentUser == null) {
      await AuthService().silentSignIn();
    }

    if (AuthService().currentUser == null) {
      screen = LoginScreen();
    } else {
      screen = const HomePage();
    }

    // Ensure mounted to avoid calling setState or navigation if the widget was disposed.
    if (mounted) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => screen!)));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
      body: Center(
          child: Image.asset('assets/images/splash_image.png',
              opacity: _opacityAnimation)),
    );
  }
}