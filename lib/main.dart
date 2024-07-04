import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/app_router.dart';
import 'package:instagram_clone/features/auth/presentation/views/sign_in_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
