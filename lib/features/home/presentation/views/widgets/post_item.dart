import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/constants.dart';
import 'package:instagram_clone/core/utils/common_methods/like.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:instagram_clone/features/home/presentation/managers/add_comment_cubit/comment_cubit.dart';
import 'package:instagram_clone/features/home/presentation/managers/get_comments_cubit/get_comments_cubit.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/comments.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/like_animation.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';
import '../../../data/models/post_model.dart';

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    required this.post,
  });
  final PostModel post;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isAnimating = false;
  String user = '';
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = _firebaseAuth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ListTile(
            leading: ClipOval(
              child: SizedBox(
                  width: 35,
                  height: 35,
                  child: CachedImage(imageUrl: widget.post.profileImage)),
            ),
            title: Text(
              widget.post.username,
              style: AppStyles.styleRegular14.copyWith(color: Colors.black),
            ),
            subtitle: Text(
              widget.post.location,
              style: AppStyles.styleRegular12.copyWith(
                color: const Color(0xff7D7D7D),
              ),
            ),
            trailing: const Icon(Icons.more_horiz, color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          onDoubleTap: () {
            LikeAnimationMethod();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.45,
                child: CachedImage(imageUrl: widget.post.image),
              ),
              AnimatedOpacity(
                opacity: isAnimating ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: LikeAnimation(
                  isAnimation: isAnimating,
                  duration: const Duration(milliseconds: 400),
                  onEnd: () {
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   if (mounted) {
                    //     setState(() {
                    //       isAnimating = false;
                    //     });
                    //   }
                    // });
                  },
                  child: const Icon(
                    Icons.favorite,
                    size: 100,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          LikeAnimationMethod();
                        },
                        icon: Icon(
                          widget.post.likes.contains(user)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          size: 30,
                          color: widget.post.likes.contains(user)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                          onTap: () {
                            showBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: DraggableScrollableSheet(
                                    expand: false,
                                    maxChildSize: 0.7,
                                    initialChildSize: 0.7,
                                    minChildSize: 0.2,
                                    builder: (context, scrollController) {
                                      return MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create: (context) => CommentCubit(),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                GetCommentsCubit(),
                                          ),
                                        ],
                                        child: Comments(
                                          type: kPostsCollectionReference,
                                          uid: widget.post.postId,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: SvgPicture.asset(Assets.imagesComment)),
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset(Assets.imagesSend),
                    ],
                  ),
                  SvgPicture.asset(Assets.imagesSave),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    ' likes ${widget.post.likes.length}',
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${widget.post.username} ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.post.caption,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  formatDate(
                      widget.post.date.toDate(), [yyyy, '-', mm, '-', dd]),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void LikeAnimationMethod() {
    setState(() {
      isAnimating = true;
      Like().like(
          like: widget.post.likes,
          postId: widget.post.postId,
          type: kPostsCollectionReference,
          uid: user);
      Future.delayed(const Duration(milliseconds: 500), () {
        isAnimating = false;
        setState(() {});
      });
    });
  }
}
