import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:instagram_clone/features/home/presentation/managers/upload_story.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({
    super.key,
    this.yours = false,
    required this.image,
  });
  final bool yours;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const ShapeDecoration(
              gradient: LinearGradient(colors: [
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
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              shape: CircleBorder(),
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedImage(imageUrl: image)),
            ),
          ),
          if (yours)
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () async {
                  await UploadStory().uploadStory();
                },
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.cyanAccent,
                  child: Icon(Icons.add),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
