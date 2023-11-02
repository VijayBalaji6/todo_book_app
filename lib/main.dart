import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/bloc/auth/auth_bloc.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/constants/colors.dart';
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
        BlocProvider(create: (context) => AuthBloc()),
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
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To-Do',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.secondaryLight),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
