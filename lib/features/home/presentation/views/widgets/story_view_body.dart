import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
          child: StoryImage(
              key: key,
              imageProvider: CachedNetworkImageProvider(
                  stories[pageIndex].stories[storyIndex])),
        );
      },
      onPageLimitReached: () {
        Navigator.of(context).pop();
      },
    );
  }
}
