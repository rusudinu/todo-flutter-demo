class Todo {
  int id;
  String title;
  String description;
  bool done;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.done,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'done': done,
    };
  }
}
