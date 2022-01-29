import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/constants/strings.dart';
import 'package:todo_app_flutter/cubit/todo_cubit.dart';
import 'package:todo_app_flutter/data/models/todo.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  Widget _todoTile(Todo todo, context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(todo.todoMessage),
        ],
      ),
    );
  }

  Widget _todo(Todo todo, context) {
    return Dismissible(
      key: Key('${todo.id}'),
      child: _todoTile(todo, context),
      background: Container(
        color: Colors.indigo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoCubit>(context).fetchTodos();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ADD_TODO_ROUTE);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (!(state is TodoLoaded))
            return Center(
              child: CircularProgressIndicator(),
            );
          final todos = (state as TodoLoaded).todos;

          return SingleChildScrollView(
            child: Column(
              children: [
                ...todos.map((e) => _todo(e, context)).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
