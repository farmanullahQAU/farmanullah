import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

class HeaderDivider extends StatefulWidget {
  final bool isDesktop;
  final String? label;

  const HeaderDivider({super.key, this.isDesktop = true, this.label});

  @override
  State<HeaderDivider> createState() => _HeaderDividerState();
}

class _HeaderDividerState extends State<HeaderDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _widthAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: widget.isDesktop ? 60 : 40,
        horizontal: MediaQuery.of(context).size.width * 0.1,
      ),
      child: Column(
        children: [
          // Optional label above divider
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                letterSpacing: 3,
                color: AppConstants.primaryColor.withOpacity(0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: widget.isDesktop ? 20 : 12),
          ],
          // Modern divider with animation
          AnimatedBuilder(
            animation: _widthAnimation,
            builder: (context, child) {
              return SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Left accent line
                    Flexible(
                      child: Container(
                        height: 2,
                        margin: EdgeInsets.only(
                          right: widget.isDesktop ? 20 : 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppConstants.primaryColor.withOpacity(0.5),
                              AppConstants.primaryColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // Center icon/dot
                    ScaleTransition(
                      scale: _widthAnimation,
                      child: Container(
                        width: widget.isDesktop ? 16 : 12,
                        height: widget.isDesktop ? 16 : 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppConstants.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: AppConstants.primaryColor.withOpacity(0.4),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Right accent line
                    Flexible(
                      child: Container(
                        height: 2,
                        margin: EdgeInsets.only(
                          left: widget.isDesktop ? 20 : 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppConstants.secondaryColor,
                              AppConstants.secondaryColor.withOpacity(0.5),
                              Colors.transparent,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
