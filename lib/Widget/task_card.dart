import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notepad_app/Provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final int index;
  const TaskCard({required this.index, super.key});
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return GestureDetector(
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Checkbox(
            activeColor: Color(0xff2F5AAF), // color of box when checked
            checkColor: Colors.white,
            value: todoProvider.searchTasks[index].isDone,
            onChanged: (_) {
              todoProvider.toggleisDoneValue(index);
            },
          ),
          title: Text(
            todoProvider.searchTasks[index].task,
            style: GoogleFonts.poppins(fontSize: 18),
          ),
          subtitle: Text(
            DateFormat(
              "yMMMMd",
            ).format(todoProvider.searchTasks[index].date).toString(),
          ),
          trailing: IconButton(
            onPressed: () {
              todoProvider.deleteTask(index);
            },
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
