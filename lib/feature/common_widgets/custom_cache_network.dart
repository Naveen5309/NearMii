import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  final String img;
  final double? size;
  final double? height;
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
                color: backgroundColor ?? AppColor.greenc3e4cc,
                borderRadius: BorderRadius.all(
                  Radius.circular(imageRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SvgPicture.asset(Assets.userDummy),
              ),
            ),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            alignment: Alignment.center,
            child: img.contains(".svg")
                ?

                // ClipRRect(
                //     borderRadius: BorderRadius.circular(15),
                //     child: SvgPicture.asset(
                //       img,
                //       fit: BoxFit.cover,
                //     ),
                //   )

                SvgPicture.network(
                    img,
                    placeholderBuilder: (context) => const Icon(Icons.error),
                    // placeholderBuilder: (context) => const Icon(Icons.error),
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
                      return SizedBox(
                        height: height,
                        width: width,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          );
  }
}
