import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/explore/presentation/managers/explore_cubit/explore_cubit.dart';
import 'package:instagram_clone/features/explore/presentation/views/widgets/explore_view_body.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: BlocProvider(
        create: (context) => ExploreCubit(),
        child: const ExploreViewBody(),
      )),
    );
  }
}
