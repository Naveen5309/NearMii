// import 'dart:io';

// import 'package:NearMii/config/helper.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class CommonImageWidget extends StatelessWidget {
//   final String img;
//   final double? height;
//   final double? width;
//   final Color? borderColor, svgColorFilter;
//   final double? imageRadius;
//   final bool? isLocalFile;
//   final Widget? errorWidget;
//   final BoxFit? fit;
//   final double? borderWidth;

//   const CommonImageWidget({
//     super.key,
//     required this.img,
//     this.height,
//     this.width,
//     this.errorWidget,
//     this.isLocalFile = false,
//     this.fit,
//     this.borderColor,
//     this.svgColorFilter,
//     this.imageRadius,
//     this.borderWidth,
//   });

//   /// Counts the occurrences of 'https' in the given URL.
//   int countHttpsOccurrences(String url) {
//     return RegExp('https').allMatches(url).length;
//   }

//   /// Extracts the last word before the file extension from the URL.
//   String extractLastWord(String url) {
//     String lastPart = url.split('/').last;
//     return lastPart.split('.').first;
//   }

//   /// Builds a fallback widget for invalid images.
//   Widget _buildFallbackImage() {
//     return errorWidget ??
//         SizedBox(
//           height: height,
//           width: width,
//           child: CircleAvatar(
//             radius: imageRadius,
//             backgroundColor: AppColor.transparent,
//             backgroundImage: AssetImage(""),
//           ),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLocalFile ?? false) {
//       return ClipRRect(
//         borderRadius: (imageRadius ?? 10).circularBorder,
//         child: SizedBox(
//             height: height,
//             width: width,
//             child: Image.file(
//               File(img),
//               frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
//                 if (frame != null) {
//                   return child;
//                 }

//                 return const Center(child: Text("Loading..."));
//               },
//               height: height,
//               width: width,
//               fit: BoxFit.cover,
//             )),
//       );
//     }

//     if (img.contains(".svg") && img.contains("assets/")) {
//       return SvgPicture.asset(
//         img,
//         height: height,
//         width: width,
//         colorFilter: svgColorFilter != null
//             ? ColorFilter.mode(
//                 svgColorFilter ?? AppColor.black, BlendMode.srcIn)
//             : null,
//       );
//     }

//     // Case 1: Local asset image
//     if (img.contains("assets/") && (!img.isURL)) {
//       return SizedBox(
//           height: height,
//           width: width,
//           child: Image.asset(
//             img,
//             fit: fit,
//           )
//           // CircleAvatar(
//           //   radius: imageRadius,
//           //   backgroundColor: AppColor.transparent,
//           //   backgroundImage: AssetImage(img),
//           // ),
//           );
//     }

//     // Case 2: Invalid URLs with multiple 'https' or missing meaningful content
//     if (countHttpsOccurrences(img) > 1 ||
//         extractLastWord(img).isEmpty ||
//         extractLastWord(img) == "null") {
//       return _buildFallbackImage();
//     }

//     // Case 3: Empty or placeholder values for the image URL
//     if (img.isEmpty || img == '-' || img == '') {
//       return _buildFallbackImage();
//     }

//     // Case 4: SVG or cached network images
//     return Container(
//       width: width,
//       height: height,
//       alignment: Alignment.center,
//       child: img.contains(".svg")
//           ? SvgPicture.network(
//               img,
//               placeholderBuilder: (context) =>
//                   Image.asset(AppImages.imgDefaultUser),
//             )
//           : CachedNetworkImage(
//               imageUrl: img,
//               imageBuilder: (context, imageProvider) => Container(
//                 height: height,
//                 width: width,
//                 decoration: BoxDecoration(
//                   borderRadius: imageRadius != null
//                       ? BorderRadius.circular(imageRadius!)
//                       : null,
//                   border: Border.all(
//                       color: borderColor ?? AppColor.transparent,
//                       width: borderWidth ?? 0),
//                   image: DecorationImage(
//                     image: imageProvider,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               progressIndicatorBuilder: (context, url, downloadProgress) =>
//                   SizedBox(
//                 height: height,
//                 width: width,
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     value: downloadProgress.progress,
//                     color: AppColor.kPrimaryColor,
//                   ),
//                 ),
//               ),
//               errorWidget: (context, url, error) => ClipRRect(
//                 borderRadius: BorderRadius.circular(imageRadius ?? 10),
//                 child: errorWidget ?? Image.asset(AppImages.imgErrorDefault),
//               ),
//             ),
//     );
//   }
// }
