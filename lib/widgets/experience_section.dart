import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/gradient_icon_container.dart';
import 'package:farmanullah/widgets/section_header.dart';
import 'package:flutter/material.dart';

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

class _ExperienceSectionState extends State<ExperienceSection> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage && mounted) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      width: double.infinity,
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
              // Title Section
              SectionHeader(
                title: widget.sectionTitle,
                description: widget.sectionDescription,
              ),
              SizedBox(height: SpacingConstants.sectionHeaderBottomSpacing),

              // Experience Card Slider
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: isDesktop ? 500 : 500,
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const ClampingScrollPhysics(),
                      itemCount: widget.experiences.length,
                      itemBuilder: (context, index) {
                        return RepaintBoundary(
                          key: ValueKey('experience_$index'),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isDesktop
                                  ? SpacingConstants.spacingMD
                                  : SpacingConstants.spacingSM,
                            ),
                            child: _buildModernExperienceCard(
                              context,
                              widget.experiences[index],
                              isDesktop,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Left Navigation Button
                  if (isDesktop)
                    Positioned(
                      left: -20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.chevron_left,
                              color: AppConstants.primaryColor,
                              size: 32,
                            ),
                            onPressed: () {
                              if (_currentPage > 0) {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            iconSize: 32,
                            padding: EdgeInsets.all(SpacingConstants.spacingMD),
                          ),
                        ),
                      ),
                    ),
                  // Right Navigation Button
                  if (isDesktop)
                    Positioned(
                      right: -20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: _currentPage < widget.experiences.length - 1
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: AppConstants.primaryColor,
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  iconSize: 32,
                                  padding: EdgeInsets.all(
                                    SpacingConstants.spacingMD,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                ],
              ),
              // Navigation Dots
              Padding(
                padding: EdgeInsets.only(
                  top: isDesktop
                      ? SpacingConstants.spacing3XL
                      : SpacingConstants.spacing2XL,
                  bottom: SpacingConstants.spacingLG,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.experiences.length,
                      (index) => GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(
                            horizontal: SpacingConstants.spacingXS + 2,
                          ),
                          width: _currentPage == index
                              ? SpacingConstants.spacing2XL
                              : SpacingConstants.spacingMD,
                          height: SpacingConstants.spacingMD,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? AppConstants.primaryColor
                                : AppConstants.primaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(
                              SpacingConstants.spacingXS + 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernExperienceCard(
    BuildContext context,
    Experience exp,
    bool isDesktop,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(SpacingConstants.borderRadiusXL),
        // border: Border.all(
        //   color: AppConstants.primaryColor.withOpacity(0.1),
        //   width: 1.5,
        // ),
        // boxShadow: [
        //   BoxShadow(
        //     color: AppConstants.primaryColor.withOpacity(0.08),
        //     blurRadius: 24,
        //     offset: const Offset(0, 8),
        //   ),
        // ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          child: Padding(
            padding: SpacingConstants.getCardPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section - Responsive layout
                if (isDesktop)
                  // Desktop: Icon, Title/Company, Period in one row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon
                      GradientIconContainer(
                        icon: Icons.business_rounded,
                        iconSize: 28,
                        padding: EdgeInsets.all(SpacingConstants.spacingMD),
                        borderRadius: SpacingConstants.spacingMD,
                      ),
                      SizedBox(width: SpacingConstants.spacingLG),

                      // Title and Company
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exp.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              exp.company,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppConstants.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Period Badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: SpacingConstants.spacingLG,
                          vertical: SpacingConstants.spacingXL - 2,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppConstants.primaryColor.withOpacity(0.1),
                              AppConstants.secondaryColor.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(
                            SpacingConstants.spacingXL - 2,
                          ),
                          border: Border.all(
                            color: AppConstants.primaryColor.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          exp.period,
                          style: TextStyle(
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  // Mobile: Stacked layout to prevent overflow
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon and Title row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GradientIconContainer(
                            icon: Icons.business_rounded,
                            iconSize: 20,
                            padding: EdgeInsets.all(SpacingConstants.spacingMD),
                            borderRadius: SpacingConstants.spacingMD,
                          ),
                          SizedBox(width: SpacingConstants.spacingMD),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exp.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  exp.company,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppConstants.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SpacingConstants.spacingMD),
                      // Period Badge on mobile - full width
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: SpacingConstants.spacingMD,
                          vertical: SpacingConstants.spacingSM + 2,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppConstants.primaryColor.withOpacity(0.1),
                              AppConstants.secondaryColor.withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(
                            SpacingConstants.spacingMD,
                          ),
                          border: Border.all(
                            color: AppConstants.primaryColor.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          exp.period,
                          style: TextStyle(
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            letterSpacing: 0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: SpacingConstants.spacing2XL),

                // Divider
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.primaryColor.withOpacity(0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                SizedBox(height: SpacingConstants.spacingXL),

                // Responsibilities
                Column(
                  children: exp.responsibilities.take(4).map((responsibility) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: SpacingConstants.spacingMD,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: SpacingConstants.spacingXS + 2,
                              right: SpacingConstants.spacingMD,
                            ),
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: isDesktop ? 20 : 18,
                              color: AppConstants.primaryColor.withOpacity(0.8),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              responsibility,
                              style: TextStyle(
                                fontSize: isDesktop ? 15 : 14,
                                height: 1.6,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color?.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
