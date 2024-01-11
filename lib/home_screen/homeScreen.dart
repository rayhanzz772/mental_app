import 'package:flutter/material.dart';
import 'package:pijak_app/chat/modules/chat_text/views/chat_text_view.dart';
import 'package:pijak_app/chat/modules/home/views/home_view.dart';
import 'package:pijak_app/constants.dart';
import 'package:pijak_app/meditation/pages/bottomBar.dart';
// import 'package:flutter_application_1/meditation/pages/meditationhomepage.dart';
import '/self_test/screen/questionnaire_screen.dart';
// import '/meditation/utils.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '/self_test/db/database.dart';
import '/self_test/provider/history_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends HookConsumerWidget {
  final String userEmail;

  const HomeScreen(this.userEmail, {super.key});

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          content: Text(
              'Dalam 2 minggu terakhir, seberapa sering Anda terganggu oleh masalah-masalah berikut?'),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Keterangan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return QuestionnaireScreen();
                      },
                    ),
                  );
                },
                child: Text(
                  'Mulai',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Icon(
          Icons.short_text,
          size: 30,
          color: Colors.black,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Row(
            children: [
              Icon(
                Icons.notifications_none,
                size: 30,
                color: Colors.grey, // Change to LightColor.grey if needed
              ),
              Padding(
                padding: const EdgeInsets.all(8.0), // Add padding here
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: Image.asset("assets/images/itsme.png",
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance;
    final String trimmedEmail = userEmail.split('@').first;
    final history = ref.watch(historyProvider);
    final formatter = useMemoized(() => DateFormat('dd MMMM yyyy'));
    double kWidth = MediaQuery.of(context).size.width * 0.9;
    double kWidth2 = MediaQuery.of(context).size.width * 0.95;
    double kButtonWidth = MediaQuery.of(context).size.width * 0.892;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: _appBar(context),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: Color.fromARGB(255, 240, 239, 239),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: kWidth2,
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         color: Colors.green, width: 1),),
                              margin: EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Halo,',
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    155,
                                                                    155,
                                                                    155)),
                                                      ),
                                                      Text(
                                                        ' $trimmedEmail',
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12),
                                                  child: TextFormField(
                                                    cursorColor: kPrimaryColor,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              20.0,
                                                              10.0,
                                                              20.0,
                                                              10.0),
                                                      fillColor: Colors.white,
                                                      hintText: 'Cari apa ?',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      prefixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child:
                                                            Icon(Icons.search),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(
                        //       color: Color.fromARGB(255, 0, 0, 0), width: 1),
                        // ),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth *
                                0.05, // Responsif: 5% lebar layar sebagai padding kiri
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Container(
                                      // hitam
                                      width: kWidth,
                                      decoration: BoxDecoration(
                                        boxShadow: [AppBoxShadows.boxShadow],
                                        // border: Border.all(
                                        //     color: Colors.red, width: 0.5),
                                        color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Row(
                                        // hijau
                                        children: [
                                          Padding(
                                            // hijau 1
                                            padding: const EdgeInsets.only(
                                                top: 15,
                                                bottom: 15,
                                                right: 10,
                                                left: 5),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/images/otak.png",
                                                  width: 130,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            // hijau 2
                                            padding: const EdgeInsets.only(
                                                top: 12, bottom: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Bagaimana Hari mu ?",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Cek Keadaan mu disini",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          _showDialog(context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 0,
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          minimumSize:
                                                              const Size(
                                                                  100, 36),
                                                          maximumSize:
                                                              const Size(
                                                                  200, 56),
                                                        ),
                                                        child: Text(
                                                          'Mulai Test',
                                                          style: TextStyle(
                                                              color: black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //     border: Border.all(
                        //   color: Colors.red,
                        //   width: 1,
                        // )),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 15),
                              child: Container(
                                width: kWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [AppBoxShadows.boxShadow],
                                  color: Colors.white,
                                  // border: Border.all(
                                  //     color: const Color.fromARGB(
                                  //         255, 54, 57, 244),
                                  //     width: 1),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: kPrimaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0), // Ubah warna sesuai kebutuhan Anda
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 12.0,
                                                                      bottom:
                                                                          12),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/meditasi.png',
                                                                width: 180,
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 12),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Tips Meditasi",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          44,
                                                                          44,
                                                                          44,
                                                                          1),
                                                                  fontSize: 17),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Untukmu",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 17),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Bermeditasi bisa",
                                                              style: TextStyle(
                                                                  fontSize: 13),
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "membuatmu rileks",
                                                              style: TextStyle(
                                                                  fontSize: 13),
                                                            )
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 15),
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                        return bottomBar(
                                                                          username:
                                                                              '',
                                                                        );
                                                                      },
                                                                    ),
                                                                  );
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  elevation: 0,
                                                                  backgroundColor:
                                                                      kPrimaryColor,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                  ),
                                                                  minimumSize:
                                                                      const Size(
                                                                          100,
                                                                          36),
                                                                  maximumSize:
                                                                      const Size(
                                                                          200,
                                                                          56),
                                                                ),
                                                                child: Text(
                                                                  'Mulai',
                                                                  style: TextStyle(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Curhat
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: Container(
                            width: kWidth,
                            // decoration: BoxDecoration(
                            //     border:
                            //         Border.all(color: Colors.green, width: 1)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, left: 10),
                                      child: Text(
                                        "Butuh Curhat ? ",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ChatTextView();
                                            },
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                          Size(kButtonWidth, 50),
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Atur border radius di sini
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Apa yang anda sedang pikirkan ?',
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                          Icon(Icons
                                              .keyboard_arrow_right_rounded),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //
                      ///
                      ///
                      ///
                      ///
                      // Riwayat

                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Container(
                          width: kWidth,
                          decoration: BoxDecoration(
                            boxShadow: [AppBoxShadows.boxShadow],
                            // border: Border.all(color: Colors.red, width: 0.5),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10, bottom: 10),
                                        child: Text(
                                          "Riwayat Self Test",
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("score")
                                            .where('uid',
                                                isEqualTo: currentUser
                                                    .currentUser!.uid)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            final List<DocumentSnapshot>
                                                historyList =
                                                snapshot.data!.docs;
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: historyList.length,
                                              itemBuilder: (context, index) {
                                                String keterangan =
                                                    historyList[index]
                                                        ['keterangan'];
                                                List<
                                                    dynamic> scores = historyList[
                                                        index]['score'] ??
                                                    []; // Mengambil nilai score dengan tipe List<dynamic>
                                                Map<String,
                                                    dynamic> tanggal = historyList[
                                                        index]['tanggal'] ??
                                                    {}; // Mengambil nilai tanggal dengan tipe Map<String, dynamic>

                                                return Card(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  elevation: 0,
                                                  color: Colors.white,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(16),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '$keterangan',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 8),
                                                        Text(
                                                          'Score: ${scores.join(", ")} / 27', // Mencetak nilai score dari array
                                                        ),
                                                        SizedBox(height: 8),
                                                        Text(
                                                            'Tanggal: ${tanggal['day']}/${tanggal['month']}/${tanggal['year']}'), // Mencetak nilai tanggal dari map
                                                        SizedBox(height: 8),
                                                        // Add other fields as needed
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.entry,
    required this.title,
  });

  final Entry entry;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Container(
        height: 32,
        width: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color.fromARGB(137, 4, 4, 4)),
        ),
        child: Center(
          child: Text(
            '${entry.score} / 27',
          ),
        ),
      ),
      onTap: () {
        context.go('/history/${entry.id}');
      },
    );
  }
}
