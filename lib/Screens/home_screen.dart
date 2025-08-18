import 'package:flutter/material.dart';
import 'package:notepad_app/Provider/todo_provider.dart';
import 'package:notepad_app/Screens/NoteScreens/note_home_screen.dart';
import 'package:notepad_app/Screens/TodoScrrens/todo_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [NoteHomeScreen(), TodoScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[Provider.of<TodoProvider>(context).selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff2F5AAF),
        currentIndex: Provider.of<TodoProvider>(context).selectedIndex,
        onTap: Provider.of<TodoProvider>(context).toggleIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'To-Do'),
        ],
      ),
    );
  }
}
