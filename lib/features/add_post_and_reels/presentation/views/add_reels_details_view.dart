import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_clone/features/add_post_and_reels/presentation/views/widgets/add_reels_detials_view_body.dart';

class AddReelsDetailsView extends StatelessWidget {
  const AddReelsDetailsView({super.key, required this.videoFile});
  final File videoFile;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'New Reels',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: AddReelsDetailsViewBody(
        videoFile: videoFile,
      ),
    );
  }
}
