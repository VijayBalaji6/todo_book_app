import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/bloc/auth/auth_bloc.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/view/authentication_screen/sign_in_screen.dart';
import 'package:todo/view/home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthenticatedState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            user: state.loggedUserDate,
                          )));
            } else if (state is UnAuthenticatedState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            }
          },
          child: SizedBox(
              height: 200.sp,
              width: 200.sp,
              child: Image.asset("assets/app_logo/todo_app_logo.png")),
        ),
      ),
    );
  }
}
