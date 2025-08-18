import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad_app/Models/todo.dart';
import 'package:notepad_app/Provider/todo_provider.dart';
import 'package:notepad_app/Widget/task_card.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).loadTaskSP();
  }

  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "To-do",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Cinzel',
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff2F5AAF),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff2F5AAF),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,

              context: context,

              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),

                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        left: 8,
                        right: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.cancel_sharp),
                              ),
                              Text(
                                "New To-do",
                                style: TextStyle(fontFamily: 'Cinzel'),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextFormField(
                              controller: taskController,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Add a To-do item",
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  final task = Todo(
                                    task: taskController.text.trim(),
                                  );
                                  Provider.of<TodoProvider>(
                                    context,
                                    listen: false,
                                  ).addTask(task);
                                  taskController.clear();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2F5AAF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add, color: Colors.white),
        ),

        body: Provider.of<TodoProvider>(context).tasks.isEmpty
            ? Center(
                child: Text(
                  "None",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,

                    fontFamily: 'Cinzel',
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      onChanged: (value) {
                        Provider.of<TodoProvider>(
                          context,
                          listen: false,
                        ).updateSearchQuery(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Search",

                        prefixIcon: Icon(Icons.search),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Consumer<TodoProvider>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          itemCount: value.searchTasks.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                bottom: 20,
                              ),
                              child: TaskCard(index: index),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
