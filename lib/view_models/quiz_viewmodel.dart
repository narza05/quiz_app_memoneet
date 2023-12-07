import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:quiz_app_memoneet/data/quiz_list.dart';
class QuizViewModel extends ChangeNotifier {
  List quizList = QuizList().getList();
  int currentIndex = 0;
  int optIndex = 0;
  int score = 0;
  bool show = false;
  bool isCorrect = false;
  bool isFinished = false;

  chooseOption(int position) {
    optIndex = position;
    notifyListeners();
  }

  submit() {
    if (quizList[currentIndex]['opt${optIndex}'] ==
        quizList[currentIndex]['answer']) {
      score++;
      isCorrect = true;
    }
    show = true;
    notifyListeners();
  }

  next() {
    show = false;
    isCorrect = false;
    if (currentIndex < quizList.length - 1) {
      currentIndex++;
    } else {
      isFinished = true;
    }
    optIndex = 0;
    notifyListeners();
  }

  startAgain() {
    currentIndex = 0;
    optIndex = 0;
    score = 0;
    show = false;
    isCorrect = false;
    isFinished = false;
    notifyListeners();
  }
}
