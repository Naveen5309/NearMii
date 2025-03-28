import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SocialMediaShimmer extends StatelessWidget {
  const SocialMediaShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Container with Shimmer Border
        _buildShimmerContainer(),

        const SizedBox(height: 20), // Space between containers

        // Second Container with Shimmer Border
        _buildShimmerContainer(),
      ],
    );
  }

  Widget _buildShimmerContainer() {
    Color baseShimmerColor = Colors.grey[300]!;
    Color highlightShimmerColor = Colors.grey[100]!;

    return Stack(
      children: [
        // Normal Grid Container
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 5, // Border width increased
              color: Colors.white, // Placeholder, shimmer will overlay
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              15.verticalSpace,
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Shimmer.fromColors(
                      baseColor: baseShimmerColor,
                      highlightColor: highlightShimmerColor,
                      child: Container(
                        width: 120,
                        height: 18,
                        decoration: BoxDecoration(
                          color: AppColor.whiteFFFFFF,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )),
                ),
              ),
              // 10.verticalSpace,
              GridView.builder(
                padding: const EdgeInsets.only(top: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.1,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: baseShimmerColor,
                    highlightColor: highlightShimmerColor,
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
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Shimmer Border Overlay
        Positioned.fill(
          child: IgnorePointer(
            ignoring: true, // Ensures shimmer doesn't block user interactions
            child: Shimmer.fromColors(
              baseColor: baseShimmerColor,
              highlightColor: highlightShimmerColor,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 5, // Border shimmer width increased
                    color: Colors.white, // Shimmer Effect
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
