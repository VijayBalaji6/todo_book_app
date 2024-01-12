import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/bloc/auth/auth_bloc.dart';
import 'package:todo/constants/colors.dart';
import 'package:todo/helper/ui_helper/common_widgets.dart';
import 'package:todo/view/authentication_screen/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController passwordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignedInSuccessState) {
          CommonStylesAndWidget.showSnackbar(
              context: context,
              snackBarMessage: "Signed In As : ${state.successMessage}");
          //Navigator.of(context).pushAndRemoveUntil(const TodoHomeScreen(), (route) => false);
        } else if (state is SignedInFailedState) {
          CommonStylesAndWidget.showSnackbar(
              context: context,
              snackBarMessage: "Sign Up Failed : ${state.failerMessage}");
        }
      },
      builder: (context, state) {
        bool isSigningUp = state is SigningInState;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primaryLight,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.1.sw, vertical: 0.1.sh),
            child: SingleChildScrollView(
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
                  CommonStylesAndWidget.commonAppButton(
                    buttonAction: !isSigningUp
                        ? () {
                            context.read<AuthBloc>().add(EmailSignInEvent(
                                email: emailTextField.text.toLowerCase(),
                                password: passwordTextField.text));
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
                  SizedBox(
                    height: 150.sp,
                  ),
                  Text(
                    "Sign In using Social account",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                  socialAuthIcons(context),
                  SizedBox(
                    height: 30.sp,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Row socialAuthIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        socialAuthWidget(
            iconName: Icons.facebook,
            iconAction: () =>
                context.read<AuthBloc>().add(const FacebookSignInEvent())),
        const SizedBox(
          width: 30,
        ),
        socialAuthWidget(
            iconName: Icons.whatshot_sharp,
            iconAction: () =>
                context.read<AuthBloc>().add(const GoogleSignInEvent())),
      ],
    );
  }

  Widget socialAuthWidget(
          {required IconData iconName, required void Function()? iconAction}) =>
      IconButton(
        icon: Icon(
          iconName,
          size: 40.sp,
        ),
        onPressed: iconAction,
      );
}
