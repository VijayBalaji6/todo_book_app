import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/helper/ui_helper/common_widgets.dart';
import 'package:todo/view/authentication_screen/sign_in_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Image.asset("assets/accounts/default_profile.png"),
            ),
            CommonStylesAndWidget.commonAppButton(
              buttonAction: () {},
              buttonName: 'Sync Account',
            ),
            CommonStylesAndWidget.commonAppButton(
              buttonAction: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              buttonName: 'Log Out',
            ),
          ],
        ),
      ),
    );
  }
}
