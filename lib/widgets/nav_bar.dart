import 'package:farmanullah/controllers/theme_controller.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBar extends StatelessWidget {
  final String currentSection;
  final VoidCallback? onHome;
  final VoidCallback? onAbout;
  final VoidCallback? onServices;
  final VoidCallback? onSkills;
  final VoidCallback? onPortfolio;
  final VoidCallback? onContact;

  const NavBar({
    super.key,
    required this.currentSection,
    this.onHome,
    this.onAbout,
    this.onServices,
    this.onSkills,
    this.onPortfolio,
    this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final themeController = Get.find<ThemeController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isDesktop)
            Row(
              children: [
                const Text(
                  'FARMAN ULLAH',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryColor,
                  ),
                ),
                const SizedBox(width: 64),
                _buildNavItem(
                  'Home',
                  AppConstants.home,
                  currentSection == AppConstants.home,
                  onHome,
                ),
                const SizedBox(width: 32),
                _buildNavItem(
                  'About',
                  AppConstants.about,
                  currentSection == AppConstants.about,
                  onAbout,
                ),
                const SizedBox(width: 32),
                _buildNavItem(
                  'Services',
                  AppConstants.services,
                  currentSection == AppConstants.services,
                  onServices,
                ),
                const SizedBox(width: 32),
                _buildNavItem(
                  'Portfolio',
                  AppConstants.portfolio,
                  currentSection == AppConstants.portfolio,
                  onPortfolio,
                ),
                const SizedBox(width: 32),
                _buildNavItem(
                  'Contact',
                  AppConstants.contact,
                  currentSection == AppConstants.contact,
                  onContact,
                ),
              ],
            )
          else
            const Text(
              'FARMAN ULLAH',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppConstants.primaryColor,
              ),
            ),
          IconButton(
            icon: Icon(
              themeController.isDarkMode.value
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => themeController.toggleTheme(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    String label,
    String id,
    bool isActive,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppConstants.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive ? AppConstants.primaryColor : null,
          ),
        ),
      ),
    );
  }
}
