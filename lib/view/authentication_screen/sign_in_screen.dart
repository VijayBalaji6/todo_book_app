import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/bloc/auth/auth_bloc.dart';
import 'package:todo/bloc/todo/todo_bloc.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/common_widgets/common_app_button.dart';
import 'package:todo/common_widgets/common_widgets.dart';
import 'package:todo/view/authentication_screen/sign_up_screen.dart';
import 'package:todo/view/home_screen/home_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController _emailTextField = TextEditingController();
  final TextEditingController _passwordTextField = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryLight,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignedInSuccessState) {
            CommonStylesAndWidget.showSnackbar(
                context: context,
                snackBarMessage: "Signed In As : ${state.successMessage}");
            context.read<TodoBloc>().add(const RegisterTodoServicesEvent());
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
          } else if (state is SignedInFailedState) {
            CommonStylesAndWidget.showSnackbar(
                context: context,
                snackBarMessage: "Sign Up Failed : ${state.failerMessage}");
          }
        },
        builder: (context, state) {
          bool isSigningUp = state is SigningInState;
          return Form(
            key: _signInFormKey,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.1.sh),
              child: SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    TextFormField(
                      controller: _emailTextField,
                      decoration: CommonStylesAndWidget.textfieldDecoration(
                          preFixIcon: Icons.email, hintTitle: "Email"),
                      style: const TextStyle(),
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    TextFormField(
                      controller: _passwordTextField,
                      obscureText: true,
                      decoration: CommonStylesAndWidget.textfieldDecoration(
                          suffixIcon: Icons.lock,
                          preFixIcon: Icons.key,
                          hintTitle: "Password"),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          context.read<AuthBloc>().add(EmailSignInEvent(
                              email: _emailTextField.text.trim().toLowerCase(),
                              password: _passwordTextField.text.trim()));
                        }
                      },
                      style: const TextStyle(),
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    CommonAppButton(
                      buttonAction: !isSigningUp
                          ? () {
                              context.read<AuthBloc>().add(EmailSignInEvent(
                                  email:
                                      _emailTextField.text.trim().toLowerCase(),
                                  password: _passwordTextField.text.trim()));
                            }
                          : null,
                      buttonName:
                          isSigningUp ? state.signingInMessage : 'Sign In',
                    ),
                    SizedBox(
                      height: 30.sp,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      ),
                      child: RichText(
                          text: TextSpan(
                              text: "Don't have an Account? ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                                fontSize: 18.sp,
                              ),
                            ),
                          ])),
                    ),
                    const Spacer(),
                    Text(
                      "---- or ----",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonAppButton(
                      buttonName: 'Login with Facebook',
                      buttonAction: () => context
                          .read<AuthBloc>()
                          .add(const FacebookSignInEvent()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonAppButton(
                      buttonName: 'Login with Google',
                      buttonAction: () => context
                          .read<AuthBloc>()
                          .add(const GoogleSignInEvent()),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
