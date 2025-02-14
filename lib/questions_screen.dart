import 'package:flutter/material.dart';
import 'package:quiz/answer_button.dart';
import 'package:quiz/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  final void Function() restartGame;

  const QuestionsScreen({
    required this.restartGame,
    required this.onSelectAnswer,
    super.key,
    });

  final void Function(String answer) onSelectAnswer;


  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;
  
  /// Function to handle answering the question.
  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);

    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current question from the list based on the index
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 95, 126, 229),
              Color.fromARGB(255, 54, 2, 106),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            // Center the column in the middle of the screen
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                  height: 60), // Space between header and question text
              // Display the actual question
              Text(
                currentQuestion.question,
                style: GoogleFonts.rocknRollOne(
                  color: const Color.fromARGB(255, 255, 226, 251),
                  fontSize: 20, // Increased font size for question readability
                ),
                textAlign: TextAlign.center, // Center the text
              ),
              const SizedBox(
                  height: 80), // Space between the question and answers

              // Render the list of answers using the spread operator
              ...currentQuestion.getShuffledAnswers().map((answer) {
                return AnswerButton(
                  answer,
                  () {
                     answerQuestion(answer);
                  },
              );
              }),

              const SizedBox(height: 80), // Add space at the bottom

              // Button to restart the game
              ElevatedButton.icon(
                onPressed: widget.restartGame, // Trigger the restart game function
                label: const Text('End Game'),
                icon: const Icon(Icons.stop),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
