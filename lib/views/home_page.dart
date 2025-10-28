import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/widgets/contact_section.dart';
import 'package:farmanullah/widgets/experience_section.dart';
import 'package:farmanullah/widgets/home_section.dart';
import 'package:farmanullah/widgets/nav_bar.dart';
import 'package:farmanullah/widgets/portfolio_section.dart';
import 'package:farmanullah/widgets/section_divider.dart';
import 'package:farmanullah/widgets/services_section.dart';
import 'package:farmanullah/widgets/skills_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final PortfolioData _portfolioData = PortfolioData.getData();
  String _currentSection = 'home';

  // GlobalKeys for each section to enable scroll-to functionality
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key, String section) async {
    setState(() {
      _currentSection = section;
    });

    // Small delay to ensure the state is updated
    await Future.delayed(const Duration(milliseconds: 50));

    if (!mounted) return;
    final context = key.currentContext;
    if (context != null) {
      // Use CustomScrollView's scroll controller for smooth scrolling
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.05, // Small offset from top
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateCurrentSection);
  }

  void _updateCurrentSection() {
    // Simple logic to update current section based on scroll position
    // This is a basic implementation - can be enhanced with IntersectionObserver-like logic
    if (_scrollController.hasClients) {
      final offset = _scrollController.offset;
      // Update based on approximate positions
      if (offset < 300) {
        if (_currentSection != 'home') {
          setState(() {
            _currentSection = 'home';
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    final isTablet = screenWidth > 600 && !isDesktop;

    // Calculate responsive navbar height based on content
    // Adjusted to match actual navbar content height
    final navbarHeight = isDesktop
        ? 64.0
        : isTablet
        ? 60.0
        : 58.0;

    // Allow mobile menu to expand
    final maxNavbarHeight = isDesktop ? 64.0 : 400.0;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(), // Smooth scrolling
            slivers: [
              SliverToBoxAdapter(
                child: NavBar(
                  key: ValueKey(_currentSection),
                  currentSection: _currentSection,
                  onHome: () => _scrollToSection(_homeKey, 'home'),
                  onExperience: () =>
                      _scrollToSection(_experienceKey, 'experience'),
                  onServices: () => _scrollToSection(_servicesKey, 'services'),
                  onPortfolio: () =>
                      _scrollToSection(_portfolioKey, 'portfolio'),
                  onContact: () => _scrollToSection(_contactKey, 'contact'),
                ),
              ),

              // Sticky Navigation Bar
              // SliverPersistentHeader(
              //   pinned: true,
              //   delegate: StickyNavBarDelegate(
              //     height: navbarHeight,
              //     maxHeight: maxNavbarHeight,
              //     child: NavBar(
              //       key: ValueKey(_currentSection),
              //       currentSection: _currentSection,
              //       onHome: () => _scrollToSection(_homeKey, 'home'),
              //       onExperience: () =>
              //           _scrollToSection(_experienceKey, 'experience'),
              //       onServices: () => _scrollToSection(_servicesKey, 'services'),
              //       onPortfolio: () => _scrollToSection(_portfolioKey, 'portfolio'),
              //       onContact: () => _scrollToSection(_contactKey, 'contact'),
              //     ),
              //   ),
              // ),
              SliverToBoxAdapter(
                key: _homeKey,
                child: HomeSection(data: _portfolioData),
              ),
              const SliverToBoxAdapter(child: SectionDivider()),
              SliverToBoxAdapter(
                key: _experienceKey,
                child: ExperienceSection(
                  experiences: _portfolioData.experiences,
                ),
              ),
              const SliverToBoxAdapter(child: SectionDivider()),
              SliverToBoxAdapter(key: _servicesKey, child: ServicesSection()),
              const SliverToBoxAdapter(child: SectionDivider()),
              SliverToBoxAdapter(
                key: _skillsKey,
                child: SkillsSection(skills: _portfolioData.skills),
              ),
              const SliverToBoxAdapter(child: SectionDivider()),
              SliverToBoxAdapter(
                key: _portfolioKey,
                child: PortfolioSection(projects: _portfolioData.projects),
              ),
              const SliverToBoxAdapter(child: SectionDivider()),
              SliverToBoxAdapter(
                key: _contactKey,
                child: ContactSection(
                  email: _portfolioData.email,
                  phone: _portfolioData.phone,
                  linkedIn: _portfolioData.linkedIn,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  color: Theme.of(context).cardColor.withOpacity(0.3),
                  child: Center(
                    child: Text(
                      '© 2024 Farman Ullah. All rights reserved.',
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          NavBar(
            key: ValueKey(_currentSection),
            currentSection: _currentSection,
            onHome: () => _scrollToSection(_homeKey, 'home'),
            onExperience: () => _scrollToSection(_experienceKey, 'experience'),
            onServices: () => _scrollToSection(_servicesKey, 'services'),
            onPortfolio: () => _scrollToSection(_portfolioKey, 'portfolio'),
            onContact: () => _scrollToSection(_contactKey, 'contact'),
          ),
        ],
      ),
    );
  }
}
