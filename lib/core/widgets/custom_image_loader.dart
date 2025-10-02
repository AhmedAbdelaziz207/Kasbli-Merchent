import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kasbli_merchant/core/network/api_endpoints.dart';
import 'package:kasbli_merchant/core/widgets/loading_widget.dart';

class CustomImageLoader extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool isNetworkImage; // True for network, false for asset

  const CustomImageLoader({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit,
    this.isNetworkImage = true, // Default to network image
  });

  @override
  Widget build(BuildContext context) {
    if (isNetworkImage) {
      return CachedNetworkImage(
        imageUrl: ApiEndPoints.baseUrl + imagePath,
        width: width,
        height: height,
        fit: fit,
        progressIndicatorBuilder:
            (context, url, downloadProgress) =>
                LoadingWidget(size: LoadingSize.small),
        errorWidget:
            (context, url, error) => SizedBox(
              width: width,
              height: height,
              child: Icon(Icons.broken_image_rounded),
            ),
      );
    } else {
      // For asset images, ensure they are properly added to pubspec.yaml
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300], // Placeholder background on error
            child: const Center(
              child: Icon(
                Icons.broken_image,
                color: Colors.red,
                size: 40,
              ), // Broken image icon
            ),
          );
        },
      );
    }
  }
}
