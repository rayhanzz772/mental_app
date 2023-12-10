import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/self_test/widget/back_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:intl/intl.dart';
// import '/self_test/db/database.dart';
// import '/self_test/provider/history_provider.dart';

class Meditationhomepage extends StatefulWidget {
  const Meditationhomepage({Key? key}) : super(key: key);

  @override
  State<Meditationhomepage> createState() => _MeditationhomepageState();
}

class _MeditationhomepageState extends State<Meditationhomepage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 239, 239),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              // Tindakan ketika tombol silang ditekan
              // Misalnya, untuk kembali ke halaman sebelumnya:
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 12.0,
                  ),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 6,
                        offset: Offset(0, 6),
                      ),
                    ],
                    color: white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          CupertinoIcons.search,
                          color: black,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          style: font,
                          autofocus: false,
                          cursorWidth: 2,
                          cursorColor: black,
                          initialValue: null,
                          decoration: InputDecoration.collapsed(
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: "Search",
                              hintStyle: font),
                          onChanged: (value) {},
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          CupertinoIcons.line_horizontal_3_decrease,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: jumlah.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 6,
                                offset: Offset(0, 6),
                              ),
                            ],
                            color: selectedIndex == index ? black : white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                12.0,
                              ),
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "${jumlah[index]}",
                            style: GoogleFonts.poppins(
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == index ? white : black,
                            ),
                          )),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                ListView.builder(
                  itemCount: lorem.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return FittedBox(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 6,
                              offset: Offset(0, 6),
                            ),
                          ],
                          color: index.isEven ? kPrimaryColor : white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              16.0,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FittedBox(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    height: 30.0,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 6,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                      color: black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10.0,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("${time[index]}",
                                          style: GoogleFonts.poppins(
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w600,
                                            color: white,
                                          )),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                FittedBox(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    height: 30.0,
                                    width: 160,
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 6,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                      color: white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10.0,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("${name[index]}",
                                          style: GoogleFonts.poppins(
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.w600,
                                            color: black,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                              width: 300,
                              child: Text("${lorem[index]}",
                                  style: GoogleFonts.poppins(
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                    color: index.isEven ? white : black,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
