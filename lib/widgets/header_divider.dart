import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

/// Simple decorative section divider
class HeaderDivider extends StatelessWidget {
  const HeaderDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              AppConstants.primaryColor.withValues(alpha: 0.25),
              AppConstants.accentColor.withValues(alpha: 0.25),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
