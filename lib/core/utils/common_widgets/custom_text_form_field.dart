import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/app_styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      required this.hint,
      required this.controller,
      required this.focusNode,
      this.isPassword});
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool? isPassword;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: (isHidden && (widget.isPassword ?? false)),
      validator: (value) {
        if (value!.isEmpty ?? true) {
          return 'This field can\'t be empty';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        suffixIcon: widget.isPassword != null
            ? IconButton(
                onPressed: () {
                  isHidden = !isHidden;
                  setState(() {});
                },
                icon: isHidden
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )
            : null,
        prefixIcon: const Icon(
          Icons.email,
          color: Color(0xffC5C5C5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        hintText: widget.hint,
        // hintStyle: AppStyles.styleRegular10,
        filled: true,
        fillColor: const Color(0xffEEEEEE),
        border: createBorder(),
        enabledBorder: createBorder(),
        focusedBorder: createBorder(),
      ),
    );
  }

  OutlineInputBorder createBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        width: 1,
        color: Color(0xffC5C5C5),
      ),
    );
  }
}
