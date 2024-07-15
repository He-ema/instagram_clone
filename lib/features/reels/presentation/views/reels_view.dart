import 'package:flutter/material.dart';
import 'package:instagram_clone/features/reels/presentation/views/widgets/reels_view_body.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff1c1e21),
      body: ReelsViewBody(),
    );
  }
}
