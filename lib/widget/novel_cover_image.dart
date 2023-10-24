import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NovelCoverImage extends StatelessWidget {
  final String imgUrl;
  final double? width;
  final double? height;
  NovelCoverImage(this.imgUrl, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFF5F5F5))),
      child: Image(
        image: CachedNetworkImageProvider(imgUrl),
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
}
