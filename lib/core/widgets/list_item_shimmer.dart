import 'package:flutter/material.dart';
import 'package:gallabox/core/widgets/shimmer.dart';

/// Widget used for a list shimmer effect
class ListItemShimmer extends StatelessWidget {
  /// Creates a new instance of [ListItemShimmer]
  const ListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Shimmer(height: 15),
          const SizedBox(height: 20),
          Shimmer(
            height: 15,
            width: MediaQuery.of(context).size.width * 0.4,
          ),
        ],
      ),
    );
  }
}
