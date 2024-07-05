import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/core/utils/app_router.dart';
import 'package:instagram_clone/core/utils/app_styles.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/core/utils/common_methods/awesome_dialouge.dart';
import 'package:instagram_clone/features/auth/presentation/managers/auth_cubit/auth_cubit.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_or_widget.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/utils/common_methods/pick_image.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? image;
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    _bioController.dispose();
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
          showAwesomeDialouge(
            context,
            title: state.errorHeader,
            description: state.errorMessage,
          );
        } else {}
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: _autovalidateMode,
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesLogo),
                    const SizedBox(
                      height: 14,
                    ),
                    GestureDetector(
                      onTap: () async {
                        image = await uploadImage('Gallery');
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: MediaQuery.sizeOf(context).width * 0.1,
                        backgroundImage: image == null
                            ? const AssetImage(Assets.imagesPreson)
                            : FileImage(image!) as ImageProvider,
                      ),
                    ),
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
                      hint: 'user name',
                      controller: _userNameController,
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomTextFormField(
                      hint: 'Bio',
                      controller: _bioController,
                      icon: Icons.info_outline,
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
                      title: 'Sign up',
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
                          'Already have an account?',
                          style: AppStyles.styleRegular12,
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .pushReplacement(AppRouter.homeRoute);
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
          ),
        ),
      ),
    );
  }
}
