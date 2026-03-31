import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:farmanullah/widgets/contact_section.dart';
import 'package:farmanullah/widgets/header_divider.dart';
import 'package:farmanullah/widgets/home_section.dart';
import 'package:farmanullah/widgets/nav_bar.dart';

// ─── Deferred imports ────────────────────────────────────────────────────────
// These sections load AFTER the first frame, so the home screen paints fast.
// The JS/WASM for these widgets is split into separate chunks by the compiler.
import 'package:farmanullah/widgets/experience_section.dart' deferred as exp;
import 'package:farmanullah/widgets/services_section.dart' deferred as svc;
import 'package:farmanullah/widgets/skills_section.dart' deferred as skl;
import 'package:farmanullah/widgets/portfolio_section.dart' deferred as port;
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late final PortfolioData _portfolioData;
  String _currentSection = AppConstants.home;
  bool _isProgrammaticScroll = false;
  DateTime _lastScrollUpdate = DateTime.now();

  // Deferred section readiness flags
  bool _expLoaded = false;
  bool _svcLoaded = false;
  bool _sklLoaded = false;
  bool _portLoaded = false;

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _portfolioData = PortfolioData.getData();
    _scrollController.addListener(_updateCurrentSection);

    // Load deferred chunks in the background immediately after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDeferredLibraries();
    });
  }

  /// Load all deferred section libraries in sequence so the heaviest
  /// code (portfolio images) doesn't compete with engine initialization.
  Future<void> _loadDeferredLibraries() async {
    // Load experience first — it's above the fold after scrolling
    await exp.loadLibrary();
    if (mounted) setState(() => _expLoaded = true);

    // Load services & skills next
    await Future.wait([svc.loadLibrary(), skl.loadLibrary()]);
    if (mounted) {
      setState(() {
        _svcLoaded = true;
        _sklLoaded = true;
      });
    }

    // Portfolio last — heaviest (lots of images)
    await port.loadLibrary();
    if (mounted) setState(() => _portLoaded = true);
  }

  Future<void> _scrollToSection(GlobalKey key, String section) async {
    if (_currentSection == section) return;
    _isProgrammaticScroll = true;
    if (mounted) setState(() => _currentSection = section);
    await Future.delayed(const Duration(milliseconds: 50));
    if (!mounted) {
      _isProgrammaticScroll = false;
      return;
    }
    final ctx = key.currentContext;
    if (ctx != null && ctx.mounted) {
      await Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
      await Future.delayed(const Duration(milliseconds: 250));
    }
    if (mounted) _isProgrammaticScroll = false;
  }

  void _updateCurrentSection() {
    if (_isProgrammaticScroll) return;
    final now = DateTime.now();
    if (now.difference(_lastScrollUpdate).inMilliseconds < 120) return;
    _lastScrollUpdate = now;
    if (!_scrollController.hasClients || !mounted) return;

    final offset = _scrollController.offset;
    final newSection = _detectCurrentSection(offset);
    if (newSection != null && newSection != _currentSection) {
      setState(() => _currentSection = newSection);
    }
  }

  String? _detectCurrentSection(double offset) {
    if (offset < 350) return AppConstants.home;
    if (offset < 1600) return AppConstants.experience;
    if (offset < 2800) return AppConstants.services;
    if (offset < 3600) return AppConstants.skills;
    if (offset < 5200) return AppConstants.portfolio;
    return AppConstants.contact;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            cacheExtent: 600,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 72)),

              // ── Home section: always present, no deferred ──────────────────
              SliverToBoxAdapter(
                key: _homeKey,
                child: HomeSection(data: _portfolioData),
              ),
              const SliverToBoxAdapter(child: HeaderDivider()),

              // ── Experience: deferred, shows shimmer until loaded ───────────
              SliverToBoxAdapter(
                key: _experienceKey,
                child: _expLoaded
                    ? exp.ExperienceSection(
                        experiences: _portfolioData.experiences,
                        sectionTitle: _portfolioData
                            .uiContent
                            .sectionTitles['experience']!,
                        sectionDescription: _portfolioData
                            .uiContent
                            .sectionDescriptions['experience'],
                      )
                    : _buildSectionPlaceholder(isDark, 500),
              ),
              const SliverToBoxAdapter(child: HeaderDivider()),

              // ── Services: deferred ─────────────────────────────────────────
              SliverToBoxAdapter(
                key: _servicesKey,
                child: _svcLoaded
                    ? svc.ServicesSection(
                        services: _portfolioData.services,
                        sectionTitle:
                            _portfolioData.uiContent.sectionTitles['services']!,
                        sectionDescription: _portfolioData
                            .uiContent
                            .sectionDescriptions['services'],
                      )
                    : _buildSectionPlaceholder(isDark, 500),
              ),
              const SliverToBoxAdapter(child: HeaderDivider()),

              // ── Skills: deferred ───────────────────────────────────────────
              SliverToBoxAdapter(
                key: _skillsKey,
                child: _sklLoaded
                    ? skl.SkillsSection(
                        skills: _portfolioData.skills,
                        sectionTitle:
                            _portfolioData.uiContent.sectionTitles['skills']!,
                        sectionDescription: _portfolioData
                            .uiContent
                            .sectionDescriptions['skills'],
                      )
                    : _buildSectionPlaceholder(isDark, 380),
              ),
              const SliverToBoxAdapter(child: HeaderDivider()),

              // ── Portfolio: last to load, heaviest section ──────────────────
              SliverToBoxAdapter(
                key: _portfolioKey,
                child: _portLoaded
                    ? port.PortfolioSection(
                        projects: _portfolioData.projects,
                        sectionTitle: _portfolioData
                            .uiContent
                            .sectionTitles['portfolio']!,
                        sectionDescription: _portfolioData
                            .uiContent
                            .sectionDescriptions['portfolio'],
                      )
                    : _buildSectionPlaceholder(isDark, 700),
              ),
              const SliverToBoxAdapter(child: HeaderDivider()),

              // ── Contact: not deferred, lightweight ─────────────────────────
              SliverToBoxAdapter(
                key: _contactKey,
                child: ContactSection(data: _portfolioData),
              ),

              // Footer
              SliverToBoxAdapter(child: _buildFooter(isDark)),
            ],
          ),

          // Sticky glassmorphism NavBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              data: _portfolioData,
              currentSection: _currentSection,
              onHome: () => _scrollToSection(_homeKey, AppConstants.home),
              onExperience: () =>
                  _scrollToSection(_experienceKey, AppConstants.experience),
              onServices: () =>
                  _scrollToSection(_servicesKey, AppConstants.services),
              onSkills: () => _scrollToSection(_skillsKey, AppConstants.skills),
              onPortfolio: () =>
                  _scrollToSection(_portfolioKey, AppConstants.portfolio),
              onContact: () =>
                  _scrollToSection(_contactKey, AppConstants.contact),
            ),
          ),
        ],
      ),
    );
  }

  /// Shimmer placeholder shown while a deferred section is loading.
  Widget _buildSectionPlaceholder(bool isDark, double height) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 100),
      color: isDark ? AppConstants.darkBackground : const Color(0xFFF5F4FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBar(isDark, width: 120, height: 14),
          const SizedBox(height: 12),
          _shimmerBar(isDark, width: 260, height: 32),
          const SizedBox(height: 48),
          _shimmerBar(isDark, width: double.infinity, height: 20),
          const SizedBox(height: 12),
          _shimmerBar(isDark, width: double.infinity, height: 20),
          const SizedBox(height: 12),
          _shimmerBar(isDark, width: 200, height: 20),
        ],
      ),
    );
  }

  Widget _shimmerBar(
    bool isDark, {
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark
            ? AppConstants.primaryColor.withValues(alpha: 0.08)
            : AppConstants.primaryColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _buildFooter(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF07060F) : const Color(0xFFF5F4FF),
        border: Border(
          top: BorderSide(
            color: AppConstants.primaryColor.withValues(alpha: 0.12),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppConstants.primaryColor, AppConstants.accentColor],
            ).createShader(bounds),
            child: Text(
              '✦',
              style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _portfolioData.uiContent.footerText,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: isDark
                  ? AppConstants.darkTextSecondary
                  : AppConstants.lightTextSecondary,
            ),
          ),
          const SizedBox(width: 10),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppConstants.primaryColor, AppConstants.accentColor],
            ).createShader(bounds),
            child: Text(
              '✦',
              style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
