import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/widgets/contact_section.dart';
import 'package:farmanullah/widgets/experience_section.dart';
import 'package:farmanullah/widgets/header_divider.dart';
import 'package:farmanullah/widgets/home_section.dart';
import 'package:farmanullah/widgets/nav_bar.dart';
import 'package:farmanullah/widgets/portfolio_section.dart';
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
  late final PortfolioData _portfolioData;
  String _currentSection = 'home';
  DateTime _lastScrollUpdate = DateTime.now();
  bool _isProgrammaticScroll = false;

  // GlobalKeys for each section to enable scroll-to functionality
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key, String section) async {
    if (_currentSection == section) return;

    // Disable scroll listener during programmatic scroll
    _isProgrammaticScroll = true;
    setState(() {
      _currentSection = section;
    });

    // Small delay to ensure the state is updated
    await Future.delayed(const Duration(milliseconds: 50));

    if (!mounted) {
      _isProgrammaticScroll = false;
      return;
    }
    final context = key.currentContext;
    if (context != null) {
      // Use CustomScrollView's scroll controller for smooth scrolling
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.05, // Small offset from top
      );

      // Wait a bit more to ensure scroll completes
      await Future.delayed(const Duration(milliseconds: 200));
    }

    // Re-enable scroll listener after scroll completes
    if (mounted) {
      _isProgrammaticScroll = false;
    }
  }

  @override
  void initState() {
    super.initState();
    // Load portfolio data asynchronously to not block UI
    _portfolioData = PortfolioData.getData();
    _scrollController.addListener(_updateCurrentSection);
  }

  void _updateCurrentSection() {
    // Ignore updates during programmatic scrolling
    if (_isProgrammaticScroll) return;

    // Throttle updates to every 100ms for better performance
    final now = DateTime.now();
    if (now.difference(_lastScrollUpdate).inMilliseconds < 100) return;
    _lastScrollUpdate = now;

    if (!_scrollController.hasClients || !mounted) return;

    // Use actual section positions instead of hardcoded offsets
    final offset = _scrollController.offset;
    String? newSection = _detectCurrentSection(offset);

    if (newSection != null && newSection != _currentSection) {
      setState(() {
        _currentSection = newSection;
      });
    }
  }

  String? _detectCurrentSection(double offset) {
    // Detect current section based on scroll offset
    if (offset < 300) {
      return 'home';
    } else if (offset < 1500) {
      return 'experience';
    } else if (offset < 2500) {
      return 'services';
    } else if (offset < 3200) {
      return 'skills';
    } else if (offset < 4500) {
      return 'portfolio';
    } else {
      return 'contact';
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            cacheExtent: 500,
            slivers: [
              SliverToBoxAdapter(
                child: NavBar(
                  key: ValueKey(_currentSection),
                  data: _portfolioData,
                  currentSection: _currentSection,
                  onHome: () => _scrollToSection(_homeKey, 'home'),
                  onExperience: () =>
                      _scrollToSection(_experienceKey, 'experience'),
                  onServices: () => _scrollToSection(_servicesKey, 'services'),
                  onSkills: () => _scrollToSection(_skillsKey, 'skills'),
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
              const SliverToBoxAdapter(child: HeaderDivider()),
              SliverToBoxAdapter(
                key: _experienceKey,
                child: ExperienceSection(
                  experiences: _portfolioData.experiences,
                  sectionTitle:
                      _portfolioData.uiContent.sectionTitles['experience']!,
                  sectionDescription: _portfolioData
                      .uiContent
                      .sectionDescriptions['experience'],
                ),
              ),
              const SliverToBoxAdapter(child: HeaderDivider()),
              SliverToBoxAdapter(
                key: _servicesKey,
                child: ServicesSection(
                  services: _portfolioData.services,
                  sectionTitle:
                      _portfolioData.uiContent.sectionTitles['services']!,
                  sectionDescription:
                      _portfolioData.uiContent.sectionDescriptions['services'],
                ),
              ),
              // const SliverToBoxAdapter(child: SectionDivider()),
              const SliverToBoxAdapter(child: HeaderDivider()),

              SliverToBoxAdapter(
                key: _skillsKey,
                child: SkillsSection(
                  skills: _portfolioData.skills,
                  sectionTitle:
                      _portfolioData.uiContent.sectionTitles['skills']!,
                  sectionDescription:
                      _portfolioData.uiContent.sectionDescriptions['skills'],
                ),
              ),
              const SliverToBoxAdapter(child: HeaderDivider()),

              SliverToBoxAdapter(
                key: _portfolioKey,
                child: PortfolioSection(
                  projects: _portfolioData.projects,
                  sectionTitle:
                      _portfolioData.uiContent.sectionTitles['portfolio']!,
                  sectionDescription:
                      _portfolioData.uiContent.sectionDescriptions['portfolio'],
                ),
              ),
              const SliverToBoxAdapter(child: HeaderDivider()),

              SliverToBoxAdapter(
                key: _contactKey,
                child: ContactSection(data: _portfolioData),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  color: Theme.of(context).cardColor.withOpacity(0.3),
                  child: Center(
                    child: Text(
                      _portfolioData.uiContent.footerText,
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
            data: _portfolioData,
            currentSection: _currentSection,
            onHome: () => _scrollToSection(_homeKey, 'home'),
            onExperience: () => _scrollToSection(_experienceKey, 'experience'),
            onServices: () => _scrollToSection(_servicesKey, 'services'),
            onSkills: () => _scrollToSection(_skillsKey, 'skills'),
            onPortfolio: () => _scrollToSection(_portfolioKey, 'portfolio'),
            onContact: () => _scrollToSection(_contactKey, 'contact'),
          ),
        ],
      ),
    );
  }
}
