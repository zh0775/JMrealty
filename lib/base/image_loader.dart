import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String imgUrl;
  final double height;
  final BoxFit fit;
  ImageLoader(this.imgUrl, {this.height, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInDuration: Duration(milliseconds: 1),
      placeholderFadeInDuration: Duration(milliseconds: 1),
      fadeOutDuration: Duration(milliseconds: 1),
      imageUrl: imgUrl,
      height: this.height,

      // placeholder: (context, url) {
      //   return Image.asset(
      //     'assets/images/home/motivation_monochromatic.png',
      //     // width: context.size.width, height: context.size.height
      //   );
      // },
      // errorWidget: (context, url, error) {
      //   return Image.asset(
      //     'assets/images/home/motivation_monochromatic.png',
      //     // width: context.size.width,
      //     // height: context.size.height,
      //   );
      // },
      // height: height,
      fit: fit,
    );
  }
}
