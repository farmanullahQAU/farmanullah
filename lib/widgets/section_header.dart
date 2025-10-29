import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

/// Reusable section header widget with vertical gradient divider
class SectionHeader extends StatelessWidget {
  final String title;
  final bool forceUppercase;

  const SectionHeader({
    super.key,
    required this.title,
    this.forceUppercase = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: SpacingConstants.sectionHeaderBarWidth,
          height: SpacingConstants.getSectionHeaderBarHeight(context),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppConstants.primaryColor, AppConstants.accentColor],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: SpacingConstants.sectionHeaderBarSpacing),
        Text(
          forceUppercase ? title.toUpperCase() : title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }
}
