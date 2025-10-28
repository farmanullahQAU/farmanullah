import 'package:farmanullah/controllers/theme_controller.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBar extends StatefulWidget {
  final String currentSection;
  final VoidCallback? onHome;
  final VoidCallback? onAbout;
  final VoidCallback? onExperience;
  final VoidCallback? onServices;
  final VoidCallback? onSkills;
  final VoidCallback? onPortfolio;
  final VoidCallback? onContact;

  const NavBar({
    super.key,
    required this.currentSection,
    this.onHome,
    this.onAbout,
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
  bool _showMobileMenu = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMobileMenu() {
    setState(() {
      _showMobileMenu = !_showMobileMenu;
      if (_showMobileMenu) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;
    final isTablet = MediaQuery.of(context).size.width > 600 && !isDesktop;
    final themeController = Get.find<ThemeController>();

    return Container(
      constraints: const BoxConstraints(minHeight: 60, maxHeight: double.infinity),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop
                  ? 40
                  : isTablet
                  ? 28
                  : 16,
              vertical: isDesktop ? 12 : 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Brand Logo
                _buildLogo(isDesktop, isTablet),

                // Desktop Navigation
                if (isDesktop)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildNavItem(
                          context,
                          'Home',
                          AppConstants.home,
                          widget.currentSection == AppConstants.home,
                          widget.onHome,
                        ),
                        const SizedBox(width: 4),
                        _buildNavItem(
                          context,
                          'Experience',
                          AppConstants.experience,
                          widget.currentSection == AppConstants.experience,
                          widget.onExperience,
                        ),
                        const SizedBox(width: 4),
                        _buildNavItem(
                          context,
                          'Services',
                          AppConstants.services,
                          widget.currentSection == AppConstants.services,
                          widget.onServices,
                        ),
                        const SizedBox(width: 4),
                        _buildNavItem(
                          context,
                          'Portfolio',
                          AppConstants.portfolio,
                          widget.currentSection == AppConstants.portfolio,
                          widget.onPortfolio,
                        ),
                        const SizedBox(width: 4),
                        _buildNavItem(
                          context,
                          'Contact',
                          AppConstants.contact,
                          widget.currentSection == AppConstants.contact,
                          widget.onContact,
                        ),
                      ],
                    ),
                  )
                else
                  const SizedBox.shrink(),

                // Theme Toggle and Menu Button
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildThemeToggle(themeController),
                    if (!isDesktop) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            _showMobileMenu ? Icons.close : Icons.menu_rounded,
                            key: ValueKey(_showMobileMenu),
                            color: Theme.of(context).iconTheme.color,
                            size: 24,
                          ),
                        ),
                        onPressed: _toggleMobileMenu,
                        splashRadius: 24,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Mobile Menu
          if (!isDesktop)
            SizeTransition(
              sizeFactor: _animationController,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildMobileNavItem(
                      'Home',
                      AppConstants.home,
                      widget.currentSection == AppConstants.home,
                      widget.onHome,
                    ),
                    const SizedBox(height: 6),
                    _buildMobileNavItem(
                      'Experience',
                      AppConstants.experience,
                      widget.currentSection == AppConstants.experience,
                      widget.onExperience,
                    ),
                    const SizedBox(height: 6),
                    _buildMobileNavItem(
                      'Services',
                      AppConstants.services,
                      widget.currentSection == AppConstants.services,
                      widget.onServices,
                    ),
                    const SizedBox(height: 6),
                    _buildMobileNavItem(
                      'Portfolio',
                      AppConstants.portfolio,
                      widget.currentSection == AppConstants.portfolio,
                      widget.onPortfolio,
                    ),
                    const SizedBox(height: 6),
                    _buildMobileNavItem(
                      'Contact',
                      AppConstants.contact,
                      widget.currentSection == AppConstants.contact,
                      widget.onContact,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogo(bool isDesktop, bool isTablet) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
      ).createShader(bounds),
      child: Text(
        'FARMAN',
        style: TextStyle(
          fontSize: isDesktop
              ? 22
              : isTablet
              ? 20
              : 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildThemeToggle(ThemeController themeController) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: Icon(
              themeController.isDarkMode.value
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              key: ValueKey(themeController.isDarkMode.value),
              color: Theme.of(context).iconTheme.color,
              size: 20,
            ),
          ),
          onPressed: () => themeController.toggleTheme(),
          splashRadius: 20,
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String label,
    String id,
    bool isActive,
    VoidCallback? onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        splashColor: AppConstants.primaryColor.withOpacity(0.1),
        hoverColor: AppConstants.primaryColor.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                  color: isActive
                      ? AppConstants.primaryColor
                      : Theme.of(context).textTheme.bodyMedium?.color,
                  letterSpacing: 0.3,
                ),
              ),
              if (isActive)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    height: 2,
                    width: 20,
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(
    String label,
    String id,
    bool isActive,
    VoidCallback? onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
            Future.delayed(const Duration(milliseconds: 400), () {
              if (mounted) {
                _toggleMobileMenu();
              }
            });
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isActive
                ? AppConstants.primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 15,
                    color: isActive ? AppConstants.primaryColor : null,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              if (isActive)
                Icon(
                  Icons.check_circle_rounded,
                  size: 20,
                  color: AppConstants.primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
