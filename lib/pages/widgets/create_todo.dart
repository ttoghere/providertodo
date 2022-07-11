import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';


class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController newTodoControl = TextEditingController();
  @override
  void dispose() {
    newTodoControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newTodoControl,
      decoration: InputDecoration(labelText: "What to do ?"),
      onSubmitted: (String? todoDesc) {
        if (todoDesc != null && todoDesc.trim().isNotEmpty) {
          context.read<TodoList>().addTodo(todoDesc);
          newTodoControl.clear();
        }
      },
    );
  }
}
