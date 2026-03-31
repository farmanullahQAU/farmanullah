import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/project_image_carousel.dart';
import 'package:farmanullah/widgets/section_header.dart';
import 'package:farmanullah/widgets/store_badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PortfolioSection extends StatefulWidget {
  final List<Project> projects;
  final String sectionTitle;
  final String? sectionDescription;

  const PortfolioSection({
    super.key,
    required this.projects,
    required this.sectionTitle,
    this.sectionDescription,
  });

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection>
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
      key: const Key('portfolio-section'),
      onVisibilityChanged: _onVisible,
      child: FadeTransition(
        opacity: _fadeIn,
        child: Container(
          padding: SpacingConstants.getPortfolioPadding(context),
          color: isDark ? const Color(0xFF0A0917) : const Color(0xFFF0EEFF),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: SpacingConstants.maxContentWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop
                          ? 0
                          : SpacingConstants
                                .sectionPaddingHorizontalMobileSmall,
                    ),
                    child: SectionHeader(
                      title: widget.sectionTitle,
                      description: widget.sectionDescription,
                    ),
                  ),
                  SizedBox(height: SpacingConstants.sectionHeaderBottomSpacing),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: isDesktop
                            ? 660
                            : (MediaQuery.of(context).size.height * 0.65),
                        child: PageView.builder(
                          controller: _pageController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: widget.projects.length,
                          itemBuilder: (context, index) => RepaintBoundary(
                            key: ValueKey('project_$index'),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              child: _buildProjectCard(
                                context,
                                widget.projects[index],
                                isDesktop,
                                isDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Arrow nav (desktop)
                      if (isDesktop) ...[
                        _buildNavBtn(context, isLeft: true),
                        _buildNavBtn(context, isLeft: false),
                      ],
                    ],
                  ),
                  const SizedBox(height: 28),
                  _buildDots(widget.projects.length),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBtn(BuildContext context, {required bool isLeft}) {
    final canGo = isLeft
        ? _currentPage > 0
        : _currentPage < widget.projects.length - 1;
    if (!canGo) return const SizedBox.shrink();

    return Positioned(
      left: isLeft ? -22 : null,
      right: isLeft ? null : -22,
      top: 0,
      bottom: 0,
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (isLeft) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOutCubic,
              );
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOutCubic,
              );
            }
          },
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppConstants.primaryColor, AppConstants.accentColor],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppConstants.primaryColor.withValues(alpha: 0.38),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              isLeft ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    Project project,
    bool isDesktop,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppConstants.darkCard : AppConstants.lightCard,
        borderRadius: BorderRadius.circular(SpacingConstants.borderRadius2XL),
        border: Border.all(
          color: AppConstants.primaryColor.withValues(alpha: isDark ? 0.15 : 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withValues(alpha: isDark ? 0.1 : 0.06),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              child: ProjectImageCarousel(
                images: project.images,
                showPreviewGrid: false,
              ),
            ),
          ),
          Padding(
            padding: SpacingConstants.getCardPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  style: GoogleFonts.inter(
                    fontSize: isDesktop ? 20 : 17,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? AppConstants.darkText
                        : AppConstants.lightText,
                    letterSpacing: -0.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  maxLines: isDesktop ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: isDesktop ? 14 : 13,
                    height: 1.55,
                    color: isDark
                        ? AppConstants.darkTextSecondary
                        : AppConstants.lightTextSecondary,
                  ),
                ),
                if (project.technologies.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: project.technologies.take(5).map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppConstants.primaryColor.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          tech,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                if (project.playStoreUrl != null) ...[
                  const SizedBox(height: 12),
                  StoreBadges(playStoreUrl: project.playStoreUrl),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots(int count) {
    return Center(
      child: Row(
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
      ),
    );
  }
}
