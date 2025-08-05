import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad_app/Models/notes.dart';
import 'package:notepad_app/Provider/note_provider.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  final Notes notes;
  final int index;
  const EditNoteScreen({required this.index, required this.notes, super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  bool showSaveButton = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text = widget.notes.title..trim();
    descriptionController.text = widget.notes.description.trim();
    titleController.addListener(updateSaveButtonVisibility);
    descriptionController.addListener(updateSaveButtonVisibility);
  }

  void updateSaveButtonVisibility() {
    final changed =
        titleController.text.trim() != widget.notes.title.trim() ||
        descriptionController.text.trim() != widget.notes.title.trim();
    if (showSaveButton != changed) {
      setState(() {
        showSaveButton = changed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Notes",
            style: GoogleFonts.cinzel(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff2F5AAF),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
          ),
          actions: [
            showSaveButton
                ? IconButton(
                    icon: Icon(Icons.check, color: Colors.black),
                    onPressed: () {
                      if (titleController.text.isEmpty) {
                        return;
                      }
                      if (descriptionController.text.isEmpty) {
                        return;
                      }
                      final updatedNote = Notes(
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim(),
                      );

                      Provider.of<NoteProvider>(
                        context,
                        listen: false,
                      ).onNoteEdit(widget.index, updatedNote);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
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
