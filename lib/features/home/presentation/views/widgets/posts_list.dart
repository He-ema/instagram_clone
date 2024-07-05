import 'package:flutter/material.dart';

import 'post_item.dart';

class PostsList extends StatelessWidget {
  const PostsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: 2, (context, index) {
        return const PostItem();
      }),
    );
  }
}
