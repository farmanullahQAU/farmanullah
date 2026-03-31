import 'dart:ui';

import 'package:farmanullah/controllers/theme_controller.dart';
import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBar extends StatefulWidget {
  final PortfolioData? data;
  final String currentSection;
  final VoidCallback? onHome;
  final VoidCallback? onExperience;
  final VoidCallback? onServices;
  final VoidCallback? onSkills;
  final VoidCallback? onPortfolio;
  final VoidCallback? onContact;

  const NavBar({
    super.key,
    required this.currentSection,
    this.data,
    this.onHome,
    this.onExperience,
    this.onServices,
    this.onSkills,
    this.onPortfolio,
    this.onContact,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void _handleNavTap(VoidCallback? onTap) {
    if (onTap != null) {
      onTap();
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          setState(() => _isMenuOpen = false);
          _menuController.reverse();
        }
      });
    }
  }

  void _toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
    if (_isMenuOpen) {
      _menuController.forward();
    } else {
      _menuController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Glass blur navbar
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF07060F).withValues(alpha: 0.75)
                    : Colors.white.withValues(alpha: 0.80),
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? AppConstants.primaryColor.withValues(alpha: 0.12)
                        : AppConstants.primaryColor.withValues(alpha: 0.08),
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 18 : 48,
                    vertical: isMobile ? 14 : 18,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLogo(),
                      if (!isMobile) ...[
                        Expanded(
                          child: Center(
                            child: Wrap(
                              spacing: 4,
                              children: [
                                _buildNavItem(
                                  context,
                                  'Home',
                                  AppConstants.home,
                                  widget.onHome,
                                ),
                                _buildNavItem(
                                  context,
                                  'Experience',
                                  AppConstants.experience,
                                  widget.onExperience,
                                ),
                                _buildNavItem(
                                  context,
                                  'Services',
                                  AppConstants.services,
                                  widget.onServices,
                                ),
                                _buildNavItem(
                                  context,
                                  'Skills',
                                  AppConstants.skills,
                                  widget.onSkills,
                                ),
                                _buildNavItem(
                                  context,
                                  'Projects',
                                  AppConstants.portfolio,
                                  widget.onPortfolio,
                                ),
                                _buildNavItem(
                                  context,
                                  'Contact',
                                  AppConstants.contact,
                                  widget.onContact,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildThemeToggle(context),
                          if (isMobile) ...[
                            const SizedBox(width: 10),
                            _buildMobileMenuBtn(context),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Mobile dropdown menu
        if (isMobile)
          SizeTransition(
            sizeFactor: _menuAnimation,
            axisAlignment: -1,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF0F0D1E).withValues(alpha: 0.92)
                        : Colors.white.withValues(alpha: 0.95),
                    border: Border(
                      bottom: BorderSide(
                        color: AppConstants.primaryColor.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        _buildMobileNavItem(
                          'Home',
                          AppConstants.home,
                          () => _handleNavTap(widget.onHome),
                        ),
                        _buildMobileNavItem(
                          'Experience',
                          AppConstants.experience,
                          () => _handleNavTap(widget.onExperience),
                        ),
                        _buildMobileNavItem(
                          'Services',
                          AppConstants.services,
                          () => _handleNavTap(widget.onServices),
                        ),
                        _buildMobileNavItem(
                          'Skills',
                          AppConstants.skills,
                          () => _handleNavTap(widget.onSkills),
                        ),
                        _buildMobileNavItem(
                          'Projects',
                          AppConstants.portfolio,
                          () => _handleNavTap(widget.onPortfolio),
                        ),
                        _buildMobileNavItem(
                          'Contact',
                          AppConstants.contact,
                          () => _handleNavTap(widget.onContact),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: widget.onHome,
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [
            AppConstants.primaryColor,
            AppConstants.accentColor,
            AppConstants.neonAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        child: Text(
          'Farman Ullah',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String label,
    String section,
    VoidCallback? onTap,
  ) {
    final isActive = widget.currentSection == section;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: isActive
                ? AppConstants.primaryColor.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive
                  ? AppConstants.primaryColor
                  : Theme.of(context).textTheme.bodyMedium?.color,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withValues(alpha: 0.6),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppConstants.primaryColor.withValues(alpha: 0.2),
          ),
        ),
        child: IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              themeController.isDarkMode.value
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              key: ValueKey(themeController.isDarkMode.value),
              size: 20,
            ),
          ),
          onPressed: themeController.toggleTheme,
          tooltip: themeController.isDarkMode.value
              ? 'Light Mode'
              : 'Dark Mode',
        ),
      ),
    );
  }

  Widget _buildMobileMenuBtn(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppConstants.primaryColor.withValues(alpha: 0.2),
        ),
      ),
      child: IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            _isMenuOpen ? Icons.close_rounded : Icons.menu_rounded,
            key: ValueKey(_isMenuOpen),
            size: 22,
          ),
        ),
        onPressed: _toggleMenu,
      ),
    );
  }

  Widget _buildMobileNavItem(String label, String section, VoidCallback onTap) {
    final isActive = widget.currentSection == section;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            color: isActive
                ? AppConstants.primaryColor.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isActive
                ? Border.all(
                    color: AppConstants.primaryColor.withValues(alpha: 0.25),
                  )
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 18,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppConstants.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive
                      ? AppConstants.primaryColor
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              const Spacer(),
              if (isActive)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: AppConstants.primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
