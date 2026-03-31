import 'package:flutter/material.dart';

class AppConstants {
  // Premium deep dark color system
  static const Color primaryColor = Color(0xFF9B40F8); // Vibrant violet
  static const Color secondaryColor = Color(0xFF6C2BD9); // Deep violet
  static const Color accentColor = Color(0xFFBB6BFF); // Light violet accent
  static const Color neonAccent = Color(0xFF00E5FF); // Cyan neon accent
  static const Color redColor = Color(0xFFFF3B6B); // Coral red

  // Light theme
  static const Color lightBackground = Color(0xFFF5F4FF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF120D26);
  static const Color lightTextSecondary = Color(0xFF5A5478);

  // Dark theme — high contrast dark
  static const Color darkBackground = Color(0xFF07060F);
  static const Color darkCard = Color(0xFF0F0D1E);
  static const Color darkSurface = Color(0xFF171530);
  static const Color darkText = Color(0xFFF0EEFF);
  static const Color darkTextSecondary = Color(0xFF9D96C4);

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
  static const double maxContentWidth = 1280;

  static double sectionPaddingHorizontalDesktop = 80;
  static double sectionPaddingHorizontalMobile = 24;
  static double sectionPaddingHorizontalMobileSmall = 16;
  static double sectionPaddingVerticalDesktop = 100;
  static double sectionPaddingVerticalMobile = 72;

  static double homePaddingVerticalDesktop = 60;
  static double homePaddingVerticalMobile = 40;
  static double aboutPaddingVerticalDesktop = 120;
  static double portfolioPaddingVerticalDesktop = 40;
  static double portfolioPaddingVerticalMobile = 24;

  static double sectionHeaderBarHeightDesktop = 36;
  static double sectionHeaderBarHeightMobile = 36;
  static double sectionHeaderBarWidth = 4;
  static double sectionHeaderBarSpacing = 14;
  static double sectionHeaderBottomSpacing = 56;

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

  static double cardPaddingDesktop = 32;
  static double cardPaddingMobile = 24;
  static double cardPaddingSmall = 20;

  static double cardSpacingDesktop = 24;
  static double cardSpacingMobile = 16;

  static double borderRadiusSM = 8;
  static double borderRadiusMD = 12;
  static double borderRadiusLG = 16;
  static double borderRadiusXL = 20;
  static double borderRadius2XL = 28;

  static double iconContainerPadding = 14;
  static double iconContainerPaddingSmall = 10;

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
      horizontal: isDesktop
          ? sectionPaddingHorizontalDesktop
          : sectionPaddingHorizontalMobileSmall,
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
