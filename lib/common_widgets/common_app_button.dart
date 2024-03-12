import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';

class CommonAppButton extends StatelessWidget {
  const CommonAppButton(
      {super.key, this.buttonAction, required this.buttonName});
  final Function()? buttonAction;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: buttonAction,
        style: buttonStyle(),
        child: Text(
          buttonName,
          style: buttonTextStyle(),
        ));
  }

  TextStyle buttonTextStyle() {
    return const TextStyle(color: Colors.white, fontSize: 20);
  }

  ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      fixedSize: const Size(395, 55),
      backgroundColor: AppColors.blackColor,
    );
  }
}
