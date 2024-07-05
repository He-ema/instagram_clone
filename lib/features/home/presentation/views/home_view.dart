import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        // elevation: 1,
        backgroundColor: Colors.white,
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
      ),
      body: const HomeViewBody(),
    );
  }
}
