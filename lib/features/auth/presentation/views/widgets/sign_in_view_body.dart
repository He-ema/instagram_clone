import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/core/utils/app_router.dart';
import 'package:instagram_clone/core/utils/app_styles.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_or_widget.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_text_form_field.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  controller: TextEditingController(),
                  icon: Icons.email,
                ),
                const SizedBox(
                  height: 14,
                ),
                CustomTextFormField(
                  hint: 'Password',
                  controller: TextEditingController(),
                  isPassword: true,
                  icon: Icons.lock_outline_rounded,
                ),
                const SizedBox(
                  height: 14,
                ),
                CustomButton(
                  title: 'Sign In',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    } else {
                      _autovalidateMode = AutovalidateMode.always;
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
    );
  }
}
