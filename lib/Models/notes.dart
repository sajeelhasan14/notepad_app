class Notes {
  final String title;
  final String description;
  bool isPinned;

  Notes({
    required this.title,
    required this.description,
    this.isPinned = false,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description, 'isPinned': isPinned};
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      title: map['title'],
      description: map['description'],
      isPinned: map['isPinned'] ?? false,
    );
  }
}
