import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void showAwesomeDialouge(BuildContext context,
    {required String title,
    required String description,
    @required DialogType? dialogType}) {
  AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: dialogType ?? DialogType.info,
    title: title,
    desc: description,
    btnOkOnPress: () {},
  ).show();
}
