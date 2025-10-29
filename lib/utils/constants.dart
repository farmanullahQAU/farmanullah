import 'package:flutter/material.dart';

class AppConstants {
  // Purple theme colors
  static const Color primaryColor = Color(0xFF9333EA); // Vibrant purple
  static const Color secondaryColor = Color(0xFF7C3AED); // Deep purple
  static const Color accentColor = Color(0xFFA855F7); // Light purple
  static const Color redColor = Color.fromARGB(255, 110, 11, 24); // Dark purple

  // Light theme colors
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1E293B);
  static const Color lightTextSecondary = Color(0xFF64748B);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkText = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);

  // Section IDs
  static const String home = 'home';
  static const String about = 'about';
  static const String experience = 'experience';
  static const String services = 'services';
  static const String skills = 'skills';
  static const String portfolio = 'portfolio';
  static const String contact = 'contact';
}

class SpacingConstants {
  // Maximum content width across all sections
  static const double maxContentWidth = 1300;

  // Section container padding
  static double sectionPaddingHorizontalDesktop = 64;
  static double sectionPaddingHorizontalMobile = 24;
  static double sectionPaddingHorizontalMobileSmall = 16;
  static double sectionPaddingVerticalDesktop = 100;
  static double sectionPaddingVerticalMobile = 80;

  // Special section paddings (can be overridden if needed)
  static double homePaddingVerticalDesktop = 50;
  static double homePaddingVerticalMobile = 30;
  static double aboutPaddingVerticalDesktop = 120;
  static double portfolioPaddingVerticalDesktop = 32;
  static double portfolioPaddingVerticalMobile = 24;

  // Section header spacing
  static double sectionHeaderBarHeightDesktop = 50;
  static double sectionHeaderBarHeightMobile = 40;
  static double sectionHeaderBarWidth = 4;
  static double sectionHeaderBarSpacing = 16;
  static double sectionHeaderBottomSpacing = 48;

  // Content spacing
  static double spacingXS = 4;
  static double spacingSM = 8;
  static double spacingMD = 12;
  static double spacingLG = 16;
  static double spacingXL = 20;
  static double spacing2XL = 24;
  static double spacing3XL = 32;
  static double spacing4XL = 40;
  static double spacing5XL = 48;
  static double spacing6XL = 60;
  static double spacing7XL = 80;
  static double spacing8XL = 100;

  // Card padding
  static double cardPaddingDesktop = 32;
  static double cardPaddingMobile = 24;
  static double cardPaddingSmall = 20;

  // Card spacing (between cards)
  static double cardSpacingDesktop = 24;
  static double cardSpacingMobile = 20;

  // Border radius
  static double borderRadiusSM = 8;
  static double borderRadiusMD = 12;
  static double borderRadiusLG = 16;
  static double borderRadiusXL = 20;
  static double borderRadius2XL = 24;

  // Icon container padding
  static double iconContainerPadding = 14;
  static double iconContainerPaddingSmall = 10;

  // Helper methods for responsive spacing
  static EdgeInsets getSectionPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    final isSmallMobile = screenWidth <= 400;

    return EdgeInsets.symmetric(
      horizontal: isDesktop
          ? sectionPaddingHorizontalDesktop
          : (isSmallMobile
                ? sectionPaddingHorizontalMobileSmall
                : sectionPaddingHorizontalMobile),
      vertical: isDesktop
          ? sectionPaddingVerticalDesktop
          : sectionPaddingVerticalMobile,
    );
  }

  static EdgeInsets getHomePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    final isSmallMobile = screenWidth <= 400;

    return EdgeInsets.symmetric(
      horizontal: isDesktop
          ? sectionPaddingHorizontalDesktop
          : (isSmallMobile
                ? sectionPaddingHorizontalMobileSmall
                : sectionPaddingHorizontalMobile),
      vertical: isDesktop
          ? homePaddingVerticalDesktop
          : homePaddingVerticalMobile,
    );
  }

  static EdgeInsets getAboutPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    final isSmallMobile = screenWidth <= 400;

    return EdgeInsets.symmetric(
      horizontal: isDesktop
          ? sectionPaddingHorizontalDesktop
          : (isSmallMobile
                ? sectionPaddingHorizontalMobileSmall
                : sectionPaddingHorizontalMobile),
      vertical: isDesktop
          ? aboutPaddingVerticalDesktop
          : sectionPaddingVerticalMobile,
    );
  }

  static EdgeInsets getPortfolioPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return EdgeInsets.symmetric(
      horizontal: isDesktop ? 0 : sectionPaddingHorizontalMobileSmall,
      vertical: isDesktop
          ? portfolioPaddingVerticalDesktop
          : portfolioPaddingVerticalMobile,
    );
  }

  static double getSectionHeaderBarHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 768
        ? sectionHeaderBarHeightDesktop
        : sectionHeaderBarHeightMobile;
  }

  static EdgeInsets getCardPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    return EdgeInsets.all(isDesktop ? cardPaddingDesktop : cardPaddingMobile);
  }

  static EdgeInsets getCardPaddingSmall(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    return EdgeInsets.all(isDesktop ? cardPaddingDesktop : cardPaddingSmall);
  }

  static double getCardSpacing(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 768 ? cardSpacingDesktop : cardSpacingMobile;
  }
}
