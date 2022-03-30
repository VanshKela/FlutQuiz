import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'brain.dart';

Brain brain = Brain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
          child: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> score = [];

  void check(bool answer) {
    bool correct = brain.answers();
    setState(() {
      if (brain.isFinished() == false) {
        Alert(
                context: context,
                title: "Finished!",
                desc: "You've reached the end of the quiz.")
            .show();
        brain.reset();
        score.clear();
      }
      if (answer == correct)
        score.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      else
        score.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      brain.next();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              brain.questions(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  check(true);
                  brain.isFinished();
                });
              },
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'TRUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                check(false);
                brain.isFinished();
              },
              child: Text(
                'FALSE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: score,
        ),
      ],
    );
  }
}
