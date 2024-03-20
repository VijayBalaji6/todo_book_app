import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/bloc/auth/auth_bloc.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/common_widgets/common_app_button.dart';
import 'package:todo/common_widgets/common_widgets.dart';
import 'package:todo/view/authentication_screen/sign_in_screen.dart';
import 'package:todo/view/home_screen/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController passwordTextField = TextEditingController();
  final TextEditingController confirmPasswordTextField =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignedUpSuccessState) {
          CommonStylesAndWidget.showSnackbar(
              context: context,
              snackBarMessage: "Signed Up As : ${state.successMessage}");
          context
              .read<TodoBloc>()
              .add(LoadTodoEvent(userId: state.user.userId));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  user: state.user,
                ),
              ),
              (route) => false);
        } else if (state is SignedUpFailedState) {
          CommonStylesAndWidget.showSnackbar(
              context: context,
              snackBarMessage:
                  "Sign Up Failed : ${state.signingUpFailureMessage}");
        }
      },
      builder: (context, state) {
        bool isSigningUp = state is SigningInState;
        return Scaffold(
          backgroundColor: AppColors.primaryLight,
          body: SingleChildScrollView(
            child: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.1.sh),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      TextFormField(
                        controller: emailTextField,
                        decoration: CommonStylesAndWidget.textfieldDecoration(
                            preFixIcon: Icons.email, hintTitle: "Email"),
                        style: const TextStyle(),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      TextFormField(
                        controller: passwordTextField,
                        decoration: CommonStylesAndWidget.textfieldDecoration(
                            preFixIcon: Icons.key, hintTitle: "Password"),
                        style: const TextStyle(),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      TextFormField(
                        controller: confirmPasswordTextField,
                        decoration: CommonStylesAndWidget.textfieldDecoration(
                            preFixIcon: Icons.key,
                            hintTitle: "Confirm Password"),
                        style: const TextStyle(),
                        onFieldSubmitted: (value) => context
                            .read<AuthBloc>()
                            .add(EmailSignUpEvent(
                                email: emailTextField.text.trim().toLowerCase(),
                                password: passwordTextField.text.trim())),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      CommonAppButton(
                        buttonAction: !isSigningUp
                            ? () {
                                context.read<AuthBloc>().add(EmailSignUpEvent(
                                    email: emailTextField.text
                                        .trim()
                                        .toLowerCase(),
                                    password: passwordTextField.text.trim()));
                              }
                            : null,
                        buttonName:
                            isSigningUp ? state.signingInMessage : 'Sign Up',
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        ),
                        child: RichText(
                            text: TextSpan(
                                text: "Already had an Account ? ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                                children: [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryDark,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ])),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      CommonAppButton(
                        buttonName: 'Sign up with Facebook',
                        buttonAction: () => context
                            .read<AuthBloc>()
                            .add(const FacebookSignUpEvent()),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      CommonAppButton(
                        buttonName: 'Sign up with Google',
                        buttonAction: () => context
                            .read<AuthBloc>()
                            .add(const GoogleSignUpEvent()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
