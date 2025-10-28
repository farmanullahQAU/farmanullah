import 'package:farmanullah/controllers/theme_controller.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBar extends StatefulWidget {
  final String currentSection;
  final VoidCallback? onHome;
  final VoidCallback? onExperience;
  final VoidCallback? onServices;
  final VoidCallback? onPortfolio;
  final VoidCallback? onContact;

  const NavBar({
    super.key,
    required this.currentSection,
    this.onHome,
    this.onExperience,
    this.onServices,
    this.onPortfolio,
    this.onContact,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isMenuOpen = false;

  void _handleNavTap(VoidCallback? onTap) {
    if (onTap != null) {
      onTap();
      // Close menu after a brief delay for smooth UX
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          setState(() => _isMenuOpen = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768;
    final themeController = Get.find<ThemeController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Main navbar bar
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 16 : 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLogo(),
                  if (!isMobile) ...[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildNavItem(
                            context,
                            'Home',
                            AppConstants.home,
                            widget.onHome,
                          ),
                          const SizedBox(width: 32),
                          _buildNavItem(
                            context,
                            'Experience',
                            AppConstants.experience,
                            widget.onExperience,
                          ),
                          const SizedBox(width: 32),
                          _buildNavItem(
                            context,
                            'Services',
                            AppConstants.services,
                            widget.onServices,
                          ),
                          const SizedBox(width: 32),
                          _buildNavItem(
                            context,
                            'Portfolio',
                            AppConstants.portfolio,
                            widget.onPortfolio,
                          ),
                          const SizedBox(width: 32),
                          _buildNavItem(
                            context,
                            'Contact',
                            AppConstants.contact,
                            widget.onContact,
                          ),
                        ],
                      ),
                    ),
                  ],
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildThemeToggle(context, themeController),
                      if (isMobile) ...[
                        const SizedBox(width: 12),
                        _buildMobileMenuButton(context),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Mobile Menu - smooth expand/collapse
        if (isMobile)
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: _isMenuOpen
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(
                            context,
                          ).dividerColor.withOpacity(0.1),
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
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
                          'Portfolio',
                          AppConstants.portfolio,
                          () => _handleNavTap(widget.onPortfolio),
                        ),
                        _buildMobileNavItem(
                          'Contact',
                          AppConstants.contact,
                          () => _handleNavTap(widget.onContact),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
      ],
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: widget.onHome,
      child: Text(
        'FARMAN ULLAH',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
          foreground: Paint()
            ..shader = LinearGradient(
              colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
            ).createShader(const Rect.fromLTWH(0, 0, 200, 100)),
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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      hoverColor: AppConstants.primaryColor.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppConstants.primaryColor.withOpacity(0.15) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive
                ? AppConstants.primaryColor
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(
    BuildContext context,
    ThemeController themeController,
  ) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
        ),
        child: IconButton(
          icon: Icon(
            themeController.isDarkMode.value
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            size: 20,
          ),
          onPressed: themeController.toggleTheme,
          tooltip: themeController.isDarkMode.value
              ? 'Light Mode'
              : 'Dark Mode',
          splashRadius: 24,
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: IconButton(
        icon: Icon(_isMenuOpen ? Icons.close : Icons.menu_rounded, size: 22),
        onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
        splashRadius: 24,
      ),
    );
  }

  Widget _buildMobileNavItem(String label, String section, VoidCallback onTap) {
    final isActive = widget.currentSection == section;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? AppConstants.primaryColor.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(color: AppConstants.primaryColor.withOpacity(0.3))
              : null,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive
                    ? AppConstants.primaryColor
                    : Theme.of(context).textTheme.bodyMedium?.color,
                letterSpacing: 0.3,
              ),
            ),
            const Spacer(),
            if (isActive)
              Icon(
                Icons.check_circle_rounded,
                size: 20,
                color: AppConstants.primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
