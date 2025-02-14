import 'package:flutter/material.dart';
import 'package:quiz/data/questions.dart';
import 'package:quiz/questions_screen.dart';
import 'package:quiz/start_screen.dart';
import 'package:quiz/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _Quiz();
  }
}

class _Quiz extends State<Quiz> {
  var activeScreen = 'startScreen';
  final List<String> selectedAnswers = [];
  var score = 0;

  //initState() is called when the state object is created.
  //It is used to initialize the state of the object.

  void changeScreen() {
    setState(
      () {
        activeScreen = 'questionsScreen';
      },
    );
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'resultscreen';
      });
    }
  }

  void rechangeScreen() {
    setState(
      () {
        activeScreen = 'startScreen';
         selectedAnswers.clear();
      },
    );
  }

  //setState() is used to notify the framework that the internal state of the object has changed.

  @override
  Widget build(BuildContext context) {
    final selectedScreen = activeScreen == 'startScreen'
        ? StartScreen(changeScreen)
        : activeScreen == 'questionsScreen'
            ? QuestionsScreen(
                restartGame: rechangeScreen,
                onSelectAnswer: chooseAnswer,
              )
            : ResultsScreen(
                chosenAnswers: selectedAnswers,
              );

    return MaterialApp(
      home: Scaffold(body: selectedScreen
          // activeScreen is the variable that holds the current screen state
          //means the current screen to be displayed
          ),
    );
  }
}
