// import 'package:flutter_application_1/home_screen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:pijak_app/chat/chat.dart';
import 'package:pijak_app/home_screen/homeScreen.dart';
import 'package:pijak_app/login/login_screen.dart';
import 'package:pijak_app/meditation/pages/meditationhomepage.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screen/entry_screen.dart';
import '../screen/history_screen.dart';
// import '../screen/self_test_screen.dart';
import 'package:pijak_app/splash_screen/splash_screen.dart';
import '../screen/questionnaire_screen.dart';
import '../screen/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(),
        routes: [
          GoRoute(
            path: 'loginscreen',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: 'homescreen',
            builder: (context, state) => const HomeScreen(
              username: AutofillHints.username,
            ),
          ),
          GoRoute(
            path: 'questionnaire',
            builder: (context, state) => const QuestionnaireScreen(),
          ),
          GoRoute(
            path: 'meditationhomepage',
            builder: (context, state) => const Meditationhomepage(),
          ),
          GoRoute(
            path: 'chat',
            builder: (context, state) => const Chat(),
          ),
          GoRoute(
            path: 'history',
            builder: (context, state) => const HistoryScreen(),
            routes: [
              GoRoute(
                path: ':entryId',
                builder: (context, state) => EntryScreen(
                  entryId: int.parse(state.params['entryId']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});
