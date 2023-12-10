import 'package:flutter/material.dart';
import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "WELCOME",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            Expanded(
              flex: 8,
              child: Image.asset(
                "assets/images/mental.png",
              ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
