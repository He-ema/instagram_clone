import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/features/home/presentation/managers/get_posts_cubit/get_posts_cubit_cubit.dart';
import 'package:instagram_clone/features/home/presentation/managers/get_stories_cubit/get_stories_cubit.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => GetStoriesCubit(),
        child: const HomeViewBody(),
      ),
    );
  }
}
