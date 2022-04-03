import 'package:flutter/material.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({Key? key, required this.score}) : super(key: key);
  final int score;

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Final Score"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your Score: ${widget.score}",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
