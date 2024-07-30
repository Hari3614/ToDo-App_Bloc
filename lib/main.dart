import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/to_do_bloc.dart.dart';
import 'package:todo_bloc/domain/todo_api_functions.dart';
import 'package:todo_bloc/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoBloc(ToDoApiFunctions()),
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        home: const HomeScreenToDo(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
