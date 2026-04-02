import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ServicesSection extends StatefulWidget {
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
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('services-section'),
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
                    title: widget.sectionTitle,
                    description: widget.sectionDescription,
                  ),
                  SizedBox(height: SpacingConstants.sectionHeaderBottomSpacing),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      int columns = width > 900 ? 3 : (width > 600 ? 2 : 1);
                      double spacing = SpacingConstants.getCardSpacing(context);

                      List<Widget> rows = [];
                      for (
                        int i = 0;
                        i < widget.services.length;
                        i += columns
                      ) {
                        List<Widget> rowChildren = [];
                        for (int j = 0; j < columns; j++) {
                          if (i + j < widget.services.length) {
                            rowChildren.add(
                              columns == 1
                                  ? _buildCard(
                                      context,
                                      widget.services[i + j],
                                      width > 768,
                                      isDark,
                                    )
                                  : Expanded(
                                      child: _buildCard(
                                        context,
                                        widget.services[i + j],
                                        width > 768,
                                        isDark,
                                      ),
                                    ),
                            );
                          } else {
                            rowChildren.add(
                              const Expanded(child: SizedBox.shrink()),
                            );
                          }
                          if (j < columns - 1) {
                            rowChildren.add(SizedBox(width: spacing));
                          }
                        }
                        rows.add(
                          columns == 1
                              ? rowChildren[0]
                              : IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: rowChildren,
                                  ),
                                ),
                        );
                        if (i + columns < widget.services.length) {
                          rows.add(SizedBox(height: spacing));
                        }
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: rows,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    Service service,
    bool isDesktop,
    bool isDark,
  ) {
    return RepaintBoundary(
      child: _ServiceCard(
        service: service,
        isDesktop: isDesktop,
        isDark: isDark,
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final Service service;
  final bool isDesktop;
  final bool isDark;

  const _ServiceCard({
    required this.service,
    required this.isDesktop,
    required this.isDark,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        constraints: BoxConstraints(minHeight: widget.isDesktop ? 220 : 180),
        decoration: BoxDecoration(
          color: widget.isDark
              ? (_hovered ? AppConstants.darkSurface : AppConstants.darkCard)
              : (_hovered ? const Color(0xFFECE9FF) : AppConstants.lightCard),
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadius2XL),
          border: Border.all(
            color: _hovered
                ? AppConstants.primaryColor.withValues(alpha: 0.45)
                : AppConstants.primaryColor.withValues(
                    alpha: widget.isDark ? 0.12 : 0.08,
                  ),
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants.primaryColor.withValues(
                alpha: _hovered ? 0.18 : 0.06,
              ),
              blurRadius: _hovered ? 40 : 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: SpacingConstants.getCardPaddingSmall(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.primaryColor.withValues(
                        alpha: _hovered ? 0.22 : 0.15,
                      ),
                      AppConstants.secondaryColor.withValues(
                        alpha: _hovered ? 0.18 : 0.1,
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  widget.service.icon,
                  color: AppConstants.primaryColor,
                  size: widget.isDesktop ? 28 : 24,
                ),
              ),
              SizedBox(height: widget.isDesktop ? 20 : 16),
              Text(
                widget.service.title,
                style: GoogleFonts.inter(
                  fontSize: widget.isDesktop ? 18 : 16,
                  fontWeight: FontWeight.w800,
                  color: widget.isDark
                      ? AppConstants.darkText
                      : AppConstants.lightText,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.service.description,
                style: GoogleFonts.inter(
                  fontSize: widget.isDesktop ? 14 : 13,
                  height: 1.65,
                  color: widget.isDark
                      ? AppConstants.darkTextSecondary
                      : AppConstants.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
