import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class ImageLoadingService extends StatelessWidget {
  final BorderRadius? borderRadius;
  final String imageUrl;
  const ImageLoadingService(
      {Key? key, required this.imageUrl, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
    );
    if (borderRadius == null) {
      return image;
    } else {
      return ClipRRect(
        borderRadius: borderRadius,
        child: image,
      );
    }
  }
}
