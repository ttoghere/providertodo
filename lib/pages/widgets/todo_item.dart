// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:providertodo/providers/providers.dart';
import '../../models/todo_model.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);
  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              textEditingController.text = widget.todo.desc;
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog(
                  title: Text("Edit Todo"),
                  content: TextField(
                    controller: textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                        errorText: _error ? "Value can't be empty" : null),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _error = textEditingController.text.isEmpty
                                ? true
                                : false;
                            if (!_error) {
                              context.read<TodoList>().editTodo(
                                    widget.todo.id,
                                    textEditingController.text,
                                  );
                              Navigator.of(context).pop();
                            }
                          });
                        },
                        child: Text("Edit"))
                  ],
                );
              });
            });
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoList>().toggleTodo(widget.todo.id);
        },
      ),
      title: Text(
        widget.todo.desc,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
