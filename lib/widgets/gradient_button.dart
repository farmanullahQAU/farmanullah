import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

/// Reusable gradient button widget
class GradientButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? fontSize;
  final double? iconSize;
  final Color? textColor;
  final List<BoxShadow>? boxShadow;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.iconSize,
    this.textColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(
          borderRadius ?? SpacingConstants.borderRadiusLG,
        ),
        child: Container(
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: isDesktop
                    ? SpacingConstants.spacing5XL
                    : SpacingConstants.spacing3XL,
                vertical: isDesktop
                    ? SpacingConstants.spacingXL
                    : SpacingConstants.spacingXL - 2,
              ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppConstants.primaryColor,
                AppConstants.secondaryColor,
              ],
            ),
            borderRadius: BorderRadius.circular(
              borderRadius ?? SpacingConstants.borderRadiusLG,
            ),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    color: AppConstants.primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: textColor ?? Colors.white,
                  size: iconSize ??
                      (isDesktop
                          ? SpacingConstants.spacing2XL
                          : SpacingConstants.spacingXL + 2),
                ),
                SizedBox(width: SpacingConstants.spacingMD),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize ?? (isDesktop ? 18 : 16),
                  fontWeight: FontWeight.w700,
                  color: textColor ?? Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

