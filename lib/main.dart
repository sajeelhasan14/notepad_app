import 'package:flutter/material.dart';
import 'package:notepad_app/Provider/note_provider.dart';
import 'package:notepad_app/Screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const NotePad());
}

class NotePad extends StatelessWidget {
  const NotePad({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        title: 'Note It',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
