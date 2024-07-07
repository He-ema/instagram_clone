import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddPostDetailsViewBdoy extends StatelessWidget {
  const AddPostDetailsViewBdoy({
    super.key,
    required this.file,
    required this.caption,
    required this.location,
  });
  final File file;
  final TextEditingController caption;
  final TextEditingController location;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Divider(
        //     color: Color(0xffE0E0E0),
        //   ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              width: MediaQuery.sizeOf(context).width * 0.25,
              height: MediaQuery.sizeOf(context).width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: FileImage(file),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: caption,
                decoration: const InputDecoration(
                  hintText: 'Write a caption...',
                  border: InputBorder.none,
                ),
              ),
            )),
          ],
        ),
        const Divider(
          color: Color(0xffE0E0E0),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: location,
              decoration: const InputDecoration(
                hintText: 'Add Location...',
                border: InputBorder.none,
              ),
              // maxLines: null,
              // keyboardType: TextInputType.multiline,
              // textInputAction: TextInputAction.newline,
            ),
          ),
        ),
      ],
    );
  }
}
