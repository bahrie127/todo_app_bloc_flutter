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
}
