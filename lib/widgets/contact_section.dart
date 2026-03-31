import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/gradient_button.dart';
import 'package:farmanullah/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactSection extends StatefulWidget {
  final PortfolioData data;

  const ContactSection({super.key, required this.data});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeIn;
  bool _animatedIn = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onVisible(VisibilityInfo info) {
    if (info.visibleFraction > 0.01 && !_animatedIn && mounted) {
      setState(() => _animatedIn = true);
      _animController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('contact-section'),
      onVisibilityChanged: _onVisible,
      child: FadeTransition(
        opacity: _fadeIn,
        child: Container(
          padding: SpacingConstants.getSectionPadding(context),
          color: isDark ? AppConstants.darkBackground : const Color(0xFFF5F4FF),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: SpacingConstants.maxContentWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: widget.data.uiContent.sectionTitles['contact']!,
                    description:
                        widget.data.uiContent.sectionDescriptions['contact'],
                  ),
                  SizedBox(height: SpacingConstants.sectionHeaderBottomSpacing),

                  if (isDesktop)
                    Row(
                      children: [
                        Expanded(
                          child: _buildContactCard(
                            context,
                            'Email',
                            Icons.email_rounded,
                            widget.data.email,
                            () => _launchEmail(widget.data.email),
                            isDark,
                          ),
                        ),
                        SizedBox(
                          width: SpacingConstants.getCardSpacing(context),
                        ),
                        Expanded(
                          child: _buildContactCard(
                            context,
                            'Phone',
                            Icons.phone_rounded,
                            widget.data.phone,
                            () => _launchPhone(widget.data.phone),
                            isDark,
                          ),
                        ),
                        SizedBox(
                          width: SpacingConstants.getCardSpacing(context),
                        ),
                        Expanded(
                          child: _buildContactCard(
                            context,
                            'LinkedIn',
                            Icons.connecting_airports_rounded,
                            'Connect on LinkedIn',
                            () => _launchLinkedIn(widget.data.linkedIn),
                            isDark,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        _buildContactCard(
                          context,
                          'Email',
                          Icons.email_rounded,
                          widget.data.email,
                          () => _launchEmail(widget.data.email),
                          isDark,
                        ),
                        SizedBox(
                          height: SpacingConstants.getCardSpacing(context),
                        ),
                        _buildContactCard(
                          context,
                          'Phone',
                          Icons.phone_rounded,
                          widget.data.phone,
                          () => _launchPhone(widget.data.phone),
                          isDark,
                        ),
                        SizedBox(
                          height: SpacingConstants.getCardSpacing(context),
                        ),
                        _buildContactCard(
                          context,
                          'LinkedIn',
                          Icons.connecting_airports_rounded,
                          'Connect on LinkedIn',
                          () => _launchLinkedIn(widget.data.linkedIn),
                          isDark,
                        ),
                      ],
                    ),

                  SizedBox(
                    height: isDesktop
                        ? SpacingConstants.spacing6XL
                        : SpacingConstants.spacing4XL,
                  ),

                  // CTA
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Ready to build something amazing?',
                          style: GoogleFonts.inter(
                            fontSize: isDesktop ? 28 : 22,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppConstants.darkText
                                : AppConstants.lightText,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.data.uiContent.contactSubtitle.replaceAll(
                            '\n',
                            ' ',
                          ),
                          style: GoogleFonts.inter(
                            fontSize: isDesktop ? 16 : 14,
                            color: isDark
                                ? AppConstants.darkTextSecondary
                                : AppConstants.lightTextSecondary,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        GradientButton(
                          label: "Let's Start a Project",
                          icon: Icons.rocket_launch_rounded,
                          onPressed: () => _launchEmail(widget.data.email),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String title,
    IconData icon,
    String value,
    VoidCallback onTap,
    bool isDark,
  ) {
    return RepaintBoundary(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadius2XL),
          child: Container(
            padding: SpacingConstants.getCardPaddingSmall(context),
            decoration: BoxDecoration(
              color: isDark ? AppConstants.darkCard : AppConstants.lightCard,
              borderRadius: BorderRadius.circular(
                SpacingConstants.borderRadius2XL,
              ),
              border: Border.all(
                color: AppConstants.primaryColor.withValues(alpha: 
                  isDark ? 0.15 : 0.1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.primaryColor.withValues(alpha: 
                    isDark ? 0.08 : 0.05,
                  ),
                  blurRadius: 28,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.primaryColor.withValues(alpha: 0.15),
                        AppConstants.accentColor.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppConstants.primaryColor, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        value,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppConstants.darkText
                              : AppConstants.lightText,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: value));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$title copied!',
                          style: GoogleFonts.inter(),
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: AppConstants.primaryColor,
                      ),
                    );
                  },
                  child: Icon(
                    Icons.copy_rounded,
                    size: 16,
                    color: AppConstants.primaryColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Project Inquiry&body=Hello Farman,',
    );
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone.replaceAll(' ', ''));
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchLinkedIn(String username) async {
    final uri = Uri.parse('https://www.linkedin.com/in/$username');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
