import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/common_widgets/instagram_loader.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: InstagramLoader(
              child: CircularProgressIndicator(
            value: progress.progress,
          )),
        );
      },
      errorWidget: (context, url, error) {
        return const Icon(Icons.error);
      },
    );
  }
}
