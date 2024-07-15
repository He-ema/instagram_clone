import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/assets.dart';

class ExploreTextField extends StatelessWidget {
  const ExploreTextField({super.key, required this.search, this.onChanged});
  final TextEditingController search;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: search,
      textAlign: TextAlign.start,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        hintText: "Search",
        hintStyle: const TextStyle(
          color: Colors.grey, // Customize the color of your hint text if needed
        ),
        filled: true,
        fillColor: const Color(0xff767680).withOpacity(0.12),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            Assets.imagesSearch,
            colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
        border: createBorder(),
        enabledBorder: createBorder(),
        focusedBorder: createBorder(),
      ),
      textAlignVertical: TextAlignVertical
          .center, // Ensure the text aligns vertically centered
    );
  }

  OutlineInputBorder createBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    );
  }
}
