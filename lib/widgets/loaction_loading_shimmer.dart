import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

class LocationLoadingShimmer extends StatelessWidget {
  final int index;

  const LocationLoadingShimmer({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      title: _box(
        width: 200.0,
        height: 12.0,
        color: theme.colorScheme.tertiary,
        highlight: Colors.grey,
      ),
      subtitle: Row(
        children: [
          _box(
            width: 60.0,
            height: 8.0,
            color: theme.colorScheme.tertiary,
            highlight: Colors.grey,
          ),
          const SizedBox(width: 8.0),
          _box(
            width: 20.0,
            height: 8.0,
            color: theme.colorScheme.tertiary,
            highlight: Colors.grey,
          ),
        ],
      ),
      trailing: _box(
        width: 32.0,
        height: 32.0,
        shape: BoxShape.circle,
        color: theme.colorScheme.tertiary,
        highlight: Colors.grey,
        isShimmer: false,
      ),
      tileColor: index % 2 == 0
          ? theme.colorScheme.tertiaryContainer
          : theme.scaffoldBackgroundColor,
      leading: _box(
        width: size.width * 0.15,
        height: size.width * 0.15,
        shape: BoxShape.circle,
        color: theme.colorScheme.tertiary,
        highlight: Colors.grey,
        isShimmer: false,
      ),
    );
  }

  Widget _box({
    required double width,
    required double height,
    required Color color,
    required Color highlight,
    BoxShape shape = BoxShape.rectangle,
    bool isShimmer = true,
  }) =>
      isShimmer
          ? Shimmer.fromColors(
              baseColor: color,
              highlightColor: highlight,
              direction: ShimmerDirection.ltr,
              period: const Duration(seconds: 1),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: color,
                  shape: shape,
                  borderRadius: shape == BoxShape.circle
                      ? null
                      : BorderRadius.circular(4.0),
                ),
              ),
            )
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: color,
                shape: shape,
                borderRadius: shape == BoxShape.circle
                    ? null
                    : BorderRadius.circular(4.0),
              ),
            );
}
