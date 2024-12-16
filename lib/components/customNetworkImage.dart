import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


// this is the custom network image used everywhere, where image is displayed
class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  const CustomNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          Icon(Icons.image),
      errorWidget: (context, url, error) =>
          Icon(Icons.error),
    );
  }
}
