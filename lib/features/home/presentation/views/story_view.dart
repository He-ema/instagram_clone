import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/home/data/models/story_model.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/story_view_body.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key, required this.stories, this.index});
  final List<StoryModel> stories;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StoryViewBody(
        stories: stories,
        index: index,
      ),
    );
  }
}
