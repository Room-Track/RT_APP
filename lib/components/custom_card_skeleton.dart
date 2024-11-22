import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:room_track_flutterapp/theme/icon.dart';
import 'package:shimmer/shimmer.dart';

class CustomCardSkeleton extends StatelessWidget {
  const CustomCardSkeleton({
    super.key,
  });

  void _onTap() {}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surfaceDim,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 160,
            height: 140,
            child: Shimmer.fromColors(
              baseColor: theme.colorScheme.secondary,
              highlightColor: theme.colorScheme.secondary.withAlpha(255),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /**
                 * name
                 */
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  /**
                 * Icon
                 */
                  SvgPicture.asset(
                    IconSchemeCard.classroomSVG,
                    width: 60,
                    height: 60,
                    colorFilter: ColorFilter.mode(
                      theme.colorScheme.secondary,
                      BlendMode.srcIn,
                    ),
                  ),
                  /**
                 * type
                 */
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
