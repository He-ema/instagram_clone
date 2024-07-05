import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/auth/presentation/managers/auth_cubit/auth_cubit.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/sign_in_view_body.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: const SignInViewBody(),
      ),
    );
  }
}
