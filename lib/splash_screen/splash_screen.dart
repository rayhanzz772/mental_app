import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pijak_app/login/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay to simulate a splash screen
    Timer(Duration(seconds: 2), () {
      // Navigate to the login screen after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash_screen.png', // Replace with your splash screen image path
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
