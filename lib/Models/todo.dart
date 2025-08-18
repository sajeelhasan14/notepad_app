class Todo {
  final String task;
  final DateTime date;
  bool isDone = false;

  Todo({required this.task, this.isDone = false, DateTime? date})
    : date = date ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {"task": task, "isDone": isDone, 'date': date.toIso8601String()};
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      task: map["task"],
      date: map["date"] != null
          ? DateTime.tryParse(map['date']) ?? DateTime.now()
          : DateTime.now(),
      isDone: map["isDone"] ?? false,
    );
  }
}
