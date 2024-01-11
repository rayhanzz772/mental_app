import 'package:flutter/material.dart';

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
    Navigator.pushReplacementNamed(context, '/loginscreen');
    // Navigate to the login screen after 4 seconds
    // Replace '/loginscreen' with your desired route name
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
