import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad_app/Models/notes.dart';
import 'package:notepad_app/Provider/note_provider.dart';
import 'package:notepad_app/Screens/edit_note_screen.dart';

class NoteCard extends StatelessWidget {
  final NoteProvider value;
  final int index;
  final Notes note;

  const NoteCard({
    required this.value,
    required this.note,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditNoteScreen(index: index, notes: note),
          ),
        );
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Delete Note"),
            content: Text("Are you sure you want to delete this note?"),
            actions: [
              TextButton(
                onPressed: () {
                  value.onNoteDelete(index);
                  Navigator.pop(context);
                },
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        );
      },

      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      style: GoogleFonts.oswald(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(note.description),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
