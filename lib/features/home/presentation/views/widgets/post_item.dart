import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/assets.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
  });

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
                  child: Image.asset(Assets.imagesPreson)),
            ),
            title: const Text(
              'Username',
              style: AppStyles.styleRegular14,
            ),
            subtitle: const Text(
              'location',
              style: AppStyles.styleRegular12,
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
          child: Image.asset(
            Assets.imagesPost,
            fit: BoxFit.cover,
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
                      SvgPicture.asset(Assets.imagesSmallFavourite),
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset(Assets.imagesComment),
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
              const Row(
                children: [
                  Text(
                    'Username ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'caption',
                    style: TextStyle(
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'date',
                  style: TextStyle(
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
