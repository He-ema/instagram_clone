import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/features/add_post_and_reels/presentation/managers/add_post_cubit/add_post_cubit.dart';
import 'package:instagram_clone/features/add_post_and_reels/presentation/views/add_post_details_view.dart';
import 'package:instagram_clone/features/add_post_and_reels/presentation/views/add_reels_details_view.dart';
import 'package:instagram_clone/features/auth/presentation/views/sign_in_view.dart';
import 'package:instagram_clone/features/auth/presentation/views/sign_up_view.dart';
import 'package:instagram_clone/features/bottom_navigation_bar/presentation/views/bottom_navigation_bar_view.dart';
import 'package:instagram_clone/features/home/data/models/post_model.dart';
import 'package:instagram_clone/features/home/presentation/managers/get_posts_cubit/get_posts_cubit_cubit.dart';
import 'package:instagram_clone/features/profile/presentation/views/profile_post_view.dart';
import 'package:instagram_clone/features/reels/presentation/managers/cubit/get_reels_cubit.dart';

abstract class AppRouter {
  static const homeRoute = '/';
  static const signUpRoute = '/signUp';
  static const bottomNavigationBarRoute = '/BottomNavigationBar';
  static const addPostDetailsView = '/addPostDetailsView';
  static const profilePostViewRoute = '/profilePostView';
  static const addReelsDetailsViewRoute = '/AddReelsDetailsView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: homeRoute,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: signUpRoute,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: addReelsDetailsViewRoute,
        builder: (context, state) => AddReelsDetailsView(
          videoFile: state.extra as File,
        ),
      ),
      GoRoute(
        path: bottomNavigationBarRoute,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetPostsCubitCubit(),
            ),
            BlocProvider(
              create: (context) => GetReelsCubit(),
            ),
          ],
          child: const BottomNavigationBarView(),
        ),
      ),
      GoRoute(
        path: addPostDetailsView,
        builder: (context, state) => BlocProvider(
          create: (context) => AddPostCubit(),
          child: AddPostDetailsView(
            file: state.extra as File,
          ),
        ),
      ),
      GoRoute(
        path: profilePostViewRoute,
        builder: (context, state) => ProfilePostView(
          post: state.extra as PostModel,
        ),
      ),
    ],
  );
}
