import 'package:flutter/material.dart';

class MultiSelectProvider extends ChangeNotifier {
  bool _isSelectionMode = false;
  final List<int> _selectedIndexes = [];

  bool get isSelectionMode => _isSelectionMode;
  List<int> get selectedIndexes => _selectedIndexes;

  void enterSelectionMode(int index) {
    _isSelectionMode = true;
    _selectedIndexes.add(index);
    notifyListeners();
  }

  void toggleSelection(int index) {
    if (_selectedIndexes.contains(index)) {
      _selectedIndexes.remove(index);
      if (_selectedIndexes.isEmpty) {
        _isSelectionMode = false;
      }
    } else {
      _selectedIndexes.add(index);
    }
    notifyListeners();
  }

  void clearSelection() {
    _isSelectionMode = false;
    _selectedIndexes.clear();
    notifyListeners();
  }

  void deleteSelected(Function(int index) deleteNote) {
    // Sort in reverse to avoid index shifting issues
    _selectedIndexes.sort((a, b) => b.compareTo(a));
    for (var index in _selectedIndexes) {
      deleteNote(index);
    }
    clearSelection();
  }
}
