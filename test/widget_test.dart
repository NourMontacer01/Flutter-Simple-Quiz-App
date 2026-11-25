import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/models/quiz_question.dart';
import 'package:quiz/quiz.dart';

/// Gives the screens enough room so the tall columns do not overflow.
void useTallPhoneScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(1080, 2400);
  tester.view.devicePixelRatio = 2.0;
  addTearDown(tester.view.reset);
}

/// Answers every question, choosing the correct one when [correct] is true.
Future<void> answerAll(WidgetTester tester, {required bool correct}) async {
  for (final question in questions) {
    final answer = correct ? question.answers.first : question.answers.last;
    await tester.tap(find.text(answer));
    await tester.pumpAndSettle();
  }
}

Future<void> startQuiz(WidgetTester tester) async {
  useTallPhoneScreen(tester);
  await tester.pumpWidget(const Quiz());
  await tester.tap(find.text('Start Game'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() {
    // Keep tests offline: fall back to the default font instead of downloading.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('QuizQuestion.getShuffledAnswers', () {
    const question = QuizQuestion('Q?', ['a', 'b', 'c', 'd']);

    test('returns the same answers', () {
      expect(question.getShuffledAnswers(), unorderedEquals(question.answers));
    });

    test('does not reorder the original list', () {
      question.getShuffledAnswers();
      expect(question.answers, ['a', 'b', 'c', 'd']);
    });
  });

  group('Quiz flow', () {
    testWidgets('starts on the start screen', (tester) async {
      useTallPhoneScreen(tester);
      await tester.pumpWidget(const Quiz());

      expect(find.text('Start Game'), findsOneWidget);
    });

    testWidgets('shows the first question after starting', (tester) async {
      await startQuiz(tester);

      expect(find.text(questions.first.question), findsOneWidget);
    });

    testWidgets('a perfect run scores every question', (tester) async {
      await startQuiz(tester);
      await answerAll(tester, correct: true);

      expect(find.text('Quiz Completed!'), findsOneWidget);
      expect(
        find.text('Your Score: ${questions.length}/${questions.length}'),
        findsOneWidget,
      );
    });

    testWidgets('wrong answers score zero', (tester) async {
      await startQuiz(tester);
      await answerAll(tester, correct: false);

      expect(find.text('Your Score: 0/${questions.length}'), findsOneWidget);
    });

    testWidgets('Restart Game goes back to a fresh start screen',
        (tester) async {
      await startQuiz(tester);
      await answerAll(tester, correct: true);

      await tester.tap(find.text('Restart Game'));
      await tester.pumpAndSettle();
      expect(find.text('Start Game'), findsOneWidget);

      // A second run must start from zero, not keep the previous answers.
      await tester.tap(find.text('Start Game'));
      await tester.pumpAndSettle();
      await answerAll(tester, correct: false);
      expect(find.text('Your Score: 0/${questions.length}'), findsOneWidget);
    });

    testWidgets('End Game returns to the start screen', (tester) async {
      await startQuiz(tester);

      await tester.tap(find.text('End Game'));
      await tester.pumpAndSettle();

      expect(find.text('Start Game'), findsOneWidget);
    });
  });
}
