import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/providers.dart';
import 'pages/todos_page.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TodoList()),
        ChangeNotifierProvider.value(value: TodoFilter()),
        ChangeNotifierProvider.value(value: TodoSearch()),
        ProxyProvider<TodoList, ActiveTodoCount>(
          update: (
            BuildContext context,
            TodoList todoList,
            ActiveTodoCount? activeTodoCount,
          ) =>
              ActiveTodoCount(todoList: todoList),
        ),
        ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
          update: (
            BuildContext context,
            TodoFilter todoFilter,
            TodoSearch todoSearch,
            TodoList todoList,
            FilteredTodos? filteredTodos,
          ) =>
              FilteredTodos(
            todoFilter: todoFilter,
            todoSearch: todoSearch,
            todoList: todoList,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: TodosPage(),
      ),
    );
  }
}
