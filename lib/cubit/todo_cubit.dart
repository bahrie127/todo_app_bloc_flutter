import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_flutter/data/models/todo.dart';
import 'package:todo_app_flutter/data/repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final Repository repository;
  TodoCubit({required this.repository}) : super(TodoInitial());

  void fetchTodos() {
    repository.fetchTodos().then((value) => emit(TodoLoaded(todos: value)));
  }

  void changeCompletion(Todo todo) {
    print('changeCompletion '+todo.isCompleted.toString());
    repository.changeCompletion(!todo.isCompleted, todo.id).then((value) {
      if (value) {
        todo.isCompleted = !todo.isCompleted;
        updateTodoList();
      }
    });
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodoLoaded) emit(TodoLoaded(todos: currentState.todos));
  }

  void addTodo(Todo value) {
    final currentState = state;
    if(currentState is TodoLoaded) {
      final todoList = currentState.todos;
      todoList.add(value);
      emit(TodoLoaded(todos: todoList));
    }
  }
}
