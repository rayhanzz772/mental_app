// import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:audioplayers/audioplayers.dart';

import '../utils.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({Key? key}) : super(key: key);

  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  bool isActive = false;
  int selectedIndex = 0;
  final player = AudioPlayer();

  @override
  void initState() {
    _updateAppbar();
    super.initState();
  }

  void _updateAppbar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: white,
        toolbarHeight: 50,
        title: Row(
          children: [
            const Spacer(),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
      floatingActionButton: SafeArea(
        child: DraggableFab(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: kPrimaryColor,
                onPressed: () {
                  setState(() {
                    if (isActive) {
                      player.pause(); // Jika sedang diputar, jeda audio
                    } else {
                      player.play(UrlSource(
                          'https://dl183.filemate4.shop/?file=M3R4SUNiN3JsOHJ6WWQ2a3NQS1Y5ZGlxVlZIOCtyZ01sOW9xeUI0c0VhUkNxY1prOGVHbEw0SkdPdWtDM2Rua0Y5ZFk4QUhJY01TRGJVcmJrSUVwVjJlVTlkTjQ2eG5DNDkxbEMrOGhFMFRlek5lc2gyWWp4Q1BFYzR5REdLZ0ZLM0IrckIxSzkyQ1cxT0hkcXhEc3VuQ28raHpVUEhCZTVXNWRiYU9XNHBaUzBEU2NPSzYyaThaUzZ6V0p2NTVMaUE9PQ%3D%3D'));
                    }
                    isActive = !isActive; // Toggle status pemutaran audio
                  });
                },
                child: Icon(
                  isActive ? Icons.pause : Icons.play_arrow,
                  size: 24.0,
                  color: white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      Lottie.network(
                        'https://assets7.lottiefiles.com/packages/lf20_kvwtrk4n.json',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        frameRate: FrameRate(100),
                        repeat: true,
                        animate: isActive,
                      ),
                      Lottie.network(
                        'https://assets10.lottiefiles.com/packages/lf20_z9gwyc2b.json',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        frameRate: FrameRate(100),
                        repeat: true,
                        animate: isActive,
                      ),
                      Lottie.network(
                        'https://assets6.lottiefiles.com/packages/lf20_Kqzytj.json',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        frameRate: FrameRate(100),
                        repeat: true,
                        animate: isActive,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text("Relax Meditation",
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        color: black,
                      )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      "Meditation or thought is the practice of thinking the mind of all the interesting, lazy, or worrying things in our daily life. Interpreting thoughts is the activity of chewing or turning in thoughts, thoughts, thoughts, thoughts.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        color: black,
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
