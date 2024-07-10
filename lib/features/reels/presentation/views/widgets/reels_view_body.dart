import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/utils/common_widgets/instagram_loader.dart';
import 'package:instagram_clone/features/reels/presentation/managers/cubit/get_reels_cubit.dart';
import 'package:instagram_clone/features/reels/presentation/views/widgets/reel_item.dart';

class ReelsViewBody extends StatefulWidget {
  const ReelsViewBody({super.key});

  @override
  State<ReelsViewBody> createState() => _ReelsViewBodyState();
}

class _ReelsViewBodyState extends State<ReelsViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetReelsCubit>(context).getReels();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReelsCubit, GetReelsState>(
      builder: (context, state) {
        if (state is GetReelsSuccess) {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            itemCount: state.reels.length,
            itemBuilder: (context, index) {
              return ReelItem(
                reelModel: state.reels[index],
              );
            },
          );
        } else if (state is GetReelsFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const Center(
              child: InstagramLoader(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}
