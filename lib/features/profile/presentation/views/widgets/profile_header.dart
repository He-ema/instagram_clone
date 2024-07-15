import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:instagram_clone/features/add_post_and_reels/data/models/user_model.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
    required this.posts,
    required this.yours,
  });
  final UserModel user;
  final int posts;
  final bool yours;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10),
              child: ClipOval(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Container(
                    child: CachedImage(imageUrl: user.image),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        posts.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Text(
                        'Posts',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        user.followers.length.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Text(
                        'Fllowers',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        user.following.length.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Text(
                        'Following',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.userName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                user.bio,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: CustomButton(
            title: yours ? 'Edit Your Profile' : 'Follow',
            color: yours ? Colors.grey.shade300 : Colors.blue,
            textColor: yours ? Colors.black : Colors.white,
            onPressed: () {},
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const SizedBox(
          height: 50,
          child: TabBar(
              overlayColor: MaterialStatePropertyAll(Colors.transparent),
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                Icon(Icons.grid_on_rounded),
                Icon(Icons.video_collection),
                Icon(Icons.person),
              ]),
        ),
      ],
    );
  }
}
