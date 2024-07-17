import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:instagram_clone/features/home/presentation/managers/upload_story.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({
    super.key,
    this.yours = false,
    required this.image,
    required this.isThereAstory,
  });
  final bool yours;
  final String image;
  final bool isThereAstory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: ShapeDecoration(
                color: isThereAstory
                    ? Colors.deepPurpleAccent
                    : Colors.transparent,
                shape: const CircleBorder()),
            child: Container(
              width: 80,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(image),
                    fit: BoxFit.cover),
                shape: const CircleBorder(),
              ),
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
