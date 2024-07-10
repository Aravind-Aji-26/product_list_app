import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../app/utils.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.isAvailable = true,
    this.width,
    this.height,
    this.fit,
  });
  final String imageUrl;
  final bool isAvailable;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      color: isAvailable ? null : Colors.grey,
      colorBlendMode: isAvailable ? null : BlendMode.color,
      placeholder: (context, url) => const SizedBox(),
      imageUrl: appendImageDomain(imageUrl),
      height: height,
      width: width,
      fit: fit,
      errorWidget: (context, url, error) {
        return const Icon(
          Icons.image_not_supported_outlined,
        );
      },
    );
  }
}

class CachedImageProvider extends StatelessWidget {
  const CachedImageProvider(
      {super.key, required this.imageUrl, required this.imageBuilder});
  final String imageUrl;
  final Widget Function(BuildContext, ImageProvider<Object>) imageBuilder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: imageBuilder,
      errorWidget: (context, url, error) {
        return const Icon(
          Icons.image_not_supported_outlined,
        );
      },
      placeholder: (context, url) => const SizedBox(),
    );
  }
}
