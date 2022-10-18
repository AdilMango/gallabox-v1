import 'package:flutter/material.dart';
import 'package:gallabox/core/widgets/shimmer/content_line_enum.dart';
import 'package:gallabox/core/widgets/shimmer/widgets/content_place_holder.dart';
import 'package:gallabox/core/widgets/shimmer/widgets/title_place_holder.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer widget
class ShimmerWidget extends StatelessWidget {
  /// Creates an instance of [ShimmerWidget]
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade50,
      highlightColor: Colors.grey,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: const [
            SizedBox(height: 16),
            ContentPlaceholder(lineType: ContentLineType.threeLines),
            SizedBox(height: 16),
            TitlePlaceholder(width: 200),
            SizedBox(height: 16),
            ContentPlaceholder(lineType: ContentLineType.twoLines),
            SizedBox(height: 16),
            TitlePlaceholder(width: 200),
            SizedBox(height: 16),
            ContentPlaceholder(lineType: ContentLineType.twoLines),
          ],
        ),
      ),
    );
  }
}
