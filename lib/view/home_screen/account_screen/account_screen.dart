import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/common_widgets/common_app_button.dart';
import 'package:todo/services/local_db/user_local_services.dart';
import 'package:todo/view/authentication_screen/sign_in_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
            CommonAppButton(
              buttonAction: () {},
              buttonName: 'Sync Account',
            ),
            CommonAppButton(
              buttonAction: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
                UserLocalServices.clearUserDataOnLogOut();
                await FirebaseAuth.instance.signOut();
              },
              buttonName: 'Log Out',
            ),
          ],
        ),
      ),
    );
  }
}
