import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/core/utils/common_methods/awesome_dialouge.dart';
import 'package:instagram_clone/core/utils/common_widgets/instagram_loader.dart';
import 'package:instagram_clone/features/add_post_and_reels/presentation/managers/add_reel_cubit/add_reel_cubit.dart';
import 'package:instagram_clone/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:video_player/video_player.dart';

class AddReelsDetailsViewBody extends StatefulWidget {
  const AddReelsDetailsViewBody({super.key, required this.videoFile});
  final File videoFile;
  @override
  State<AddReelsDetailsViewBody> createState() =>
      _AddReelsDetailsViewBodyState();
}

class _AddReelsDetailsViewBodyState extends State<AddReelsDetailsViewBody> {
  final TextEditingController caption = TextEditingController();

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
  dispose() {
    super.dispose();
    controller.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<AddReelCubit, AddReelState>(
      listener: (context, state) {
        if (state is AddReelLoading) {
          isLoading = true;
          setState(() {});
        } else if (state is AddReelFailure) {
          isLoading = false;
          setState(() {});
          showAwesomeDialouge(context,
              title: 'Error', description: state.errorMessage);
        } else if (state is AddReelSuccess) {
          isLoading = false;
          setState(() {});
          GoRouter.of(context).pop();
        }
      },
      child: isLoading
          ? const Center(
              child: InstagramLoader(
              child: CircularProgressIndicator(),
            ))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.value.isInitialized
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: AspectRatio(
                                      aspectRatio: controller.value.aspectRatio,
                                      child: VideoPlayer(controller),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: TextField(
                                      onTapOutside: (event) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      controller: caption,
                                      decoration: const InputDecoration(
                                        hintText: 'Write a caption...',
                                        border: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: CustomButton(
                                        title: 'Save draft',
                                        color: Colors.white,
                                        border: true,
                                        onPressed: () {},
                                      )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: CustomButton(
                                        title: 'Share',
                                        onPressed: () async {
                                          controller.pause();
                                          await BlocProvider.of<AddReelCubit>(
                                                  context)
                                              .createReel(
                                                  reelVideo: widget.videoFile,
                                                  caption: caption.text);
                                        },
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : const Center(
                              child: InstagramLoader(
                                  child: CircularProgressIndicator())),
                    ],
                  ),
                ),
              ),
            ),
    ));
  }
}
