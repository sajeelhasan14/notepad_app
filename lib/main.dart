import 'package:flutter/material.dart';

import 'package:notepad_app/Provider/multi_select_provider.dart';
import 'package:notepad_app/Provider/note_provider.dart';
import 'package:notepad_app/Provider/theme_provider.dart';
import 'package:notepad_app/Provider/todo_provider.dart';
import 'package:notepad_app/Screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => MultiSelectProvider()),
        ChangeNotifierProvider(create: (context) => TodoProvider()),
      ],
      child: const NotePad(),
    ),
  );
}

class NotePad extends StatelessWidget {
  const NotePad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Provider.of<ThemeProvider>(context).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      title: 'Note It',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
