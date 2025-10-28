import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;

  const ExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : (screenWidth > 400 ? 24 : 16),
        vertical: isDesktop ? 100 : 80,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.3),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Row(
                children: [
                  Container(
                    width: 4,
                    height: isDesktop ? 50 : 40,
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
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
                    ).createShader(bounds),
                    child: Text(
                      'Professional Experience',
                      style: TextStyle(
                        fontSize: isDesktop ? 48 : (screenWidth > 400 ? 36 : 32),
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Experience Timeline
              if (isDesktop)
                // Desktop: Timeline with timeline on left
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline
                    SizedBox(
                      width: 80,
                      child: Column(
                        children: List.generate(experiences.length, (index) {
                          final isLast = index == experiences.length - 1;
                          return Column(
                            children: [
                              // Timeline circle
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppConstants.primaryColor,
                                  border: Border.all(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    width: 4,
                                  ),
                                ),
                              ),
                              if (!isLast) ...[
                                const SizedBox(height: 8),
                                Container(
                                  width: 2,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppConstants.primaryColor.withOpacity(0.3),
                                        AppConstants.secondaryColor.withOpacity(0.3),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ],
                          );
                        }),
                      ),
                    ),
                    
                    // Experience Cards
                    const SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        children: List.generate(experiences.length, (index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index < experiences.length - 1 ? 48 : 0,
                            ),
                            child: _buildModernExperienceCard(context, experiences[index], isDesktop),
                          );
                        }),
                      ),
                    ),
                  ],
                )
              else
                // Mobile: Vertical stack with connecting line
                Column(
                  children: List.generate(experiences.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < experiences.length - 1 ? 32 : 0,
                      ),
                      child: _buildModernExperienceCard(context, experiences[index], isDesktop),
                    );
                  }),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernExperienceCard(BuildContext context, Experience exp, bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 32 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.primaryColor.withOpacity(0.15),
                            AppConstants.secondaryColor.withOpacity(0.15),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.business_rounded,
                        color: AppConstants.primaryColor,
                        size: isDesktop ? 28 : 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Title and Company
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exp.title,
                            style: TextStyle(
                              fontSize: isDesktop ? 24 : 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exp.company,
                            style: TextStyle(
                              fontSize: isDesktop ? 16 : 14,
                              color: AppConstants.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Period Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 16 : 12,
                        vertical: isDesktop ? 10 : 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.primaryColor.withOpacity(0.1),
                            AppConstants.secondaryColor.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppConstants.primaryColor.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        exp.period,
                        style: TextStyle(
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: isDesktop ? 13 : 12,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // Divider
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.primaryColor.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Responsibilities
                Column(
                  children: exp.responsibilities.take(4).map((responsibility) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6, right: 12),
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: isDesktop ? 20 : 18,
                              color: AppConstants.primaryColor.withOpacity(0.8),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              responsibility,
                              style: TextStyle(
                                fontSize: isDesktop ? 15 : 14,
                                height: 1.6,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color
                                    ?.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}