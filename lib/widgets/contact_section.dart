import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  final PortfolioData data;

  const ContactSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final screenWidth = MediaQuery.of(context).size.width;

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
              // Modern Hero Text
              _buildHeroText(context, isDesktop, screenWidth),
              SizedBox(height: SpacingConstants.spacingMD),

              // Subtitle
              Text(
                data.uiContent.contactSubtitle.toUpperCase(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: SpacingConstants.sectionHeaderBottomSpacing),

              // Contact Cards Grid
              if (isDesktop)
                Row(
                  children: [
                    Expanded(
                      child: _buildModernContactCard(
                        context,
                        'Email',
                        Icons.email_outlined,
                        data.email,
                        data.email,
                        () => _launchEmail(data.email),
                      ),
                    ),
                    SizedBox(width: SpacingConstants.getCardSpacing(context)),
                    Expanded(
                      child: _buildModernContactCard(
                        context,
                        'Phone',
                        Icons.phone_outlined,
                        data.phone,
                        data.phone,
                        () => _launchPhone(data.phone),
                      ),
                    ),
                    SizedBox(width: SpacingConstants.getCardSpacing(context)),
                    Expanded(
                      child: _buildModernContactCard(
                        context,
                        'LinkedIn',
                        Icons.account_circle_outlined,
                        data.linkedIn,
                        'Connect on LinkedIn',
                        () => _launchLinkedIn(data.linkedIn),
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildModernContactCard(
                      context,
                      'Email',
                      Icons.email_outlined,
                      data.email,
                      data.email,
                      () => _launchEmail(data.email),
                    ),
                    SizedBox(height: SpacingConstants.spacingXL),
                    _buildModernContactCard(
                      context,
                      'Phone',
                      Icons.phone_outlined,
                      data.phone,
                      data.phone,
                      () => _launchPhone(data.phone),
                    ),
                    SizedBox(height: SpacingConstants.spacingXL),
                    _buildModernContactCard(
                      context,
                      'LinkedIn',
                      Icons.account_circle_outlined,
                      data.linkedIn,
                      'Connect on LinkedIn',
                      () => _launchLinkedIn(data.linkedIn),
                    ),
                  ],
                ),

              SizedBox(
                height: isDesktop
                    ? SpacingConstants.spacing6XL
                    : SpacingConstants.sectionHeaderBottomSpacing,
              ),

              // CTA Button
              _buildCTAButton(context, isDesktop, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroText(
    BuildContext context,
    bool isDesktop,
    double screenWidth,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: SpacingConstants.sectionHeaderBarWidth,
              height: SpacingConstants.getSectionHeaderBarHeight(context),
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
            SizedBox(width: SpacingConstants.sectionHeaderBarSpacing),
            Text(
              data.uiContent.sectionTitles['contact']!.toUpperCase(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModernContactCard(
    BuildContext context,
    String title,
    IconData icon,
    String label,
    String value,
    VoidCallback onTap,
  ) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return RepaintBoundary(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadius2XL),
          child: Container(
            padding: SpacingConstants.getCardPaddingSmall(context),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(
                SpacingConstants.borderRadius2XL,
              ),
              border: Border.all(
                color: AppConstants.primaryColor.withOpacity(0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.primaryColor.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon with gradient background
                Container(
                  padding: EdgeInsets.all(
                    SpacingConstants.iconContainerPadding,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.primaryColor.withOpacity(0.15),
                        AppConstants.secondaryColor.withOpacity(0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(
                      SpacingConstants.borderRadiusLG,
                    ),
                  ),
                  child: Icon(
                    icon,
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
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.primaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: SpacingConstants.spacingSM),

                // Value
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : 16,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: SpacingConstants.spacingLG),

                // Action indicator
                Row(
                  children: [
                    Text(
                      'Click to ${title.toLowerCase()}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: SpacingConstants.spacingSM),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCTAButton(
    BuildContext context,
    bool isDesktop,
    double screenWidth,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _launchEmail(data.email),
        borderRadius: BorderRadius.circular(SpacingConstants.borderRadiusLG),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop
                ? SpacingConstants.spacing5XL
                : SpacingConstants.spacing3XL,
            vertical: isDesktop
                ? SpacingConstants.spacingXL
                : SpacingConstants.spacingXL - 2,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
            ),
            borderRadius: BorderRadius.circular(
              SpacingConstants.borderRadiusLG,
            ),
            boxShadow: [
              BoxShadow(
                color: AppConstants.primaryColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: isDesktop
                    ? SpacingConstants.spacing2XL
                    : SpacingConstants.spacingXL + 2,
              ),
              SizedBox(width: SpacingConstants.spacingMD),
              Text(
                data.uiContent.contactCTA,
                style: TextStyle(
                  fontSize: isDesktop ? 18 : 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Project Inquiry&body=Hello Farman,',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchLinkedIn(String username) async {
    final Uri linkedInUri = Uri.parse('https://www.linkedin.com/in/$username');

    if (await canLaunchUrl(linkedInUri)) {
      await launchUrl(linkedInUri, mode: LaunchMode.externalApplication);
    }
  }
}
