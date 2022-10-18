import 'package:flutter/material.dart';
import 'package:gallabox/core/widgets/shimmer/content_line_enum.dart';

/// Shimmer content Placeholder widget
class ContentPlaceholder extends StatelessWidget {
  /// Creates an instances of [ContentPlaceholder]
  const ContentPlaceholder({
    super.key,
    required this.lineType,
  });

  /// Enum lineType
  final ContentLineType lineType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                Container(width: 100, height: 10, color: Colors.white)
              ],
            ),
          )
        ],
      ),
    );
  }
}
