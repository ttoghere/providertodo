import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertodo/pages/widgets/ms_widgets.dart';
import 'package:providertodo/providers/providers.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodos>().state.filteredTodos;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          context.read<TodoList>().removeTodo(todos[index]);
        },
        confirmDismiss: (value) {
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Are you sure?"),
              content: Text("Do you really want to delete?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Yes"),
                ),
              ],
            ),
          );
        },
        background: showBackground(0),
        secondaryBackground: showBackground(1),
        key: ValueKey(todos[index].id),
        child: TodoItem(
          todo: todos[index],
        ),
      ),
      separatorBuilder: (context, index) => Divider(
        color: Colors.red[900],
      ),
      itemCount: todos.length,
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red[900],
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
