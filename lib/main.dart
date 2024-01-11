import 'package:flutter/material.dart';
import 'package:pijak_app/firebase_options.dart';
import 'package:pijak_app/home_screen/homeScreen.dart';
import 'package:pijak_app/login/login_screen.dart';
import 'package:pijak_app/signup/signup_screen.dart';
import 'package:pijak_app/splash_screen/splash_screen.dart';
import 'package:pijak_app/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'self_test/provider/router_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      // Set initial route or routes here as needed
      routes: {
        // Remove redundant '/' route since home is set to WelcomeScreen()
        '/LoginScreen': (context) => LoginScreen(),
        '/SignUpScreen': (context) => Register(),
      },
      // This function will be used to generate routes using the router provider
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Color.fromARGB(255, 240, 239, 239),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kPrimaryLightColor,
          iconColor: kPrimaryColor,
          prefixIconColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
