import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:instagram_clone/features/add_post_and_reels/presentation/views/add_post_details_view.dart';
import 'package:instagram_clone/features/auth/presentation/views/sign_in_view.dart';
import 'package:instagram_clone/features/auth/presentation/views/sign_up_view.dart';
import 'package:instagram_clone/features/bottom_navigation_bar/presentation/views/bottom_navigation_bar_view.dart';

abstract class AppRouter {
  static const homeRoute = '/';
  static const signUpRoute = '/signUp';
  static const bottomNavigationBarRoute = '/BottomNavigationBar';
  static const addPostDetailsView = '/addPostDetailsView';

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
        path: bottomNavigationBarRoute,
        builder: (context, state) => const BottomNavigationBarView(),
      ),
      GoRoute(
        path: addPostDetailsView,
        builder: (context, state) => AddPostDetailsView(
          file: state.extra as File,
        ),
      ),
    ],
  );
}
