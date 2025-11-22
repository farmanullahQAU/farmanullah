import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/section_header.dart';
import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  final List<Service> services;
  final String sectionTitle;
  final String? sectionDescription;

  const ServicesSection({
    super.key,
    required this.services,
    required this.sectionTitle,
    this.sectionDescription,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: SpacingConstants.getSectionPadding(context),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.3),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: SpacingConstants.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Title
              SectionHeader(
                title: sectionTitle,
                description: sectionDescription,
              ),
              SizedBox(height: SpacingConstants.sectionHeaderBottomSpacing),

              // Services Grid - Same as before but with new card design
              if (isDesktop && services.length >= 6)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[0],
                            isDesktop,
                          ),
                        ),
                        SizedBox(
                          width: SpacingConstants.getCardSpacing(context),
                        ),
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[1],
                            isDesktop,
                          ),
                        ),
                        SizedBox(
                          width: SpacingConstants.getCardSpacing(context),
                        ),
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[2],
                            isDesktop,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SpacingConstants.getCardSpacing(context)),
                    Row(
                      children: [
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[3],
                            isDesktop,
                          ),
                        ),
                        SizedBox(
                          width: SpacingConstants.getCardSpacing(context),
                        ),
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[4],
                            isDesktop,
                          ),
                        ),
                        SizedBox(
                          width: SpacingConstants.getCardSpacing(context),
                        ),
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[5],
                            isDesktop,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else if (isDesktop)
                Wrap(
                  spacing: SpacingConstants.getCardSpacing(context),
                  runSpacing: SpacingConstants.getCardSpacing(context),
                  children: services.map((service) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 128 - 48) / 3,
                      child: _buildExperienceStyleCard(
                        context,
                        service,
                        isDesktop,
                      ),
                    );
                  }).toList(),
                )
              else
                Column(
                  children: services.map((service) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: SpacingConstants.getCardSpacing(context),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: _buildExperienceStyleCard(
                          context,
                          service,
                          isDesktop,
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceStyleCard(
    BuildContext context,
    Service service,
    bool isDesktop,
  ) {
    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: isDesktop ? 200 : 180),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadiusXL),
          border: Border.all(
            color: AppConstants.primaryColor.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants.primaryColor.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(
              SpacingConstants.borderRadiusXL,
            ),
            onTap: () {},
            child: Padding(
              padding: SpacingConstants.getCardPaddingSmall(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon with gradient background
                  Container(
                    padding: EdgeInsets.all(
                      SpacingConstants.iconContainerPadding,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.primaryColor.withValues(alpha: 0.15),
                          AppConstants.secondaryColor.withValues(alpha: 0.15),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        SpacingConstants.borderRadiusLG,
                      ),
                    ),
                    child: Icon(
                      service.icon,
                      color: AppConstants.primaryColor,
                      size: isDesktop ? 32 : 28,
                    ),
                  ),
                  SizedBox(
                    height: isDesktop
                        ? SpacingConstants.spacing2XL
                        : SpacingConstants.spacingXL,
                  ),

                  // Title
                  Text(
                    service.title,
                    style: TextStyle(
                      fontSize: isDesktop ? 20 : 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: SpacingConstants.spacingMD),

                  // Description
                  Text(
                    service.description,
                    style: TextStyle(
                      fontSize: isDesktop ? 15 : 14,
                      height: 1.6,
                      color: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                    maxLines: isDesktop ? null : 4,
                    overflow: isDesktop ? null : TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
