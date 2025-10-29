import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

/// Reusable icon container with gradient background
class GradientIconContainer extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double opacity;

  const GradientIconContainer({
    super.key,
    required this.icon,
    this.iconSize,
    this.padding,
    this.borderRadius,
    this.opacity = 0.15,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    
    return Container(
      padding: padding ?? EdgeInsets.all(SpacingConstants.iconContainerPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConstants.primaryColor.withOpacity(opacity),
            AppConstants.secondaryColor.withOpacity(opacity),
          ],
        ),
        borderRadius: BorderRadius.circular(
          borderRadius ?? SpacingConstants.borderRadiusLG,
        ),
      ),
      child: Icon(
        icon,
        color: AppConstants.primaryColor,
        size: iconSize ?? (isDesktop ? 32 : 28),
      ),
    );
  }
}

