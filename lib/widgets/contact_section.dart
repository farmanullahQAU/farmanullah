import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  final String email;
  final String phone;
  final String linkedIn;

  const ContactSection({
    super.key,
    required this.email,
    required this.phone,
    required this.linkedIn,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : (screenWidth > 400 ? 24 : 16),
        vertical: isDesktop ? 100 : 80,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Modern Hero Text
              _buildHeroText(context, isDesktop, screenWidth),
              const SizedBox(height: 12),

              // Subtitle
              Text(
                'Ready to bring your ideas to life?\nLet\'s create something amazing together.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: isDesktop ? 20 : (screenWidth > 400 ? 18 : 16),
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  height: 1.6,

                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: isDesktop ? 60 : 48),

              // Contact Cards Grid
              if (isDesktop)
                Row(
                  children: [
                    Expanded(
                      child: _buildModernContactCard(
                        context,
                        'Email',
                        Icons.email_outlined,
                        email,
                        'farmanullahk437@gmail.com',
                        () => _launchEmail(email),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildModernContactCard(
                        context,
                        'Phone',
                        Icons.phone_outlined,
                        phone,
                        '+92 304 9575366',
                        () => _launchPhone(phone),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildModernContactCard(
                        context,
                        'LinkedIn',
                        Icons.account_circle_outlined,
                        linkedIn,
                        'Connect on LinkedIn',
                        () => _launchLinkedIn(linkedIn),
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
                      email,
                      'farmanullahk437@gmail.com',
                      () => _launchEmail(email),
                    ),
                    const SizedBox(height: 20),
                    _buildModernContactCard(
                      context,
                      'Phone',
                      Icons.phone_outlined,
                      phone,
                      '+92 304 9575366',
                      () => _launchPhone(phone),
                    ),
                    const SizedBox(height: 20),
                    _buildModernContactCard(
                      context,
                      'LinkedIn',
                      Icons.account_circle_outlined,
                      linkedIn,
                      'Connect on LinkedIn',
                      () => _launchLinkedIn(linkedIn),
                    ),
                  ],
                ),

              SizedBox(height: isDesktop ? 60 : 48),

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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 8),
          child: Row(
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
                'Get in touch',
                style: TextStyle(
                  fontSize: isDesktop ? 42 : 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: EdgeInsets.all(isDesktop ? 32 : 28),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(24),
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
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.primaryColor.withOpacity(0.15),
                      AppConstants.secondaryColor.withOpacity(0.15),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: AppConstants.primaryColor,
                  size: isDesktop ? 32 : 28,
                ),
              ),
              SizedBox(height: isDesktop ? 24 : 20),

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
              const SizedBox(height: 8),

              // Value
              Text(
                value,
                style: TextStyle(
                  fontSize: isDesktop ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),

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
                  const SizedBox(width: 8),
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
        onTap: () => _launchEmail(email),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 32,
            vertical: isDesktop ? 20 : 18,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
            ),
            borderRadius: BorderRadius.circular(16),
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
                size: isDesktop ? 24 : 22,
              ),
              const SizedBox(width: 12),
              Text(
                'Let\'s Start a Project',
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
