import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/home/presentation/managers/get_stories_cubit/get_stories_cubit.dart';
import 'package:instagram_clone/features/home/presentation/managers/upload_story.dart';
import 'package:instagram_clone/features/home/presentation/views/story_view.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/story_item.dart';

import '../../../../../core/utils/common_widgets/instagram_loader.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStoriesCubit, GetStoriesState>(
      builder: (context, state) {
        if (state is GetStoriesSuccess) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, top: 100),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (state.currentUSerStories == null) {
                      await UploadStory().uploadStory();
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StoryView(
                          stories: [state.currentUSerStories!],
                        ),
                      ));
                    }
                  },
                  child: StoryItem(
                    isThereAstory: state.currentUSerStories != null,
                    yours: true,
                    image: FirebaseAuth.instance.currentUser!.photoURL!,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.stories.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StoryView(
                            stories: state.stories,
                            index: index,
                          ),
                        ));
                      },
                      child: StoryItem(
                        isThereAstory: true,
                        image: state.stories[index].image,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is GetStoriesFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const Center(
            child: InstagramLoader(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
