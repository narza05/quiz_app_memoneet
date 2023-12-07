import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_memoneet/view_models/quiz_viewmodel.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    final vm = Provider.of<QuizViewModel>(context);
    List quizList = vm.quizList;
    int currentIndex = vm.currentIndex;
    int optIndex = vm.optIndex;
    int score = vm.score;
    bool show = vm.show;
    bool isCorrect = vm.isCorrect;
    bool isFinished = vm.isFinished;

    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Image.asset(
                "assets/quiz_bg.jpg",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              )),
          Expanded(
            child: isFinished
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Quiz Finished",
                        style: style().copyWith(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Score: ",
                            style: style().copyWith(fontSize: 18),
                          ),
                          Text(
                            "$score out of ${quizList.length}",
                            style: style().copyWith(fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          vm.startAgain();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: buildColor(),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              "Start Again",
                              style: style()
                                  .copyWith(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              Text(
                                "Score: ",
                                style: style()
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text("$score out of ${quizList.length}")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            quizList[currentIndex]['question'],
                            style: style().copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                          height: 230,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              itemCount: 4,
                              itemBuilder: (context, position) => buildOption(
                                  vm,
                                  position,
                                  optIndex,
                                  quizList,
                                  currentIndex)),
                        ),
                        SizedBox(height: 10),
                        show
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      "Correct Answer: ",
                                      style: style().copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      quizList[currentIndex]['answer'],
                                      style: style(),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(height: 10),
                        buildButton(optIndex, show, vm, isCorrect)
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }

  GestureDetector buildOption(QuizViewModel vm, int position, int optIndex,
      List<dynamic> quizList, int currentIndex) {
    return GestureDetector(
      onTap: () {
        vm.chooseOption(position + 1);
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: optIndex == position + 1
                  ? buildColor()
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(50)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: buildColor(),
                child: Text(
                  "${position + 1}",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                quizList[currentIndex]['opt${position + 1}'],
                style: style(),
              )
            ],
          )),
    );
  }

  GestureDetector buildButton(
      int optIndex, bool show, QuizViewModel vm, bool isCorrect) {
    return GestureDetector(
      onTap: () {
        optIndex > 0
            ? show
                ? vm.next()
                : vm.submit()
            : null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: show
                ? isCorrect
                    ? Colors.green
                    : Colors.red
                : buildColor(),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0.5)
            ]),
        child: Center(
          child: Text(
            show ? "Next" : "Submit",
            style: style().copyWith(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Color buildColor() => const Color(0xffffa600);

  TextStyle style() => GoogleFonts.poppins();
}
