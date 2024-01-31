import 'package:flutter/material.dart';
import 'package:todo/helper/ui_helper/common_widgets.dart';

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
          ],
        ),
      ),
    );
  }
}
