import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (context.canPop()) {
          Navigator.pop(context); // Kembali ke halaman sebelumnya
        } else {
          Navigator.pop(context); // Kembali ke halaman sebelumnya
        }
      },
      icon: const HeroIcon(HeroIcons.arrowLeft),
    );
  }
}
