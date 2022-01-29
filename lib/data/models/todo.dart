import 'dart:convert';

class Todo {
  String todoMessage;
  bool isCompleted;
  int id;
  Todo({
    required this.todoMessage,
    required this.isCompleted,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'todoMessage': todoMessage,
      'isCompleted': isCompleted,
      'id': id,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      todoMessage: map['todo'] ?? '',
      isCompleted: (map['isCompleted'] ?? 'false') == 'true',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));
}
