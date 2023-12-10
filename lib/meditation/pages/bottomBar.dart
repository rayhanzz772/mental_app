import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_application_1/constants.dart' as constants;
import 'package:pijak_app/meditation/pages/calendar_page.dart';
import 'package:pijak_app/meditation/pages/meditation_page.dart';
import 'package:pijak_app/meditation/pages/meditationhomepage.dart';
import 'package:pijak_app/meditation/utils.dart';

class bottomBar extends StatefulWidget {
  final String username;

  bottomBar({required this.username});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<bottomBar> {
  int _currentIndex = 0;
  bool isSearching = false;
  late PageController _pageController;

  Future<bool> _onWillPop() async {
    if (isSearching) {
      setState(() {
        isSearching = false;
      });
      return false;
    } else {
      // Tampilkan pop-up konfirmasi keluar
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text('Exit App'),
              content: Text('Are you sure want to exit?'),
              actions: <Widget>[
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            // Halaman 0 (Home)
            Meditationhomepage(),
            MeditationPage(),
            CalendarPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 200),
                curve: Curves.linearToEaseOut,
              );
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Tips Meditasi',
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.music_note),
              label: 'Musik Meditasi',
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.calendar),
              label: 'Kalender',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
