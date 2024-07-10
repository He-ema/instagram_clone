import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:instagram_clone/core/utils/common_widgets/instagram_loader.dart';
import 'package:instagram_clone/features/reels/data/models/reel_model.dart';
import 'package:video_player/video_player.dart';

class ReelItem extends StatefulWidget {
  const ReelItem({super.key, required this.reelModel});
  final ReelModel reelModel;
  @override
  State<ReelItem> createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  late VideoPlayerController controller;
  bool play = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.reelModel.video))
          ..initialize().then((_) {
            setState(() {});
            controller.setLooping(true);
            controller.setVolume(1.0);
            controller.play();
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onTap: () {
            changePlayingState();
          },
          child: controller.value.isInitialized
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: VideoPlayer(controller),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ),
        if (!play)
          Center(
            child: GestureDetector(
              onTap: () {
                changePlayingState();
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white24,
                radius: 35,
                child: Icon(
                  Icons.play_arrow,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.55,
          right: 10,
          child: const Column(
            children: [
              Icon(
                Icons.favorite_outline,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Icon(
                Icons.comment,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Icon(
                Icons.send,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40,
          left: 10,
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child:
                          CachedImage(imageUrl: widget.reelModel.profileImage),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.reelModel.userName,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Follow',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.reelModel.caption,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void changePlayingState() {
    setState(() {
      play = !play;
    });
    if (play) {
      controller.play();
    } else {
      controller.pause();
    }
  }
}
