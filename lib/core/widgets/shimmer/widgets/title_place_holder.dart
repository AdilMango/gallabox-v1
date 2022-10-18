import 'package:flutter/material.dart';

/// Shimmer title Placeholder widget
class TitlePlaceholder extends StatelessWidget {
  /// Creates an instances of [TitlePlaceholder]
  const TitlePlaceholder({
    super.key,
    required this.width,
  });

  /// width
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: width, height: 12, color: Colors.white),
          const SizedBox(height: 8),
          Container(width: width, height: 12, color: Colors.white),
        ],
      ),
    );
  }
}
