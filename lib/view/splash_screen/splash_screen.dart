import 'package:flutter/material.dart';
import 'package:todo/view/todo_screen/todo_home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TodoHomeScreen())));
    return Scaffold(
      body: Center(
        child: Image.asset("assets/app_logo/todo_app_logo.png"),
      ),
    );
  }
}
