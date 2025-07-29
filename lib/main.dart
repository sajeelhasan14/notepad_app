import 'package:flutter/material.dart';
import 'package:notepad_app/View/splash_screen.dart';

void main() {
  runApp(const NotePad());
}

class NotePad extends StatelessWidget {
  const NotePad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
