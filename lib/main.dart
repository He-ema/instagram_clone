import 'package:flutter/material.dart';
import 'package:instagram_clone/features/sign_up/presentation/views/sign_up_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignUpView(),
    );
  }
}
