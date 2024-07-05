import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_button.dart';

void showAwesomeDialouge(
  BuildContext context, {
  required String title,
  required String description,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title),
      content: Text(description),
      actions: [
        CustomButton(
          title: 'Ok',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
