import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/view/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc()
            ..add(LoadTodoEvent(todos: [
              TodoModel(
                title: 'First',
                id: '1',
                content: 'This is first Todo',
                note: 'Todo note 1',
                todoStatus: TodoStatus.inActive,
              ),
              TodoModel(
                title: 'Second',
                id: '2',
                content: 'This is second Todo',
                note: 'Todo note 2',
                todoStatus: TodoStatus.inActive,
              )
            ])),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
