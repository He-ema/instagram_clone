import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          'New Post',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {},
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
      body: AddPostDetailsViewBdoy(
        file: widget.file,
        caption: caption,
        location: location,
      ),
    );
  }
}
