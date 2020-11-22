import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ImageLoader extends StatelessWidget {
  final String imgUrl;
  final double height;

  ImageLoader(this.imgUrl, this.height);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
