import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;
  final String sectionTitle;

  const SkillsSection({
    super.key,
    required this.skills,
    required this.sectionTitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : (screenWidth > 400 ? 24 : 16),
        vertical: isDesktop ? 80 : 60,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.3),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.primaryColor,
                          AppConstants.secondaryColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    sectionTitle.toUpperCase(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
              // const SizedBox(height: 48),
              // HeaderDivider(isDesktop: isDesktop),
              const SizedBox(height: 48),
              if (isDesktop && skills.length >= 3)
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: _buildSkillCard(context, skills[0])),
                      const SizedBox(width: 24),
                      Expanded(child: _buildSkillCard(context, skills[1])),
                      const SizedBox(width: 24),
                      Expanded(child: _buildSkillCard(context, skills[2])),
                    ],
                  ),
                )
              else
                Column(
                  children: skills.map((skill) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
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
            const SizedBox(height: 16),
            ...skill.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
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
