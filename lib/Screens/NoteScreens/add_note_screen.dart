import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad_app/Models/notes.dart';
import 'package:notepad_app/Provider/note_provider.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  bool showSaveButton = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.addListener(updateSaveButtonVisibility);
    descriptionController.addListener(updateSaveButtonVisibility);
  }

  void updateSaveButtonVisibility() {
    final hasText =
        titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty;

    if (showSaveButton != hasText) {
      setState(() {
        showSaveButton = hasText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "New Notes",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Cinzel',
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff2F5AAF),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.white,
          ),
          actions: [
            showSaveButton
                ? IconButton(
                    icon: Icon(Icons.check, color: Colors.white),
                    onPressed: () {
                      if (titleController.text.isEmpty) {
                        return;
                      }
                      if (descriptionController.text.isEmpty) {
                        return;
                      }
                      final note = Notes(
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                      );

                      Provider.of<NoteProvider>(
                        context,
                        listen: false,
                      ).onNewNoteCreated(note);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
            SizedBox(width: 20),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: titleController,
                style: GoogleFonts.poppins(
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: descriptionController,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note something down",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
