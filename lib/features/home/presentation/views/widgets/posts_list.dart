import 'package:flutter/material.dart';
import 'package:instagram_clone/features/home/presentation/managers/cubit/get_posts_cubit_cubit.dart';

import 'post_item.dart';

class PostsList extends StatelessWidget {
  const PostsList({
    super.key,
    required this.state,
  });
  final GetPostsCubitSuccess state;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: state.posts.length,
          (context, index) {
        return PostItem(post: state.posts[index]);
      }),
    );
  }
}
