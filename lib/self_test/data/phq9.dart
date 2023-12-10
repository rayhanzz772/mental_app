import '../db/questionnaire.dart';

const _answers = [
  Answer(value: 0, text: 'Tidak Pernah'),
  Answer(value: 1, text: 'Beberapa hari'),
  Answer(value: 2, text: 'Lebih dari separuh waktu'),
  Answer(value: 3, text: 'Hampir setiap hari'),
];

class Questionnaires {
  const Questionnaires._();

  static const phq9 = Questionnaire(
    name: 'PHQ-9',
    text:
        'Dalam 2 minggu terakhir, seberapa sering Anda terganggu oleh masalah-masalah berikut?',
    questions: [
      Question(
        id: 1,
        text: 'Kurang berminat atau bergairah dalam melakukan apapun ?',
        answers: _answers,
      ),
      Question(
        id: 2,
        text: 'Merasa murung, sedih, atau putus asa ?',
        answers: _answers,
      ),
      Question(
        id: 3,
        text: 'Sulit tidur/mudah terbangun, atau terlalu banyak tidur ?',
        answers: _answers,
      ),
      Question(
        id: 4,
        text: 'Merasa lelah atau kurang bertenaga ?',
        answers: _answers,
      ),
      Question(
        id: 5,
        text: 'Kurang nafsu makan atau terlalu banyak makan ?',
        answers: _answers,
      ),
      Question(
        id: 6,
        text:
            'Kurang percaya diri — atau merasa bahwa Anda adalah orang yang gagal atau telah mengecewakan diri sendiri atau keluarga ?',
        answers: _answers,
      ),
      Question(
        id: 7,
        text:
            'Sulit berkonsentrasi pada sesuatu, misalnya membaca koran atau menonton televisi ?',
        answers: _answers,
      ),
      Question(
        id: 8,
        text:
            'Bergerak atau berbicara sangat lambat sehingga orang lain memperhatikannya. Atau sebaliknya; merasa resah atau gelisah sehingga Anda lebih sering bergerak dari biasanya ?',
        answers: _answers,
      ),
      Question(
        id: 9,
        text:
            'Merasa lebih baik mati atau ingin melukai diri sendiri dengan cara apapun ?',
        answers: _answers,
      ),
      Question(
        id: 10,
        text:
            'If you checked off any problems, how difficult have these problems made it for you to do your work, take care of things at home, or get along with other people?',
        answers: [
          Answer(value: 0, text: 'Tidak Pernah'),
          Answer(value: 0, text: 'Beberapa hari'),
          Answer(value: 0, text: 'Lebih dari separuh waktu'),
          Answer(value: 0, text: 'Hampir setiap hari'),
        ],
      ),
    ],
    results: [
      QuestionnaireResult(
        cutpoint: 0,
        text: 'Tidak ada gejala depresi',
      ),
      QuestionnaireResult(
        cutpoint: 5,
        text: 'Gejala depresi ringan',
      ),
      QuestionnaireResult(
        cutpoint: 10,
        text: 'Depresi ringan',
      ),
      QuestionnaireResult(
        cutpoint: 15,
        text: 'Depresi sedang',
      ),
      QuestionnaireResult(
        cutpoint: 20,
        text:
            'Depresi berat, dianjurkan untuk memberikan antidepresan secara tunggal atau kombinasikan dengan psikoterapi intensif',
      ),
    ],
  );
}
