import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

/// Reusable section header widget with vertical gradient divider
class SectionHeader extends StatelessWidget {
  final String title;
  final String? description;
  final bool forceUppercase;

  const SectionHeader({
    super.key,
    required this.title,
    this.description,
    this.forceUppercase = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        ),
        if (description != null) ...[
          SizedBox(height: SpacingConstants.spacingMD),
          Padding(
            padding: EdgeInsets.only(
              left:
                  SpacingConstants.sectionHeaderBarWidth +
                  SpacingConstants.sectionHeaderBarSpacing,
            ),
            child: Text(
              description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                fontSize: MediaQuery.of(context).size.width > 768 ? 16 : 14,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
