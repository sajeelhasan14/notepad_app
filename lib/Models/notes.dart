class Notes {
  final String title;
  final String description;
  final DateTime date;
  bool isPinned;

  Notes({
    required this.title,
    required this.description,
    this.isPinned = false,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isPinned': isPinned,
      'date': date.toIso8601String(),
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      isPinned: map['isPinned'] ?? false,
    );
  }
}
