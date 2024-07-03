import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/core/utils/common_widgets/custom_text_form_field.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
            isPassword: true,
            focusNode: FocusNode(),
          ),
        ],
      ),
    );
  }
}
