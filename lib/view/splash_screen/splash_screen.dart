import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/view/authentication_screen/sign_in_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen())));
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Center(
        child: SizedBox(
            height: 200.sp,
            width: 200.sp,
            child: Image.asset("assets/app_logo/todo_app_logo.png")),
      ),
    );
  }
}
