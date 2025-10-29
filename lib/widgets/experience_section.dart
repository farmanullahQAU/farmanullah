import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

class ExperienceSection extends StatefulWidget {
  final List<Experience> experiences;
  final String sectionTitle;

  const ExperienceSection({
    super.key,
    required this.experiences,
    required this.sectionTitle,
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : (screenWidth > 400 ? 24 : 16),
        vertical: isDesktop ? 100 : 80,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.3),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Row(
                children: [
                  Container(
                    width: 4,
                    height: isDesktop ? 50 : 40,
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
                    widget.sectionTitle.toUpperCase(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
              // const SizedBox(height: 48),

              // // Decorative divider below title
              // const SectionDivider(),
              const SizedBox(height: 48),

              // Experience Card Slider
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: isDesktop ? 500 : 450,
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const ClampingScrollPhysics(),
                      itemCount: widget.experiences.length,
                      itemBuilder: (context, index) {
                        return RepaintBoundary(
                          key: ValueKey('experience_$index'),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isDesktop ? 12 : 8,
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
                            padding: const EdgeInsets.all(12),
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
                                  padding: const EdgeInsets.all(12),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                ],
              ),
              // Navigation Dots
              Padding(
                padding: EdgeInsets.only(top: isDesktop ? 32 : 24, bottom: 16),
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
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: _currentPage == index ? 24 : 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? AppConstants.primaryColor
                                : AppConstants.primaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(6),
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
        borderRadius: BorderRadius.circular(20),
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
            padding: EdgeInsets.all(isDesktop ? 32 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.primaryColor.withOpacity(0.15),
                            AppConstants.secondaryColor.withOpacity(0.15),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.business_rounded,
                        color: AppConstants.primaryColor,
                        size: isDesktop ? 28 : 24,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Title and Company
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exp.title,
                            style: TextStyle(
                              fontSize: isDesktop ? 24 : 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exp.company,
                            style: TextStyle(
                              fontSize: isDesktop ? 16 : 14,
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
                        horizontal: isDesktop ? 16 : 12,
                        vertical: isDesktop ? 10 : 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.primaryColor.withOpacity(0.1),
                            AppConstants.secondaryColor.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppConstants.primaryColor.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        exp.period,
                        style: TextStyle(
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: isDesktop ? 13 : 12,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

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

                const SizedBox(height: 20),

                // Responsibilities
                Column(
                  children: exp.responsibilities.take(4).map((responsibility) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6, right: 12),
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
