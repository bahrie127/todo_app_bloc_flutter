import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Todo'),
        ),
        body: BlocListener<AddTodoCubit, AddTodoState>(
          listener: (context, state) {
            if (state is TodoAdded) {
              Navigator.pop(context);
            } else if (state is AddTodoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Container(
            margin: EdgeInsets.all(20),
            child: _body(context),
          ),
        ));
  }

  Widget _body(BuildContext context) {
    return Column(children: [
      TextField(
        autofocus: true,
        controller: _controller,
        decoration: InputDecoration(hintText: 'Enter todo message...'),
      ),
      SizedBox(
        height: 10,
      ),
      InkWell(
        onTap: () {
          final message = _controller.text;
          BlocProvider.of<AddTodoCubit>(context).addTodo(message);
        },
        child: _addButton(context),
      )
    ]);
  }
}

Widget _addButton(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: BlocBuilder<AddTodoCubit, AddTodoState>(
        builder: (context, state) {
          if (state is AddingTodo) {
            return CircularProgressIndicator();
          }
          return Text(
            'Add Todo',
            style: TextStyle(color: Colors.white),
          );
        },
      ),
    ),
  );
}
