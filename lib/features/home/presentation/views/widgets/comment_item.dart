import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:instagram_clone/features/home/data/models/comment_model.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment});
  final CommentModel comment;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: CachedImage(imageUrl: comment.userProfileImage),
      ),
      title: Text(
        comment.userName,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        comment.comemnt,
        style: const TextStyle(
          color: Color(0xff7D7D7D),
        ),
      ),
    );
  }
}
