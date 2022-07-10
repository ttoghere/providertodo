import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/providers.dart';
import 'pages/todos_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TodoList()),
        ChangeNotifierProvider.value(value: ActiveTodoCount()),
        ChangeNotifierProvider.value(value: TodoFilter()),
        ChangeNotifierProvider.value(value: TodoSearch()),
        ChangeNotifierProvider.value(value: FilteredTodos()),
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(),
          update: (
            BuildContext context,
            TodoList todoList,
            ActiveTodoCount? activeTodoCount,
          ) =>
              activeTodoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList,
                FilteredTodos>(
            create: (context) => FilteredTodos(),
            update: (
              BuildContext context,
              TodoFilter todoFilter,
              TodoSearch todoSearch,
              TodoList todoList,
              FilteredTodos? filteredTodos,
            ) =>
                filteredTodos!
                  ..update(
                    todoFilter,
                    todoSearch,
                    todoList,
                  )),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: TodosPage(),
      ),
    );
  }
}
