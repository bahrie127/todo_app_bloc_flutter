import 'package:todo_app_flutter/data/models/todo.dart';
import 'package:todo_app_flutter/data/network_service.dart';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});

  Future<List<Todo>> fetchTodos() async {
    final todosRow = await networkService.fetchTodos();
    return todosRow.map((e) {
      print('data: '+ e.toString());
      return Todo.fromMap(e as Map<String, dynamic>);
    }).toList();
  }
}
