import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:todo_app_flutter/cubit/todo_cubit.dart';
import 'package:todo_app_flutter/data/repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repository repository;
  final TodoCubit todoCubit;

  AddTodoCubit({
    required this.repository,
    required this.todoCubit,
  }) : super(AddTodoInitial());

  void addTodo(String message) {
    if (message.isEmpty) {
      emit(AddTodoError(error: "todo message is empty"));
      return;
    }

    emit(AddingTodo());
    Timer(Duration(seconds: 2), () {
      repository.addTodo(message).then((value) {
        if (value != null) {
          todoCubit.addTodo(value);
          emit(TodoAdded());
        }
      });
    });
  }
}
