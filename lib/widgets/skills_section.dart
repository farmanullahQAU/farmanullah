import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SkillsSection extends StatefulWidget {
  final List<Skill> skills;
  final String sectionTitle;
  final String? sectionDescription;

  const SkillsSection({
    super.key,
    required this.skills,
    required this.sectionTitle,
    this.sectionDescription,
  });

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
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
      key: const Key('skills-section'),
      onVisibilityChanged: _onVisible,
      child: FadeTransition(
        opacity: _fadeIn,
        child: Container(
          padding: SpacingConstants.getSectionPadding(context),
          color: isDark ? const Color(0xFF0A0917) : const Color(0xFFF0EEFF),
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
                      int columns = width > 950 ? 3 : (width > 600 ? 2 : 1);
                      double spacing = SpacingConstants.getCardSpacing(context);

                      List<Widget> rows = [];
                      for (int i = 0; i < widget.skills.length; i += columns) {
                        List<Widget> rowChildren = [];
                        for (int j = 0; j < columns; j++) {
                          if (i + j < widget.skills.length) {
                            rowChildren.add(
                              columns == 1
                                  ? _buildSkillCard(
                                      context,
                                      widget.skills[i + j],
                                      isDark,
                                    )
                                  : Expanded(
                                      child: _buildSkillCard(
                                        context,
                                        widget.skills[i + j],
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
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: rowChildren,
                                ),
                        );
                        if (i + columns < widget.skills.length) {
                          rows.add(SizedBox(height: spacing));
                        }
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
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

  Widget _buildSkillCard(BuildContext context, Skill skill, bool isDark) {
    return RepaintBoundary(
      child: Container(
        padding: SpacingConstants.getCardPadding(context),
        decoration: BoxDecoration(
          color: isDark ? AppConstants.darkCard : AppConstants.lightCard,
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadius2XL),
          border: Border.all(
            color: AppConstants.primaryColor.withValues(
              alpha: isDark ? 0.15 : 0.1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants.primaryColor.withValues(
                alpha: isDark ? 0.08 : 0.05,
              ),
              blurRadius: 28,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppConstants.primaryColor.withValues(alpha: 0.15),
                    AppConstants.accentColor.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                skill.category,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppConstants.primaryColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Skills as tags/chips
            LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: skill.items
                      .map(
                        (item) => _buildSkillChip(
                          context,
                          item,
                          isDark,
                          constraints.maxWidth,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(
    BuildContext context,
    String item,
    bool isDark,
    double maxWidth,
  ) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isDark
            ? AppConstants.primaryColor.withValues(alpha: 0.08)
            : AppConstants.primaryColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppConstants.primaryColor.withValues(
            alpha: isDark ? 0.2 : 0.15,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: AppConstants.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              item,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? AppConstants.darkText : AppConstants.lightText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
