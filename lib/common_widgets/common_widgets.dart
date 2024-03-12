import 'package:flutter/material.dart';

class CommonStylesAndWidget {
  static InputDecoration textfieldDecoration(
      {required String hintTitle, IconData? preFixIcon, IconData? suffixIcon}) {
    return InputDecoration(
      prefixIcon: preFixIcon != null ? Icon(preFixIcon) : null,
      suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      hintText: hintTitle,
      border: const OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.greenAccent)),
      hintMaxLines: 1,
    );
  }

  static void showSnackbar(
      {required BuildContext context, required String snackBarMessage}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(snackBarMessage)));
  }

  static void commonPopupWidget({
    required BuildContext context,
    required String popUpTitle,
    required String popUpContent,
    String? positiveButtonName,
    String? negativeButtonName,
    Function()? positiveButtonAction,
    Function()? negativeButtonAction,
  }) {
    showAdaptiveDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text(popUpTitle),
              content: Text(popUpContent),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    if (negativeButtonAction != null) negativeButtonAction();
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text(negativeButtonName ?? 'Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (positiveButtonAction != null) positiveButtonAction();
                    Navigator.pop(context, 'OK');
                  },
                  child: Text(positiveButtonName ?? 'OK'),
                ),
              ],
            )));
  }
}
