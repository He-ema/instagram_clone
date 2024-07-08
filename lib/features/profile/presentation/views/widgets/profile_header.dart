import 'package:flutter/material.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

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
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '10',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Posts',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '20',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Fllowers',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '30',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
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
        const Padding(
          padding: EdgeInsets.only(left: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'bio',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
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
            title: 'Edit Your Profile',
            color: Colors.grey.shade300,
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
