import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/home/presentation/managers/get_stories_cubit/get_stories_cubit.dart';
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
                const StoryItem(
                  yours: true,
                  image:
                      'https://firebasestorage.googleapis.com/v0/b/insta-clone-d649c.appspot.com/o/zx.hema%40gmail.com?alt=media&token=7330dbf9-9655-4cbf-9d81-3b7bbb06e6f0',
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.stories.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StoryView(
                              stories: state.stories,
                            ),
                          ));
                        },
                        child: StoryItem(
                          image: state.stories[index].image,
                        ),
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
