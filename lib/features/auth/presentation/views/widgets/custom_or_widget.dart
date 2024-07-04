import 'package:flutter/material.dart';

class CustomOrWidget extends StatelessWidget {
  const CustomOrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            height: 64,
            endIndent: 25,
          ),
        ),
        Text('OR'),
        Expanded(
            child: Divider(
          indent: 25,
        )),
      ],
    );
  }
}
