import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:instagram_clone/features/add_post_and_reels/data/models/user_model.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:instagram_clone/features/profile/presentation/managers/follow.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({
    super.key,
    required this.user,
    required this.posts,
    required this.yours,
    required this.email,
  });
  final UserModel user;
  final int posts;
  final bool yours;
  final String email;

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool userExists = false;
  int addedValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.user.followers
        .contains(FirebaseAuth.instance.currentUser!.email)) {
      setState(() {
        userExists = true;
      });
    }
  }

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
                    child: CachedImage(imageUrl: widget.user.image),
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
                        widget.posts.toString(),
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
                        (widget.user.followers.length + addedValue).toString(),
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
                        widget.user.following.length.toString(),
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
                widget.user.userName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.user.bio,
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
            title: widget.yours
                ? 'Edit Your Profile'
                : (userExists ? 'Unfollow' : 'Follow'),
            color: widget.yours
                ? Colors.grey.shade300
                : (userExists ? Colors.grey.shade300 : Colors.blue),
            textColor: widget.yours
                ? Colors.black
                : (userExists
                    ? const Color.fromARGB(255, 54, 49, 49)
                    : Colors.white),
            onPressed: () {
              if (!widget.yours) {
                Follow().follow(email: widget.email);
                setState(() {
                  userExists ? addedValue-- : addedValue++;
                  userExists = !userExists;
                });
              }
            },
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
