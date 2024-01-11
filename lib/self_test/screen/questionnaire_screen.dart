import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pijak_app/constants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pijak_app/self_test/screen/history_screen.dart';
import 'package:pressable/pressable.dart';

import '../db/questionnaire.dart';
import '../provider/questionnaire/questionnaire_provider.dart';
import '../widget/back_button.dart';

class QuestionnaireScreen extends HookConsumerWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(questionnaireProvider.notifier);
    final state = ref.watch(questionnaireProvider);
    final _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: kPrimaryColor,
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
        },
        child: state.isFinished
            ? _ResultView(result: state.result!)
            : _ContentView(state: state, notifier: notifier),
      ),
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({
    Key? key,
    required this.state,
    required this.notifier,
  }) : super(key: key);

  final QuestionnaireState state;
  final QuestionnaireNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 4,
            child: _QuestionsView(
              question: state.currentQuestion,
              currentIndex: state.currentIndex,
              totalQuestions: state.totalQuestions,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(bottom: 32),
              child: _AnswersView(
                question: state.currentQuestion,
                onAnswer: notifier.answer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionsView extends StatelessWidget {
  const _QuestionsView({
    Key? key,
    required this.question,
    required this.currentIndex,
    required this.totalQuestions,
  }) : super(key: key);

  final Question question;
  final int currentIndex;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '${currentIndex + 1} / $totalQuestions',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: PageTransitionSwitcher(
              transitionBuilder: (
                child,
                primaryAnimation,
                secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: Container(
                key: ValueKey(question.id),
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      question.text,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswersView extends HookConsumerWidget {
  const _AnswersView({
    Key? key,
    required this.question,
    required this.onAnswer,
  }) : super(key: key);

  final Question question;
  final ValueChanged<Answer> onAnswer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = useMemoized(
      () {
        return question.answers.map(
          (answer) {
            return Expanded(
              child: _Answer(
                onPressed: () => onAnswer(answer),
                answer: answer,
              ),
            );
          },
        ).toList();
      },
      [question.answers],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }
}

class _Answer extends StatelessWidget {
  const _Answer({
    Key? key,
    required this.answer,
    required this.onPressed,
  }) : super(key: key);

  final Answer answer;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Pressable.scale(
      onPressed: onPressed,
      theme: const PressableScaleTheme(
        scaleFactor: 0.85,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
          child: Text(
            answer.text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({
    Key? key,
    required this.result,
  }) : super(key: key);

  final Result result;

  @override
  Widget build(BuildContext context) {
    Set<int> score = {result.score};
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'Your score is',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: '${result.score}',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                children: const [
                  TextSpan(
                    text: ' / 27',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                result.result.text,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              height: 40,
              onPressed: () {
                addDataToFirestore(score);
                Navigator.pop(context);
              },
              child: Text(
                "Back to home page",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              color: kPrimaryColor,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void addDataToFirestore(Set<int> score) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      CollectionReference ref = firebaseFirestore.collection('score');

      // Mendapatkan tanggal hari ini
      DateTime now = DateTime.now();
      int day = now.day;
      int month = now.month;
      int year = now.year;

      await ref.add({
        'score': score.toList(),
        'keterangan': result.result.text,
        'uid': uid,
        'tanggal': {
          'day': day,
          'month': month,
          'year': year,
        },
        // Tambahkan field lain yang ingin Anda tambahkan di sini
      }).then((value) {
        print('Data added successfully!');
      }).catchError((error) {
        print('Failed to add data: $error');
      });
    } else {
      print('User is not logged in!');
    }
  }
}
