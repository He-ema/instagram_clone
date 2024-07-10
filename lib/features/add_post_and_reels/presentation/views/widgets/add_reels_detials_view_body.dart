import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/common_widgets/instagram_loader.dart';
import 'package:video_player/video_player.dart';

class AddReelsDetailsViewBody extends StatefulWidget {
  const AddReelsDetailsViewBody({super.key, required this.videoFile});
  final File videoFile;
  @override
  State<AddReelsDetailsViewBody> createState() =>
      _AddReelsDetailsViewBodyState();
}

class _AddReelsDetailsViewBodyState extends State<AddReelsDetailsViewBody> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
        controller.setLooping(true);
        controller.setVolume(1.0);
        controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        SizedBox(
          width: 270,
          height: 420,
          child: controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                )
              : const InstagramLoader(child: CircularProgressIndicator()),
        ),
      ],
    ));
  }
}
