import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app_flutter/constants/strings.dart';
import 'package:todo_app_flutter/cubit/todo_cubit.dart';
import 'package:todo_app_flutter/data/network_service.dart';
import 'package:todo_app_flutter/data/repository.dart';
import 'package:todo_app_flutter/presentation/screens/add_todo_screen.dart';
import 'package:todo_app_flutter/presentation/screens/edit_todo_screen.dart';
import 'package:todo_app_flutter/presentation/screens/todo_screen.dart';

class AppRouter {
  late Repository repository;
  late TodoCubit todoCubit;

  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todoCubit = TodoCubit(repository: repository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: todoCubit,
                  child: TodoScreen(),
                ));
      case EDIT_TODO_ROUTE:
        return MaterialPageRoute(builder: (_) => EditTodoScreen());
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(builder: (_) => AddTodoScreen());
      default:
        return MaterialPageRoute(builder: (_) => TodoScreen());
    }
  }
}
