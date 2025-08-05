import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:notepad_app/Models/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteProvider extends ChangeNotifier {
  List<Notes> _notes = List.empty(growable: true);
  String _searchQuery = "";

  List<Notes> get filteredNotes {
    if (_searchQuery.isEmpty) return _notes;
    return _notes
        .where(
          (note) =>
              note.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  void updateSearchQuery(String input) {
    _searchQuery = input;
    notifyListeners();
  }

  List<Notes> get notes => _notes;

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
