import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/comments.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';
import '../../../data/models/post_model.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
  });
  final PostModel post;
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
                  child: CachedImage(imageUrl: post.profileImage)),
            ),
            title: Text(
              post.username,
              style: AppStyles.styleRegular14.copyWith(color: Colors.black),
            ),
            subtitle: Text(
              post.location,
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
        SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.45,
          child: CachedImage(imageUrl: post.image),
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
                      SvgPicture.asset(Assets.imagesSmallFavourite),
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
                                      return const Comments();
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
                    ' likes ${post.likes.length}',
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${post.username} ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    post.caption,
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
                  formatDate(post.date.toDate(), [yyyy, '-', mm, '-', dd]),
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
}
