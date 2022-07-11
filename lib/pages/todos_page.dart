import 'package:flutter/material.dart';
import 'package:providertodo/pages/widgets/show_todos.dart';
import 'widgets/ms_widgets.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                TodoHeader(),
                CreateTodo(),
                SizedBox(
                  height: 20,
                ),
               SearchAndFilterTodo(),
               ShowTodos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
