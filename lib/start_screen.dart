import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 95, 126, 229),
          Color.fromARGB(255, 54, 2, 106),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Opacity(
            //   opacity: 0.25,
            //   child: Image.asset('assets/images/quiz-logo.png',width: 300,),
            // ),

            Image.asset(
              'assets/images/quiz-logo.png',
              width: 300,
              color: const Color.fromARGB(103, 0, 0, 0),
            ),

            SizedBox(height: 60),

            Text(
              'Start S-Quiz Game ! ',
              style: GoogleFonts.rocknRollOne(
                color: const Color.fromARGB(255, 255, 226, 251),
                fontSize: 22,
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: startQuiz,
              label: const Text('Start Game'),
              icon: const Icon(Icons.play_arrow),
            )
          ],
        ),
      ),
    );
  }
}
