import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SocialMediaShimmer extends StatelessWidget {
  const SocialMediaShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns as in the image
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemCount: 19, // Number of placeholders
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 50,
                height: 10,
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
