import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notepad_app/Models/notes.dart';
import 'package:notepad_app/Provider/multi_select_provider.dart';
import 'package:notepad_app/Provider/note_provider.dart';
import 'package:notepad_app/Screens/NoteScreens/edit_note_screen.dart';
import 'package:provider/provider.dart';

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
    final multiSelectProvider = Provider.of<MultiSelectProvider>(context);
    final isSelected = multiSelectProvider.selectedIndexes.contains(index);
    return GestureDetector(
      onTap: () {
        if (multiSelectProvider.isSelectionMode) {
          multiSelectProvider.toggleSelection(index);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNoteScreen(index: index, notes: note),
            ),
          );
        }
      },
      onLongPress: () {
        if (!multiSelectProvider.isSelectionMode) {
          multiSelectProvider.enterSelectionMode(index);
        }
      },

      child: Card(
        color: isSelected ? Color(0xff2F5AAF) : null,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(note.title, style: GoogleFonts.poppins(fontSize: 22)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.description, style: TextStyle(fontSize: 18)),
              Text(
                DateFormat("yMMMMd").format(note.date).toString(),

                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
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
