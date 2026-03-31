import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ExperienceSection extends StatefulWidget {
  final List<Experience> experiences;
  final String sectionTitle;
  final String? sectionDescription;

  const ExperienceSection({
    super.key,
    required this.experiences,
    required this.sectionTitle,
    this.sectionDescription,
  });

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late AnimationController _animController;
  late Animation<double> _fadeIn;
  bool _animatedIn = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_pageListener);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
  }

  void _pageListener() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage && mounted) setState(() => _currentPage = page);
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
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
      key: const Key('experience-section'),
      onVisibilityChanged: _onVisible,
      child: FadeTransition(
        opacity: _fadeIn,
        child: Container(
          width: double.infinity,
          padding: SpacingConstants.getSectionPadding(context),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0A0917) : const Color(0xFFF0EEFF),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: SpacingConstants.maxContentWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(
                    title: widget.sectionTitle,
                    description: widget.sectionDescription,
                  ),
                  SizedBox(height: SpacingConstants.sectionHeaderBottomSpacing),

                  // Timeline layout for desktop
                  if (isDesktop)
                    _buildTimeline(context, isDark)
                  else
                    _buildMobileSlider(context, isDark),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, bool isDark) {
    return Column(
      children: List.generate(widget.experiences.length, (index) {
        final exp = widget.experiences[index];
        final isLast = index == widget.experiences.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        AppConstants.primaryColor,
                        AppConstants.accentColor,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppConstants.primaryColor.withValues(
                          alpha: 0.35,
                        ),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 32,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppConstants.primaryColor.withValues(alpha: 0.6),
                          AppConstants.primaryColor.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 24),
            // Card
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
                child: _buildExperienceCard(context, exp, true, isDark),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMobileSlider(BuildContext context, bool isDark) {
    return Column(
      children: [
        SizedBox(
          height: 520,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.experiences.length,
            itemBuilder: (context, index) => RepaintBoundary(
              key: ValueKey('exp_$index'),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildExperienceCard(
                  context,
                  widget.experiences[index],
                  false,
                  isDark,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildDots(widget.experiences.length),
      ],
    );
  }

  Widget _buildExperienceCard(
    BuildContext context,
    Experience exp,
    bool isDesktop,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppConstants.darkCard : AppConstants.lightCard,
        borderRadius: BorderRadius.circular(SpacingConstants.borderRadius2XL),
        border: Border.all(
          color: AppConstants.primaryColor.withValues(
            alpha: isDark ? 0.18 : 0.1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withValues(
              alpha: isDark ? 0.12 : 0.06,
            ),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: SpacingConstants.getCardPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(isDesktop ? 12 : 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.primaryColor.withValues(alpha: 0.15),
                          AppConstants.accentColor.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(isDesktop ? 14 : 12),
                    ),
                    child: Icon(
                      Icons.work_outline_rounded,
                      color: AppConstants.primaryColor,
                      size: isDesktop ? 22 : 19,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            exp.title,
                            style: GoogleFonts.inter(
                              fontSize: isDesktop ? 20 : 16.5,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppConstants.darkText
                                  : AppConstants.lightText,
                              letterSpacing: -0.4,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          exp.company,
                          style: GoogleFonts.inter(
                            fontSize: isDesktop ? 14 : 12.5,
                            fontWeight: FontWeight.w700,
                            color: AppConstants.primaryColor,
                            letterSpacing: 0.1,
                          ),
                        ),
                        if (!isDesktop) ...[
                          const SizedBox(height: 10),
                          _buildPeriodBadge(exp.period),
                        ],
                      ],
                    ),
                  ),
                  if (isDesktop) _buildPeriodBadge(exp.period),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.primaryColor.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Responsibilities
              ...exp.responsibilities
                  .take(isDesktop ? 5 : 4)
                  .map(
                    (r) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(top: 6, right: 11),
                            decoration: const BoxDecoration(
                              color: AppConstants.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              r,
                              style: GoogleFonts.inter(
                                fontSize: isDesktop ? 14 : 13,
                                height: 1.65,
                                color: isDark
                                    ? AppConstants.darkTextSecondary
                                    : AppConstants.lightTextSecondary,
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
      ),
    );
  }

  Widget _buildPeriodBadge(String period) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        period,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppConstants.primaryColor,
        ),
      ),
    );
  }

  Widget _buildDots(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = _currentPage == index;
        return GestureDetector(
          onTap: () => _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCubic,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 28 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? AppConstants.primaryColor
                  : AppConstants.primaryColor.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
