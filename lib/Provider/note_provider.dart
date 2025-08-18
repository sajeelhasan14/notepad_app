import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:notepad_app/Models/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteProvider extends ChangeNotifier {
  List<Notes> _notes = List.empty(growable: true);
  List<Notes> get notes => _notes;
  String _searchQuery = "";

  List<Notes> get filteredNotes {
    List<Notes> sortedNotes = List.from(_notes);

    // Sorting: pinned notes at top
    sortedNotes.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return 0;
    });

    if (_searchQuery.isEmpty) return sortedNotes;

    return sortedNotes.where((note) {
      return note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          note.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void togglePin(Notes note) {
    note.isPinned = !note.isPinned;
    saveNotesSP();
    notifyListeners();
  }

  void updateSearchQuery(String input) {
    _searchQuery = input;
    notifyListeners();
  }

  void onNewNoteCreated(Notes note) {
    notes.add(note);
    saveNotesSP();
    notifyListeners();
  }

  void onNoteDelete(int index) {
    notes.removeAt(index);
    saveNotesSP();
    notifyListeners();
  }

  void onNoteEdit(int index, Notes updatedNote) {
    _notes[index] = updatedNote;
    saveNotesSP();
    notifyListeners();
  }

  Future<void> saveNotesSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> noteList = _notes
        .map((note) => jsonEncode(note.toMap()))
        .toList();
    await prefs.setStringList("notes", noteList);
  }

  Future<void> loadNotesSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? noteList = prefs.getStringList("notes");
    if (noteList != null) {
      _notes = noteList.map((item) => Notes.fromMap(jsonDecode(item))).toList();
      notifyListeners();
    }
  }
}
