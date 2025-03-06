import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:shimmer/shimmer.dart'; // Import the shimmer package

class CustomCacheNetworkImage extends StatelessWidget {
  final String img;
  final double? size;
  final double? height;
  final double? dummyPadding;
  final double? width;
  final Color? backgroundColor;
  final Color? color;
  final double imageRadius;
  final BoxFit? fit;

  const CustomCacheNetworkImage({
    super.key,
    required this.img,
    this.size,
    this.height,
    this.backgroundColor,
    this.width,
    this.dummyPadding,
    this.fit,
    this.color,
    required this.imageRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ((img == '') || (img == '-') || (img.isEmpty))
        ? SizedBox(
            width: width,
            height: height,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.grey[300], // Fallback color
                borderRadius: BorderRadius.all(
                  Radius.circular(imageRadius),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(dummyPadding ?? 15),
                child: SvgPicture.asset(
                    'assets/icons/dummy_user.svg'), // Update with your asset
              ),
            ),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(imageRadius),
            ),
            alignment: Alignment.center,
            child: img.contains(".svg")
                ? SvgPicture.network(
                    img,
                    placeholderBuilder: (context) => const Icon(Icons.error),
                    errorBuilder: (context, error, stackTrace) {
                      return Padding(
                          padding: EdgeInsets.all(dummyPadding ?? 15),
                          child:
                              SvgPicture.asset('assets/icons/dummy_user.svg'));
                    },
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    fit: fit,
                    imageUrl: img,
                    imageBuilder: (context, imageProvider) => Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        color: color ?? Colors.white,
                        borderRadius: BorderRadius.circular(imageRadius),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: fit ?? BoxFit.cover,
                        ),
                      ),
                    ),
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      // Show shimmer while the image is loading
                      return SizedBox(
                        height: height,
                        width: width,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(imageRadius),
                            ),
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      // Only show error when the image failed to load completely
                      return Padding(
                          padding: EdgeInsets.all(dummyPadding ?? 15),
                          child:
                              SvgPicture.asset('assets/icons/dummy_user.svg'));
                    },
                  ),
          );
  }
}
