import 'package:flutter/material.dart';

class InstagramLoader extends StatelessWidget {
  const InstagramLoader({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: <Color>[
            Color(0xFFF58529), // Orange
            Color(0xFFDD2A7B), // Red-pink
            Color(0xFF8134AF), // Purple
            Color(0xFF515BD4), // Blue
            Color(0xFF405DE6), // Indigo
            Color(0xFF5851DB), // Deep blue
            Color(0xFFC13584), // Magenta
            Color(0xFF833AB4), // Purple
            Color(0xFFFD1D1D), // Red
            Color(0xFFF56040), // Orange-red
          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
