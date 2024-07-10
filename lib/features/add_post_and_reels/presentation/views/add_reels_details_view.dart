import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/add_post_and_reels/presentation/managers/add_reel_cubit/add_reel_cubit.dart';
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
      body: BlocProvider(
        create: (context) => AddReelCubit(),
        child: AddReelsDetailsViewBody(
          videoFile: videoFile,
        ),
      ),
    );
  }
}
