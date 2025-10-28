import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;

  const ExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 40,
        vertical: isDesktop ? 100 : 80,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.3),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: isDesktop ? 40 : 32,
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
                    'Professional Experience',
                    style: TextStyle(
                      fontSize: isDesktop ? 42 : 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Desktop: Display in 2x2 grid, Mobile: stacked
              if (isDesktop && experiences.length >= 2)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildExperienceCard(context, experiences[0]),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildExperienceCard(context, experiences[1]),
                        ),
                      ],
                    ),
                    if (experiences.length > 2) ...[
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: _buildExperienceCard(
                              context,
                              experiences[2],
                            ),
                          ),
                          if (experiences.length > 3) ...[
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildExperienceCard(
                                context,
                                experiences[3],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                )
              else
                Column(
                  children: experiences.map((exp) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: experiences.last == exp ? 0 : 24,
                      ),
                      child: _buildExperienceCard(context, exp),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context, Experience exp) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      exp.company,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppConstants.primaryColor.withOpacity(0.2),
                  ),
                ),
                child: Text(
                  exp.period,
                  style: const TextStyle(
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Show only first 3 responsibilities for card view
          ...exp.responsibilities.map(
            (resp) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7, right: 10),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      resp,
                      style: TextStyle(
                        height: 1.6,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withOpacity(0.8),
                        letterSpacing: 0.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // if (exp.responsibilities.length > 3)
          //   Padding(
          //     padding: const EdgeInsets.only(top: 4),
          //     child: Text(
          //       '+${exp.responsibilities.length - 3} more',
          //       style: TextStyle(
          //         fontSize: 13,
          //         color: AppConstants.primaryColor,
          //         fontWeight: FontWeight.w600,
          //         fontStyle: FontStyle.italic,
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
