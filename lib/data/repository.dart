import 'package:todo_app_flutter/data/models/todo.dart';
import 'package:todo_app_flutter/data/network_service.dart';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});

  Future<List<Todo>> fetchTodos() async {
    final todosRow = await networkService.fetchTodos();
    return todosRow.map((e) {
      print('data: ' + e.toString());
      return Todo.fromMap(e as Map<String, dynamic>);
    }).toList();
  }

  Future<bool> changeCompletion(bool isCompleted, int id) async {
    final patchObj = {"isCompleted": isCompleted.toString()};
    print('iscompleted: ' + isCompleted.toString());
    print(patchObj);
    return await networkService.patchTodo(patchObj, id);
  }

  Future<Todo?> addTodo(String message) async{
    final todoObject = {'todo': message, 'isCompleted': 'false'};
    final todoMap = await networkService.addTodo(todoObject);
    if (todoMap.isEmpty) return null;
    return Todo.fromMap(todoMap as Map<String, dynamic>);

  }
}
