class Notes {
  final String title;
  final String description;

  Notes({required this.title, required this.description});

  // Convert Note object → Map<String, String>
  Map<String, String> toMap() {
    return {'title': title, 'description': description};
  }

  // Convert Map<String, String> → Note object
  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(title: map['title'], description: map['description']);
  }
}
