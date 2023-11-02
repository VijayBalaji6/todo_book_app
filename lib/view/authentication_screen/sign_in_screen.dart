import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/bloc/auth/auth_bloc.dart';
import 'package:todo/helper/ui_helper/common_widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.1.sh),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Sign Up',
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30.sp,
                ),
                CommonStylesAndWidget.commonAppButton(
                  buttonAction: () {
                    context.read<AuthBloc>().add(const SignInEvent(
                        email: 'nvbalaji6@gmail.com', password: '12345'));
                  },
                  buttonName: 'Sign In',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
