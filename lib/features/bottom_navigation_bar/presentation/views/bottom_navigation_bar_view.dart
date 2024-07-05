import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/features/explore/presentation/views/explore_view.dart';
import 'package:instagram_clone/features/home/presentation/views/home_view.dart';
import 'package:instagram_clone/features/profile/presentation/views/profile_view.dart';
import 'package:instagram_clone/features/reels/presentation/views/reels_view.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int _currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: navigationTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.imagesHome),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.imagesSearch),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.imagesProfile),
              label: '',
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomeView(),
          ExploreView(),
          ReelsView(),
          ProfileView(),
        ],
      ),
    );
  }
}
