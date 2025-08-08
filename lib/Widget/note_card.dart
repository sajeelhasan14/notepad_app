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
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(note.title, style: GoogleFonts.poppins(fontSize: 20)),
          subtitle: Text(note.description),
          trailing: IconButton(
            icon: Icon(
              note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
              // color: note.isPinned ? Color(0xff2F5AAF) : Colors.grey,
              color: note.isPinned ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              value.togglePin(note);
            },
          ),
        ),
      ),
    );
  }
}
