import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/app_styles.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/core/utils/common_widgets/instagram_loader.dart';
import 'package:instagram_clone/features/home/presentation/managers/get_posts_cubit/get_posts_cubit_cubit.dart';
import 'package:instagram_clone/features/home/presentation/managers/get_stories_cubit/get_stories_cubit.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/posts_list.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/story_list_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetPostsCubitCubit>(context).getPosts();
    BlocProvider.of<GetStoriesCubit>(context).getStories();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Image.asset(Assets.imagesSmallLogo),
          actions: [
            SvgPicture.asset(Assets.imagesAdd),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: SvgPicture.asset(Assets.imagesFavorite),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SvgPicture.asset(Assets.imagesMessenger),
            ),
          ],
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          pinned: true,
          expandedHeight: 130,
          toolbarHeight: 40,
          collapsedHeight: 50,
          flexibleSpace: const FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            background: StoryListView(),
          ),
        ),
        // const SliverToBoxAdapter(
        //   child: Divider(
        //     color: Color(0xffE0E0E0),
        //   ),
        // ),
        BlocBuilder<GetPostsCubitCubit, GetPostsCubitState>(
          builder: (context, state) {
            if (state is GetPostsCubitSuccess) {
              return PostsList(
                state: state,
              );
            } else if (state is GetPostsCubitFailure) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text("No Posts Found"),
                ),
              );
            } else {
              return const SliverFillRemaining(
                  child: Center(
                      child:
                          InstagramLoader(child: CircularProgressIndicator())));
            }
          },
        ),
      ],
    );
  }
}
