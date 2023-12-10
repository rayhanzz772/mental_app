import 'package:flutter/material.dart';

class WelcomeBackground extends StatelessWidget {
  final Widget child;
  const WelcomeBackground({
    Key? key,
    required this.child,
    this.topImage = "assets/images/splash_screen.png",
    this.bottomImage = "assets/images/login_bottom.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              // Menempatkan gambar di tengah atas laya
              child: Image.asset(
                topImage,
                width: 390,
              ),
            ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
