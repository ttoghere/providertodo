// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:providertodo/models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(todos: [
      Todo(desc: "Clean the room", id: "1"),
      Todo(desc: "Work on ui", id: "2"),
      Todo(desc: "Look at firebase", id: "3"),
    ]);
  }

  @override
  String toString() => 'TodoListState(todos: $todos)';

  @override
  List<Object> get props => [todos];

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}

class TodoList extends ChangeNotifier {
  TodoListState _state = TodoListState.initial();
  TodoListState get state => _state;

  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newTodos = [..._state.todos, newTodo];
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void editTodo(String id, String todoDesc) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          desc: todoDesc,
          id: id,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final newTodos = _state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
          desc: todo.desc,
          id: id,
          completed: !todo.completed,
        );
      }
      return todo;
    }).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    final newTodos = _state.todos.where((Todo t) => t.id != todo.id).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}
