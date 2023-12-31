// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome(); // Call the method to navigate to the home screen
  }

  Future<void> navigateToHome() async {
    await Future.delayed(Duration(seconds: 4)); // Simulate a delay
    GoRouter.of(context)
        .go('/loginscreen'); // Navigate to the home screen after 2 seconds
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash_screen.png', // Replace with your splash screen image path
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
