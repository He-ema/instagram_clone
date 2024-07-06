import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/utils/assets.dart';
import 'package:instagram_clone/features/explore/presentation/views/explore_view.dart';
import 'package:instagram_clone/features/home/presentation/views/home_view.dart';
import 'package:instagram_clone/features/profile/presentation/views/profile_view.dart';
import 'package:instagram_clone/features/reels/presentation/views/reels_view.dart';

import '../../../add_post_and_reels/presentation/views/add_view.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  navigationTapped(int page) {
    pageController.jumpToPage(page);
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
              icon: SvgPicture.asset(
                Assets.imagesHome,
                colorFilter: ColorFilter.mode(
                    _currentIndex == 0 ? Colors.black : Colors.grey,
                    BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.imagesSearch,
                colorFilter: ColorFilter.mode(
                    _currentIndex == 1 ? Colors.black : Colors.grey,
                    BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera,
                  color: _currentIndex == 2 ? Colors.black : Colors.grey),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.imagesReels,
                colorFilter: ColorFilter.mode(
                    _currentIndex == 3 ? Colors.black : Colors.grey,
                    BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.imagesProfile,
                colorFilter: ColorFilter.mode(
                    _currentIndex == 4 ? Colors.black : Colors.grey,
                    BlendMode.srcIn),
              ),
              label: '',
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomeView(),
          ExploreView(),
          AddView(),
          ReelsView(),
          ProfileView(),
        ],
      ),
    );
  }
}
