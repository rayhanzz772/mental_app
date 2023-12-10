import 'package:flutter/material.dart';
import 'package:pijak_app/components/background.dart';
import 'package:pijak_app/responsive.dart';
import 'components/login_form.dart';
import 'components/login_image.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:pressable/pressable.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
            mobile: MobileLoginScreen(),
            desktop: Row(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: LoginForm(),
                    )
                  ],
                ))
              ],
            )),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
