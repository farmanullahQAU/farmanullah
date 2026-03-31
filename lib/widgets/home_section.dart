import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeSection extends StatefulWidget {
  final PortfolioData data;

  const HomeSection({super.key, required this.data});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.01 && !_visible && mounted) {
      setState(() => _visible = true);
      _controller.forward();
    }
  }

  Future<void> _downloadCV() async {
    final url = Uri.parse(widget.data.cvUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchLinkedIn() async {
    final uri = Uri.parse(
      'https://www.linkedin.com/in/${widget.data.linkedIn}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('home-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Container(
        width: double.infinity,
        padding: SpacingConstants.getHomePadding(context),
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF07060F),
                    Color(0xFF120D26),
                    Color(0xFF07060F),
                  ],
                )
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF5F4FF),
                    Color(0xFFECE9FF),
                    Color(0xFFF5F4FF),
                  ],
                ),
        ),
        child: Stack(
          children: [
            // Decorative blobs
            if (isDark) ...[
              Positioned(
                top: -100,
                right: -100,
                child: _buildBlob(
                  400,
                  AppConstants.primaryColor.withValues(alpha: 0.08),
                ),
              ),
              Positioned(
                bottom: -60,
                left: -80,
                child: _buildBlob(
                  300,
                  AppConstants.neonAccent.withValues(alpha: 0.04),
                ),
              ),
            ] else ...[
              Positioned(
                top: -80,
                right: -80,
                child: _buildBlob(
                  350,
                  AppConstants.primaryColor.withValues(alpha: 0.06),
                ),
              ),
            ],
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: SpacingConstants.maxContentWidth,
                ),
                child: FadeTransition(
                  opacity: _fadeIn,
                  child: SlideTransition(
                    position: _slideUp,
                    child: isDesktop
                        ? _buildDesktopLayout(context, isDark)
                        : _buildMobileLayout(context, screenWidth, isDark),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingBadge(),
              const SizedBox(height: 20),
              _buildNameDesktop(context),
              const SizedBox(height: 16),
              _buildTitleRow(context, true),
              const SizedBox(height: 24),
              _buildBio(context, true),
              const SizedBox(height: 40),
              _buildButtons(context, true),
              const SizedBox(height: 48),
              _buildEducationCard(context, true),
            ],
          ),
        ),
        const SizedBox(width: 80),
        Flexible(flex: 2, child: _buildProfileImage(context, 380, isDark)),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    double screenWidth,
    bool isDark,
  ) {
    final imgSize = screenWidth > 400 ? 180.0 : 140.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileImage(context, imgSize, isDark),
        const SizedBox(height: 28),
        _buildGreetingBadge(center: true),
        const SizedBox(height: 14),
        _buildNameMobile(context, screenWidth),
        const SizedBox(height: 12),
        _buildTitleRow(context, false, center: true),
        const SizedBox(height: 16),
        _buildBio(context, false),
        const SizedBox(height: 32),
        _buildButtons(context, false),
        const SizedBox(height: 36),
        _buildEducationCard(context, false),
      ],
    );
  }

  Widget _buildGreetingBadge({bool center = false}) {
    return Row(
      mainAxisAlignment: center
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
              color: AppConstants.primaryColor.withValues(alpha: 0.35),
            ),
            gradient: LinearGradient(
              colors: [
                AppConstants.primaryColor.withValues(alpha: 0.1),
                AppConstants.accentColor.withValues(alpha: 0.06),
              ],
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppConstants.neonAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available for hire',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.accentColor,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNameDesktop(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter',
          style: GoogleFonts.inter(
            fontSize: 80,
            fontWeight: FontWeight.w900,
            height: 1.0,
            color: isDark ? AppConstants.darkText : AppConstants.lightText,
            letterSpacing: -3,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppConstants.primaryColor,
              AppConstants.accentColor,
              AppConstants.neonAccent,
            ],
          ).createShader(bounds),
          child: Text(
            'Developer',
            style: GoogleFonts.inter(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              height: 1.0,
              color: Colors.white,
              letterSpacing: -3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameMobile(BuildContext context, double screenWidth) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = screenWidth > 400 ? 48.0 : 38.0;
    return Column(
      children: [
        Text(
          'Flutter',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: size,
            fontWeight: FontWeight.w900,
            height: 1.0,
            color: isDark ? AppConstants.darkText : AppConstants.lightText,
            letterSpacing: -1.5,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppConstants.primaryColor, AppConstants.accentColor],
          ).createShader(bounds),
          child: Text(
            'Developer',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: size,
              fontWeight: FontWeight.w900,
              height: 1.0,
              color: Colors.white,
              letterSpacing: -1.5,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.data.name,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppConstants.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTitleRow(
    BuildContext context,
    bool isDesktop, {
    bool center = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (!isDesktop) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: center
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Text(
          widget.data.name,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: isDark
                ? AppConstants.darkTextSecondary
                : AppConstants.lightTextSecondary,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: AppConstants.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '4+ Years Experience',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppConstants.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBio(BuildContext context, bool isDesktop) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(
      widget.data.bio,
      textAlign: isDesktop ? TextAlign.start : TextAlign.center,
      maxLines: isDesktop ? null : 5,
      overflow: isDesktop ? null : TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        fontSize: isDesktop ? 16 : 14,
        height: 1.75,
        color: isDark
            ? AppConstants.darkTextSecondary
            : AppConstants.lightTextSecondary,
      ),
    );
  }

  Widget _buildButtons(BuildContext context, bool isDesktop) {
    return Wrap(
      alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
      spacing: 16,
      runSpacing: 16,
      children: [
        GradientButton(
          label: 'Download CV',
          icon: Icons.download_rounded,
          onPressed: _downloadCV,
        ),
        GradientButton(
          label: 'LinkedIn',
          icon: Icons.open_in_new_rounded,
          isOutlined: true,
          onPressed: _launchLinkedIn,
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, double size, bool isDark) {
    return RepaintBoundary(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Glow ring
            Container(
              width: size + 30,
              height: size + 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppConstants.primaryColor.withValues(alpha: isDark ? 0.25 : 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Border ring
            Container(
              width: size + 8,
              height: size + 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppConstants.primaryColor, AppConstants.neonAccent],
                ),
              ),
            ),
            // Image
            Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                  widget.data.profileImagePath,
                  fit: BoxFit.cover,
                  cacheWidth: (size * 2).toInt(),
                  cacheHeight: (size * 2).toInt(),
                  errorBuilder: (_, __, ___) => Container(
                    color: AppConstants.primaryColor.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person_rounded,
                      size: size * 0.5,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationCard(BuildContext context, bool isDesktop) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        padding: SpacingConstants.getCardPadding(context),
        decoration: BoxDecoration(
          color: isDark ? AppConstants.darkCard : AppConstants.lightCard,
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadius2XL),
          border: Border.all(
            color: AppConstants.primaryColor.withValues(alpha: isDark ? 0.15 : 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants.primaryColor.withValues(alpha: 
                isDark ? 0.08 : 0.06,
              ),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Education',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: AppConstants.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(widget.data.education.length, (index) {
              final edu = widget.data.education[index];
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppConstants.primaryColor.withValues(alpha: 0.15),
                              AppConstants.accentColor.withValues(alpha: 0.15),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          size: 18,
                          color: AppConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              edu.degree,
                              style: GoogleFonts.inter(
                                fontSize: isDesktop ? 15 : 14,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppConstants.darkText
                                    : AppConstants.lightText,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              edu.institution,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: isDark
                                    ? AppConstants.darkTextSecondary
                                    : AppConstants.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          edu.period,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppConstants.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (index < widget.data.education.length - 1) ...[
                    const SizedBox(height: 16),
                    Divider(
                      height: 1,
                      color: AppConstants.primaryColor.withValues(alpha: 0.1),
                    ),
                    const SizedBox(height: 16),
                  ],
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
