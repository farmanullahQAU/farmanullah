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
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : (screenWidth > 400 ? 24 : 16),
        vertical: isDesktop ? 120 : 80,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        backgroundColor: AppConstants.primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

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
                const SizedBox(height: 24),
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
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 80),

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
                    const SizedBox(width: 32),
                    Expanded(
                      child: _buildContactCard(
                        context,
                        'Phone',
                        Icons.phone_rounded,
                        data.phone,
                      ),
                    ),
                    const SizedBox(width: 32),
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
                    const SizedBox(height: 20),
                    _buildContactCard(
                      context,
                      'Phone',
                      Icons.phone_rounded,
                      data.phone,
                    ),
                    const SizedBox(height: 20),
                    _buildContactCard(
                      context,
                      'Email',
                      Icons.mail_rounded,
                      data.email,
                    ),
                  ],
                ),

              const SizedBox(height: 100),

              // Education Section
              _buildSectionHeader(
                context,
                data.uiContent.sectionTitles['education']!,
              ),
              const SizedBox(height: 40),
              _buildEducationCard(context),

              const SizedBox(height: 100),

              // Experience Section
              _buildSectionHeader(
                context,
                data.uiContent.sectionTitles['experience']!,
              ),
              const SizedBox(height: 40),

              ...List.generate(
                data.experiences.length,
                (i) => Column(
                  children: [
                    _buildExperienceCard(context, data.experiences[i]),
                    if (i < data.experiences.length - 1)
                      const SizedBox(height: 32),
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
        const SizedBox(height: 12),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppConstants.primaryColor, size: 24),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 8),
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
        padding: EdgeInsets.all(isDesktop ? 32 : 24),
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
          children: List.generate(data.education.length, (index) {
            final edu = data.education[index];
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
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
                    SizedBox(width: isDesktop ? 32 : 16),
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
                          SizedBox(height: isDesktop ? 12 : 8),
                          Text(
                            edu.degree,
                            style: TextStyle(
                              fontSize: isDesktop ? 22 : 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: isDesktop ? 8 : 6),
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
                  SizedBox(height: isDesktop ? 24 : 20),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                  ),
                  SizedBox(height: isDesktop ? 24 : 20),
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
        padding: const EdgeInsets.all(32),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
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
            const SizedBox(height: 28),
            Column(
              children: List.generate(
                exp.responsibilities.length,
                (i) => Padding(
                  padding: EdgeInsets.only(
                    bottom: i < exp.responsibilities.length - 1 ? 14 : 0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7, right: 16),
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
