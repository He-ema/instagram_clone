import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/home/presentation/managers/add_comment_cubit/comment_cubit.dart';
import 'package:instagram_clone/features/home/presentation/managers/get_comments_cubit/get_comments_cubit.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/comment_item.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      BlocProvider.of<GetCommentsCubit>(context)
          .getComments(type: widget.type, uuid: widget.uid);
    }
  }

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
            BlocBuilder<GetCommentsCubit, GetCommentsState>(
              builder: (context, state) {
                if (state is GetCommentsSuccess) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView.builder(
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        return CommentItem(comment: state.comments[index]);
                      },
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
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
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(10),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            if (comment.text.isNotEmpty) {
                              await BlocProvider.of<CommentCubit>(context)
                                  .addComment(
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
