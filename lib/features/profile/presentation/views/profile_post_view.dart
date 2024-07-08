import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/post_item.dart';

import '../../../home/data/models/post_model.dart';

class ProfilePostView extends StatelessWidget {
  const ProfilePostView({super.key, required this.post});
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PostItem(post: post),
    );
  }
}
