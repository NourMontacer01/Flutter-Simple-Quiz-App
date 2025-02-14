import 'package:flutter/material.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/questions_summary.dart';
import 'package:quiz/quiz.dart';
import 'package:quiz/start_screen.dart'; // Make sure this is imported

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key, required this.chosenAnswers})
      : super(key: key);

  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summaryData = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summaryData.add(
        {
          'question_index': i,
          'question': questions[i].question,
          'corerct_answer': questions[i].answers[0],
          'chosen_answer': chosenAnswers[i],
        },
      );
    }
    return summaryData;
  }

  @override
  Widget build(BuildContext context) {
    final int totalQuestions = questions.length;
    final int correctAnswers = getSummaryData()
        .where((data) => data['corerct_answer'] == data['chosen_answer'])
        .length;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 95, 126, 229),
              const Color.fromARGB(255, 54, 2, 106),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  'Quiz Completed!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Your Score: $correctAnswers/$totalQuestions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                QuestionsSummary(summaryData: getSummaryData()),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to the StartScreen when the button is pressed
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Quiz()),
                    );
                  }, // Trigger the restart game function
                  label: const Text('Restart Game'),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
