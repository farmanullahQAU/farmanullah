import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/section_header.dart';
import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;
  final String sectionTitle;
  final String? sectionDescription;

  const SkillsSection({
    super.key,
    required this.skills,
    required this.sectionTitle,
    this.sectionDescription,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: SpacingConstants.getSectionPadding(context),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.3),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: SpacingConstants.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: sectionTitle,
                description: sectionDescription,
              ),
              SizedBox(height: SpacingConstants.sectionHeaderBottomSpacing),
              if (isDesktop && skills.length >= 3)
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _buildSkillCard(context, skills[0])),
                      SizedBox(width: SpacingConstants.getCardSpacing(context)),
                      Expanded(child: _buildSkillCard(context, skills[1])),
                      SizedBox(width: SpacingConstants.getCardSpacing(context)),
                      Expanded(child: _buildSkillCard(context, skills[2])),
                    ],
                  ),
                )
              else
                Column(
                  children: skills.map((skill) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: SpacingConstants.getCardSpacing(context),
                      ),
                      child: _buildSkillCard(context, skill),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, Skill skill) {
    return RepaintBoundary(
      child: Container(
        padding: SpacingConstants.getCardPadding(context),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadiusLG),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SpacingConstants.spacingMD,
                vertical: SpacingConstants.spacingXS + 2,
              ),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  SpacingConstants.borderRadiusSM,
                ),
              ),
              child: Text(
                skill.category,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.primaryColor,
                ),
              ),
            ),
            SizedBox(height: SpacingConstants.spacingLG),
            ...skill.items.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: SpacingConstants.spacingSM),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: SpacingConstants.spacingLG,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: SpacingConstants.spacingMD),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
