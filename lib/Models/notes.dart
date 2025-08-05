class Notes {
  final String title;
  final String description;

  Notes({required this.title, required this.description});

  Map<String, String> toMap() {
    return {'title': title, 'description': description};
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(title: map['title'], description: map['description']);
  }
}
