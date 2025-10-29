import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  final PortfolioData data;

  const AboutSection({super.key, required this.data});

  Future<void> _downloadCV(BuildContext context) async {
    final url = Uri.parse(data.cvUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open CV link')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      width: double.infinity,
      padding: SpacingConstants.getAboutPadding(context),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: SpacingConstants.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildSectionHeader(
                      context,
                      data.uiContent.sectionTitles['about']!,
                    ),
                  ),
                  // CV Download Button
                  if (isDesktop)
                    ElevatedButton.icon(
                      onPressed: () => _downloadCV(context),
                      icon: const Icon(Icons.download_rounded, size: 20),
                      label: Text(
                        data.uiContent.buttonLabels['downloadCVShort']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: SpacingConstants.spacing2XL,
                          vertical: SpacingConstants.spacingLG,
                        ),
                        backgroundColor: AppConstants.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            SpacingConstants.spacingMD,
                          ),
                        ),
                        elevation: 0,
                      ),
                    ),
                ],
              ),
              SizedBox(height: SpacingConstants.spacingXL),

              // Professional Bio
              SizedBox(
                width: isDesktop ? 600 : double.infinity,
                child: Text(
                  data.uiContent.aboutDescription,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.8,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ),

              // Mobile CV Button
              if (!isDesktop) ...[
                SizedBox(height: SpacingConstants.spacing2XL),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _downloadCV(context),
                    icon: const Icon(Icons.download_rounded, size: 20),
                    label: Text(
                      data.uiContent.buttonLabels['downloadCV']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: SpacingConstants.spacingXL - 2,
                      ),
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SpacingConstants.spacingMD,
                        ),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],

              SizedBox(height: SpacingConstants.spacing7XL),

              // Contact Info Grid
              if (isDesktop)
                Row(
                  children: [
                    Expanded(
                      child: _buildContactCard(
                        context,
                        'Location',
                        Icons.location_on_rounded,
                        data.location,
                      ),
                    ),
                    SizedBox(width: SpacingConstants.getCardSpacing(context)),
                    Expanded(
                      child: _buildContactCard(
                        context,
                        'Phone',
                        Icons.phone_rounded,
                        data.phone,
                      ),
                    ),
                    SizedBox(width: SpacingConstants.getCardSpacing(context)),
                    Expanded(
                      child: _buildContactCard(
                        context,
                        'Email',
                        Icons.mail_rounded,
                        data.email,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildContactCard(
                      context,
                      'Location',
                      Icons.location_on_rounded,
                      data.location,
                    ),
                    SizedBox(height: SpacingConstants.spacingXL),
                    _buildContactCard(
                      context,
                      'Phone',
                      Icons.phone_rounded,
                      data.phone,
                    ),
                    SizedBox(height: SpacingConstants.spacingXL),
                    _buildContactCard(
                      context,
                      'Email',
                      Icons.mail_rounded,
                      data.email,
                    ),
                  ],
                ),

              SizedBox(height: SpacingConstants.spacing8XL),

              // Education Section
              _buildSectionHeader(
                context,
                data.uiContent.sectionTitles['education']!,
              ),
              SizedBox(height: SpacingConstants.spacing4XL),
              _buildEducationCard(context),

              SizedBox(height: SpacingConstants.spacing8XL),

              // Experience Section
              _buildSectionHeader(
                context,
                data.uiContent.sectionTitles['experience']!,
              ),
              SizedBox(height: SpacingConstants.spacing4XL),

              ...List.generate(
                data.experiences.length,
                (i) => Column(
                  children: [
                    _buildExperienceCard(context, data.experiences[i]),
                    if (i < data.experiences.length - 1)
                      SizedBox(height: SpacingConstants.spacing3XL),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isDesktop ? 48 : (screenWidth > 400 ? 36 : 32),
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: SpacingConstants.spacingMD),
        Container(
          height: 4,
          width: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String title,
    IconData icon,
    String value,
  ) {
    return Container(
      padding: EdgeInsets.all(SpacingConstants.cardPaddingDesktop),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(SpacingConstants.borderRadiusLG),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(SpacingConstants.iconContainerPaddingSmall),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(
                SpacingConstants.spacingXL - 2,
              ),
            ),
            child: Icon(icon, color: AppConstants.primaryColor, size: 24),
          ),
          SizedBox(height: SpacingConstants.spacingLG),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.5),
              letterSpacing: 1,
              textBaseline: TextBaseline.ideographic,
            ),
          ),
          SizedBox(height: SpacingConstants.spacingSM),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    return RepaintBoundary(
      child: Container(
        padding: SpacingConstants.getCardPadding(context),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadiusLG),
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
          children: List.generate(data.education.length, (index) {
            final edu = data.education[index];
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: SpacingConstants.sectionHeaderBarWidth,
                      height: isDesktop ? 80 : 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppConstants.primaryColor,
                            AppConstants.secondaryColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(
                      width: isDesktop
                          ? SpacingConstants.spacing3XL
                          : SpacingConstants.spacingLG,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            edu.period,
                            style: TextStyle(
                              color: AppConstants.primaryColor,
                              fontWeight: FontWeight.w800,
                              fontSize: isDesktop ? 12 : 11,
                              letterSpacing: 0.8,
                            ),
                          ),
                          SizedBox(
                            height: isDesktop
                                ? SpacingConstants.spacingMD
                                : SpacingConstants.spacingSM,
                          ),
                          Text(
                            edu.degree,
                            style: TextStyle(
                              fontSize: isDesktop ? 22 : 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(
                            height: isDesktop
                                ? SpacingConstants.spacingSM
                                : SpacingConstants.spacingXS,
                          ),
                          Text(
                            edu.institution,
                            style: TextStyle(
                              fontSize: isDesktop ? 15 : 14,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (index < data.education.length - 1) ...[
                  SizedBox(
                    height: isDesktop
                        ? SpacingConstants.spacing2XL
                        : SpacingConstants.spacingXL,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                  ),
                  SizedBox(
                    height: isDesktop
                        ? SpacingConstants.spacing2XL
                        : SpacingConstants.spacingXL,
                  ),
                ],
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context, Experience exp) {
    return RepaintBoundary(
      child: Container(
        padding: SpacingConstants.getCardPadding(context),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadiusLG),
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
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        exp.company,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SpacingConstants.spacingLG,
                    vertical: SpacingConstants.spacingXL - 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(
                      SpacingConstants.spacingXL - 2,
                    ),
                    border: Border.all(
                      color: AppConstants.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    exp.period,
                    style: const TextStyle(
                      color: AppConstants.primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SpacingConstants.spacing3XL - SpacingConstants.spacingXS,
            ),
            Column(
              children: List.generate(
                exp.responsibilities.length,
                (i) => Padding(
                  padding: EdgeInsets.only(
                    bottom: i < exp.responsibilities.length - 1
                        ? SpacingConstants.spacingMD +
                              SpacingConstants.spacingXS
                        : 0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 7,
                          right: SpacingConstants.spacingLG,
                        ),
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppConstants.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          exp.responsibilities[i],
                          style: TextStyle(
                            height: 1.7,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.8),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
