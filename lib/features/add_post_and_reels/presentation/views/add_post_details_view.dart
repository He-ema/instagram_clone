import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone/features/add_post_and_reels/presentation/managers/cubit/add_post_cubit.dart';

import '../../../../core/utils/common_methods/awesome_dialouge.dart';
import 'widgets/add_post_details_view_body.dart';

class AddPostDetailsView extends StatefulWidget {
  const AddPostDetailsView({super.key, required this.file});

  final File file;

  @override
  State<AddPostDetailsView> createState() => _AddPostDetailsViewState();
}

class _AddPostDetailsViewState extends State<AddPostDetailsView> {
  final TextEditingController caption = TextEditingController();
  final TextEditingController location = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: BlocListener<AddPostCubit, AddPostState>(
          listener: (context, state) {
            if (state is AddPostLoading) {
              isLoading = true;
              setState(() {});
            } else if (state is AddPostFailure) {
              isLoading = false;
              setState(() {});
              showAwesomeDialouge(context,
                  title: 'Error', description: state.errorMessage);
            } else {
              isLoading = false;
              setState(() {});
              GoRouter.of(context).pop();
            }
          },
          child: const Text(
            'New Post',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await BlocProvider.of<AddPostCubit>(context).createPost(
                  postImage: widget.file,
                  caption: caption.text,
                  location: location.text);
            },
            child: const Text(
              'Share',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: SpinKitWave(
                color: Colors.blue,
              ),
            )
          : AddPostDetailsViewBdoy(
              file: widget.file,
              caption: caption,
              location: location,
            ),
    );
  }
}
