import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isOutlined;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? fontSize;
  final double? iconSize;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isOutlined = false,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.iconSize,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _pressed = false;
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _pressed ? 0.95 : (_hovered ? 1.02 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            padding:
                widget.padding ??
                EdgeInsets.symmetric(
                  horizontal: isDesktop ? 32 : 24,
                  vertical: isDesktop ? 18 : 16,
                ),
            decoration: widget.isOutlined
                ? BoxDecoration(
                    color: _hovered
                        ? (isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : AppConstants.primaryColor.withValues(
                                  alpha: 0.08,
                                ))
                        : (isDark
                              ? Colors.white.withValues(alpha: 0.03)
                              : Colors.transparent),
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? 16,
                    ),
                    border: Border.all(
                      color: _hovered
                          ? AppConstants.primaryColor
                          : (isDark
                                ? Colors.white.withValues(alpha: 0.15)
                                : AppConstants.primaryColor.withValues(
                                    alpha: 0.3,
                                  )),
                      width: 1.5,
                    ),
                    boxShadow: _hovered
                        ? [
                            BoxShadow(
                              color: AppConstants.primaryColor.withValues(
                                alpha: 0.15,
                              ),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  )
                : BoxDecoration(
                    gradient: LinearGradient(
                      colors: _hovered
                          ? [
                              AppConstants.accentColor,
                              AppConstants.primaryColor,
                            ]
                          : [
                              AppConstants.primaryColor,
                              AppConstants.secondaryColor,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? 16,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppConstants.primaryColor.withValues(
                          alpha: _hovered ? 0.5 : 0.3,
                        ),
                        blurRadius: _hovered ? 25 : 15,
                        offset: Offset(0, _hovered ? 8 : 4),
                        spreadRadius: _hovered ? 2 : 0,
                      ),
                    ],
                  ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: widget.isOutlined
                        ? (isDark ? Colors.white : AppConstants.primaryColor)
                        : Colors.white,
                    size: widget.iconSize ?? (isDesktop ? 20 : 18),
                  ),
                  const SizedBox(width: 10),
                ],
                Text(
                  widget.label,
                  style: GoogleFonts.inter(
                    fontSize: widget.fontSize ?? (isDesktop ? 15 : 14),
                    fontWeight: FontWeight.w700,
                    color: widget.isOutlined
                        ? (isDark ? Colors.white : AppConstants.primaryColor)
                        : Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                if (widget.isOutlined && _hovered) ...[
                  const SizedBox(width: 8),
                  AnimatedBuilder(
                    animation: _glowController,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(_glowController.value * 4, 0),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: isDark
                            ? Colors.white
                            : AppConstants.primaryColor,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
