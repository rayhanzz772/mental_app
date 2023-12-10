import 'package:flutter/material.dart';
import 'package:flutter_application_1/splash_screen/splash_screen.dart';
import '../../../constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'self_test/provider/router_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_application_1/signup/signup_screen.dart';
// import 'package:flutter_application_1/splash_screen/splash_screen.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:flutter_application_1/home_screen/homeScreen.dart';
// import 'package:flutter_application_1/login/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    ),
  );

  // Menunda pembuatan MyApp dengan Future.delayed
  Future.delayed(Duration(seconds: 2), () {
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily:
            'Poppins', // Set font family yang ingin digunakan di seluruh aplikasi
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
      routerConfig: router,
      // initialRoute: '/',
      // routes: {
      //   '/': (context) =>
      //       WelcomeScreen(), // Mengganti HomeScreen dengan SplashScreen
      //   '/LoginScreen': (context) => LoginScreen(),
      //   '/SignUpScreen': (context) => SignUpScreen(),
      //   '/homeScreen': (context) => HomeScreen(
      //         username: AutofillHints.username,
      //       ),
      // Gunakan homeScreen sebagai nama rute untuk HomeScreen
    );
  }
}
