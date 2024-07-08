import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.title, this.image, this.onPressed, this.color});
  final String title;
  final String? image;
  final Color? color;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? const Color(0xff1877F2),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            )),
        onPressed: onPressed,
        child: image == null
            ? Text(
                title,
                style: color == null
                    ? AppStyles.styleMedium12
                    : const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(image!),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    title,
                    style: AppStyles.styleMedium12,
                  ),
                ],
              ),
      ),
    );
  }
}
