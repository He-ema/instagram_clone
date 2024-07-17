import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';

import '../../../data/models/story_model.dart';

class StoryViewBody extends StatelessWidget {
  const StoryViewBody({super.key, required this.stories});
  final List<StoryModel> stories;
  @override
  Widget build(BuildContext context) {
    return StoryPageView(
      backgroundColor: Colors.black,
      pageLength: (stories.length),
      storyLength: (pageIndex) {
        return stories[pageIndex].stories.length;
      },
      itemBuilder: (context, pageIndex, storyIndex) {
        return Container(
          color: Colors.black,
          child: Stack(
            alignment: Alignment.center,
            children: [
              StoryImage(
                  key: key,
                  imageProvider: CachedNetworkImageProvider(
                      stories[pageIndex].stories[storyIndex])),
              Positioned(
                  top: 50,
                  left: 20,
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CachedImage(
                                  imageUrl: stories[pageIndex].image))),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        stories[pageIndex].userName,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
            ],
          ),
        );
      },
      onPageLimitReached: () {
        Navigator.of(context).pop();
      },
    );
  }
}
