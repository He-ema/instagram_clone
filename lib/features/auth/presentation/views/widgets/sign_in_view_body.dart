import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/core/utils/app_router.dart';
import 'package:instagram_clone/core/utils/app_styles.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/core/utils/common_methods/awesome_dialouge.dart';
import 'package:instagram_clone/features/auth/presentation/managers/auth_cubit/auth_cubit.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_or_widget.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          isLoading = true;
          setState(() {});
        } else if (state is AuthFailure) {
          isLoading = false;
          setState(() {});
          showAwesomeDialouge(context,
              title: state.errorHeader, description: state.errorMessage);
        } else {
          isLoading = false;
          setState(() {});
          GoRouter.of(context)
              .pushReplacement(AppRouter.bottomNavigationBarRoute);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesLogo),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTextFormField(
                      hint: 'Email',
                      controller: _emailController,
                      icon: Icons.email,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomTextFormField(
                      hint: 'Password',
                      controller: _passwordController,
                      isPassword: true,
                      icon: Icons.lock_outline_rounded,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomButton(
                      title: 'Sign In',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await BlocProvider.of<AuthCubit>(context)
                              .loginWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                        } else {
                          _autovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Doesn\'t have an account?',
                          style: AppStyles.styleRegular12,
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .pushReplacement(AppRouter.signUpRoute);
                          },
                          child: Text(' Sign Up',
                              style: AppStyles.styleRegular12
                                  .copyWith(color: const Color(0xff23244F))),
                        ),
                      ],
                    ),
                    const CustomOrWidget(),
                    CustomButton(
                      title: 'Sign up with Google',
                      image: Assets.imagesFacebook,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
