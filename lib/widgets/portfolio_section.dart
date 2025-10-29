import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/project_image_carousel.dart';
import 'package:farmanullah/widgets/store_badges.dart';
import 'package:flutter/material.dart';

class PortfolioSection extends StatefulWidget {
  final List<Project> projects;
  final String sectionTitle;

  const PortfolioSection({
    super.key,
    required this.projects,
    required this.sectionTitle,
  });

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
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
    if (page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 32 : 24,
        horizontal: isDesktop ? 0 : 16,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isDesktop ? 24 : 8),
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
                      widget.sectionTitle.toUpperCase(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48),
              // HeaderDivider(isDesktop: isDesktop),
              // SizedBox(height: isDesktop ? 48 : 32),
              Stack(
                clipBehavior: Clip.none,

                children: [
                  SizedBox(
                    height: isDesktop
                        ? 680
                        : (MediaQuery.of(context).size.height * 0.65),
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const ClampingScrollPhysics(),
                      itemCount: widget.projects.length,
                      itemBuilder: (context, index) {
                        return RepaintBoundary(
                          key: ValueKey('project_$index'),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isDesktop ? 12 : 8,
                            ),
                            child: _buildProjectCard(
                              context,
                              widget.projects[index],
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
                        child: _currentPage > 0
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
                                    Icons.chevron_left,
                                    color: AppConstants.primaryColor,
                                    size: 32,
                                  ),
                                  onPressed: () {
                                    _pageController.previousPage(
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
                  // Right Navigation Button
                  if (isDesktop)
                    Positioned(
                      right: -20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: _currentPage < widget.projects.length - 1
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
                      widget.projects.length,
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

  Widget _buildProjectCard(
    BuildContext context,
    Project project,
    bool isDesktop,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Project Images - Compact for horizontal scroll
          Expanded(
            child: ProjectImageCarousel(
              images: project.images,
              showPreviewGrid: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isDesktop ? 24 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  style: TextStyle(
                    fontSize: isDesktop ? 20 : 18,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: isDesktop ? 12 : 8),
                Text(
                  project.description,
                  maxLines: isDesktop ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isDesktop ? 14 : 13,
                    height: 1.4,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.8),
                  ),
                ),
                if (project.technologies.isNotEmpty) ...[
                  SizedBox(height: isDesktop ? 16 : 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: project.technologies.take(5).map((tech) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 10 : 8,
                          vertical: isDesktop ? 5 : 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tech,
                          style: TextStyle(
                            fontSize: isDesktop ? 11 : 10,
                            color: AppConstants.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                // Store Badges
                if (project.playStoreUrl != null) ...[
                  SizedBox(height: isDesktop ? 16 : 12),
                  StoreBadges(playStoreUrl: project.playStoreUrl),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
