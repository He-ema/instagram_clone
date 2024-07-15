import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/core/utils/app_router.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:instagram_clone/core/utils/common_widgets/instagram_loader.dart';
import 'package:instagram_clone/features/explore/presentation/managers/explore_cubit/explore_cubit.dart';
import 'package:instagram_clone/features/explore/presentation/managers/get_users_cubit/get_users_cubit_cubit.dart';
import 'package:instagram_clone/features/explore/presentation/views/widgets/explore_text_field.dart';
import 'package:instagram_clone/features/profile/presentation/views/profile_view.dart';

class ExploreViewBody extends StatefulWidget {
  const ExploreViewBody({super.key});

  @override
  State<ExploreViewBody> createState() => _ExploreViewBodyState();
}

class _ExploreViewBodyState extends State<ExploreViewBody> {
  final TextEditingController search = TextEditingController();
  bool show = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ExploreCubit>(context).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(
              bottom: 10,
              right: 10,
              left: 10,
            ),
            width: double.infinity,
            height: 40,
            child: ExploreTextField(
              search: search,
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty) {
                    show = true;
                    BlocProvider.of<GetUsersCubitCubit>(context)
                        .getUsers(userName: search.text);
                  } else {
                    show = false;
                  }
                });
              },
            ),
          ),
        ),
        if (!show)
          BlocBuilder<ExploreCubit, ExploreState>(
            builder: (context, state) {
              if (state is ExploreSuccess) {
                return SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(
                              AppRouter.profilePostViewRoute,
                              extra: state.posts[index]);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child:
                              CachedImage(imageUrl: state.posts[index].image),
                        ),
                      );
                    }, childCount: state.posts.length),
                    gridDelegate: SliverQuiltedGridDelegate(
                      repeatPattern: QuiltedGridRepeatPattern.inverted,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                      crossAxisCount: 3,
                      pattern: [
                        const QuiltedGridTile(2, 1),
                        const QuiltedGridTile(2, 2),
                        const QuiltedGridTile(1, 1),
                        const QuiltedGridTile(1, 1),
                        const QuiltedGridTile(1, 1),
                      ],
                    ));
              } else if (state is ExploreFailure) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(state.errorMessage),
                  ),
                );
              } else {
                return const SliverFillRemaining(
                  child: Center(
                      child: InstagramLoader(
                    child: CircularProgressIndicator(),
                  )),
                );
              }
            },
          ),
        if (show)
          BlocBuilder<GetUsersCubitCubit, GetUsersCubitState>(
            builder: (context, state) {
              if (state is GetUsersCubitSuccess) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: state.users.length, (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProfileView(email: state.users[index].email)));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(state.users[index].image),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            state.users[index].userName,
                          ),
                        ],
                      ),
                    ),
                  );
                }));
              } else if (state is GetUsersCubitFailure) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(state.errorMessage),
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: InstagramLoader(child: CircularProgressIndicator()),
                  ),
                );
              }
            },
          ),
      ],
    );
  }
}
