import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'question.dart';

class Brain {
  int _a = 0;
  int _b = 0;

  void getQuestions() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('Questions').get();
    for (var element in snap.docs) {
      _bank.add(Question(element.get('question'), element.get('answer')));
    }
  }

  final List<Question> _bank = [];

  void next() {
    _b++;
    if (_a < _bank.length - 1) {
      _a++;
    }
  }

  String questions() {
    return _bank[_a].ques;
  }

  bool answers() {
    return _bank[_a].ans;
  }

  bool isFinished() {
    if (_b <= 13) {
      return true;
    } else {
      if (kDebugMode) {
        print('false');
      }

      return false;
    }
  }

  void reset() {
    _a = 0;
    _b = 0;
  }
}
