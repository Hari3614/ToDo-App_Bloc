import 'package:flutter/material.dart';
import 'package:todo_bloc/model/to_do_model.dart';

@immutable
sealed class ToDoState {}

final class ToDoInitial extends ToDoState {}

class InitialToDoState extends ToDoState {}

class LoadingToDoState extends ToDoState {}

class LoadedTODo extends ToDoState {
  final List<ToDoModel> todoList;
  LoadedTODo(this.todoList);
}

class ErrorToDoState extends ToDoState {
  final String errorMessage;

  ErrorToDoState(this.errorMessage);
}
