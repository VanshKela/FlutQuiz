import 'package:flutquiz/screens/score_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'brain.dart';
import 'package:firebase_core/firebase_core.dart';

Brain brain = Brain();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  brain.getQuestions();
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
          child: StartPage(),
        ),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const QuizPage()));
          },
          child: const Text('Start Quiz'),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> score = [];
  int scorer = 0;

  void check(bool answer) {
    bool correct = brain.answers();
    setState(() {
      if (brain.isFinished() == false) {
        if (kDebugMode) {
          print(score);
        }
        Alert(
          context: context,
          type: AlertType.success,
          title: "Quiz Completed",
          desc: "Click here to see score.",
          buttons: [
            DialogButton(
              child: const Text(
                "Score",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ScorePage(score: scorer)));
                brain.reset();
                score.clear();
              },
              width: 120,
            )
          ],
        ).show();
      }
      if (answer == correct) {
        score.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        scorer++;
      } else {
        score.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      brain.next();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                brain.questions(),
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                child: const Text(
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
                child: const Text(
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
      ),
    );
  }
}
