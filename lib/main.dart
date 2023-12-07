import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_memoneet/view_models/quiz_viewmodel.dart';
import 'package:quiz_app_memoneet/views/quiz.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create: (context) => QuizViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Quiz(),
      ),
    );
  }
}
