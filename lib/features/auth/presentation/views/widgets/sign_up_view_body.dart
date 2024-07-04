import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/core/utils/app_router.dart';
import 'package:instagram_clone/core/utils/app_styles.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_or_widget.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_text_form_field.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
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
                hint: 'user name',
                controller: TextEditingController(),
                icon: Icons.person_outline_rounded,
              ),
              const SizedBox(
                height: 14,
              ),
              CustomTextFormField(
                hint: 'Bio',
                controller: TextEditingController(),
                icon: Icons.info_outline,
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
              const CustomButton(title: 'Sign up'),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: AppStyles.styleRegular12,
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushReplacement(AppRouter.homeRoute);
                    },
                    child: Text(' Sign In',
                        style: AppStyles.styleRegular12
                            .copyWith(color: const Color(0xff23244F))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
