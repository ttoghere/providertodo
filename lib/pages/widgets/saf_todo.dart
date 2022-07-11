import 'package:flutter/material.dart';
import 'package:providertodo/models/todo_model.dart';
import 'package:providertodo/providers/providers.dart';
import 'package:provider/provider.dart';

class SearchAndFilterTodo extends StatelessWidget {
  const SearchAndFilterTodo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "Search Todos",
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(
              Icons.search,
            ),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              context.read<TodoSearch>().setSearchTerm(newSearchTerm);
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.completed),
          ],
        ),
      ],
    );
  }

  TextButton filterButton(BuildContext context, Filter filter) => TextButton(
        onPressed: () {
          context.read<TodoFilter>().changeFilter(filter);
        },
        child: Text(
          filter == Filter.all
              ? "All"
              : filter == Filter.active
                  ? "Active"
                  : "Completed",
          style: TextStyle(
            fontSize: 18,
            color: textColor(context, filter),
          ),
        ),
      );

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilter>().state.filter;
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}
