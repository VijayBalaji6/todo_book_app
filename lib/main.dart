import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/bloc/auth/auth_bloc.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/constants/theme.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/services/local_db/todo_local_services.dart';
import 'package:todo/services/remote_db/auth_services.dart';
import 'package:todo/services/remote_db/user_services.dart';
import 'package:todo/view/authentication_screen/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialing firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Initializing hive local Db
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(TodoStatusAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc(AuthServices.instance, UserServices.instance)
                ..add(CheckAuthenticationEvent()),
        ),
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => TodoBloc(TodoLocalServices.instance)
            ..add(const RegisterTodoServicesEvent()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To-Do',
          theme: AppTheme.myAppTheme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
