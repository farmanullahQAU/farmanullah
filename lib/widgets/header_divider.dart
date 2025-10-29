import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

class HeaderDivider extends StatelessWidget {
  final bool isDesktop;

  const HeaderDivider({super.key, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isDesktop
          ? const EdgeInsets.symmetric(horizontal: 64)
          : const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          // Start bubble
          Container(
            width: isDesktop ? 12 : 10,
            height: isDesktop ? 12 : 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppConstants.primaryColor,
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: isDesktop ? 3 : 2,
              ),
            ),
          ),
          // Left gradient line
          Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppConstants.primaryColor.withOpacity(0.3),
                    AppConstants.primaryColor.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Middle dot
          Container(
            width: isDesktop ? 10 : 8,
            height: isDesktop ? 10 : 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppConstants.primaryColor.withOpacity(0.6),
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: isDesktop ? 2 : 1.5,
              ),
            ),
          ),
          // Right gradient line
          Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppConstants.secondaryColor.withOpacity(0.1),
                    AppConstants.secondaryColor.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),
          // End bubble
          Container(
            width: isDesktop ? 12 : 10,
            height: isDesktop ? 12 : 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppConstants.secondaryColor,
              border: Border.all(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: isDesktop ? 3 : 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
