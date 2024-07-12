import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/home/presentation/managers/add_comment_cubit/comment_cubit.dart';

class Comments extends StatefulWidget {
  const Comments({super.key, required this.type, required this.uid});
  final String type;
  final String uid;
  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Container(
        color: Colors.white,
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: MediaQuery.sizeOf(context).width * 0.7 / 2,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.3,
                height: 3,
                color: Colors.black,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: TextField(
                      controller: comment,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            if (comment.text.isNotEmpty) {
                              BlocProvider.of<CommentCubit>(context).addComment(
                                  comment: comment.text,
                                  type: widget.type,
                                  uuid: widget.uid);
                              comment.clear();
                            }
                          },
                          child: const Icon(Icons.send),
                        ),
                        hintText: 'Add a comment...',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
