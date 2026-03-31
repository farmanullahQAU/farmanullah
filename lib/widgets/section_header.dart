import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? description;
  final bool forceUppercase;

  const SectionHeader({
    super.key,
    required this.title,
    this.description,
    this.forceUppercase = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Eyebrow label
        Row(
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppConstants.primaryColor, AppConstants.accentColor],
              ).createShader(bounds),
              child: Text(
                '// ${forceUppercase ? title.toUpperCase() : title.toUpperCase()}',
                style: GoogleFonts.inter(
                  fontSize: isDesktop ? 13 : 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Main title
        Text(
          forceUppercase ? title.toUpperCase() : title,
          style:
              (isDesktop
                      ? Theme.of(context).textTheme.displaySmall
                      : Theme.of(context).textTheme.headlineMedium)
                  ?.copyWith(letterSpacing: -0.5),
        ),
        if (description != null) ...[
          const SizedBox(height: 12),
          Text(
            description!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark
                  ? AppConstants.darkTextSecondary
                  : AppConstants.lightTextSecondary,
              fontSize: isDesktop ? 17 : 15,
            ),
          ),
        ],
      ],
    );
  }
}
