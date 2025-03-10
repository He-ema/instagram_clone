import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/core/utils/app_router.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/core/utils/common_widgets/cached_image.dart';
import 'package:instagram_clone/core/utils/common_widgets/instagram_loader.dart';
import 'package:instagram_clone/features/profile/presentation/managers/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:instagram_clone/features/profile/presentation/views/widgets/profile_header.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key,
    required this.yours,
    required this.email,
  });
  final bool yours;
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
      builder: (context, state) {
        if (state is GetProfileDataSuccess) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ProfileHeader(
                  email: email,
                  yours: yours,
                  user: state.userModel,
                  posts: state.posts.length,
                ),
              ),
              SliverFillRemaining(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(
                            AppRouter.profilePostViewRoute,
                            extra: state.posts[index]);
                      },
                      child: Container(
                        child: CachedImage(imageUrl: state.posts[index].image),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is GetProfileDataFailure) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const Center(
              child: InstagramLoader(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
