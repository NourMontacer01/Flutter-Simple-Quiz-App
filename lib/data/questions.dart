import 'package:quiz/models/quiz_question.dart';


// The list of questions with the correct answer always in the first position
final questions = [
  QuizQuestion(
    'What is the primary language used for Flutter development?',
    ['Dart', 
    'Java', 
    'Kotlin',
    'Swift'
    ],
  ),
  QuizQuestion(
    'Which method is used to run a Flutter app?',
    ['runApp()', 
    'main()', 
    'start()', 
    'launch()'
    ],
  ),
  QuizQuestion(
    'Which widget is the basic building block for Flutter UIs?',
    ['Container',
     'Text', 
     'Column', 
     'Row']
     ,
  ),
  QuizQuestion(
    'What does the `setState()` method do in Flutter?',
    [
      'Rebuilds the widget tree',
      'Changes the layout',
      'Re-renders the screen',
      'Updates state variables'
    ],
  ),
  QuizQuestion(
    'What is the purpose of the `Future` class in Dart?',
    [
      'Asynchronous programming',
      'Managing state',
      'UI updates',
      'File handling'
    ],
  ),
  QuizQuestion(
    'Which widget is used for handling user input in Flutter?',
    ['TextField',
     'Button',
      'Icon',
       'ListView'],
  ),
];
