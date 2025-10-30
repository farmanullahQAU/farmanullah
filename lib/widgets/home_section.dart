// import 'package:farmanullah/models/portfolio_model.dart';
// import 'package:farmanullah/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class HomeSection extends StatelessWidget {
//   final PortfolioData data;

//   const HomeSection({super.key, required this.data});

//   Future<void> _downloadCV(BuildContext context) async {
//     final url = Uri.parse(data.cvUrl);
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url, mode: LaunchMode.externalApplication);
//     } else {
//       if (context.mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Could not open CV link')));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isDesktop = screenWidth > 768;

//     return Container(
//       padding: SpacingConstants.getHomePadding(context),
//       child: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(
//             maxWidth: SpacingConstants.maxContentWidth,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Mobile Profile Image
//               if (!isDesktop) ...[
//                 _buildMobileProfileImage(context, screenWidth),
//                 SizedBox(height: SpacingConstants.spacing3XL),
//               ],

//               // Main Content Row/Column
//               Row(
//                 children: [
//                   // Left content
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: isDesktop
//                           ? CrossAxisAlignment.start
//                           : CrossAxisAlignment.center,
//                       children: [
//                         _buildGreeting(context, isDesktop, screenWidth),
//                         SizedBox(height: SpacingConstants.spacingLG),
//                         _buildName(context, isDesktop, screenWidth),
//                         SizedBox(height: SpacingConstants.spacingLG),
//                         _buildTitle(context, isDesktop, screenWidth),
//                         SizedBox(
//                           height: isDesktop
//                               ? SpacingConstants.spacingLG
//                               : SpacingConstants.spacingSM,
//                         ),
//                         _buildBio(context, isDesktop, screenWidth),
//                         SizedBox(height: SpacingConstants.spacing3XL),
//                         _buildActionButtons(context, isDesktop, screenWidth),
//                         SizedBox(
//                           height: isDesktop
//                               ? SpacingConstants.spacingLG
//                               : SpacingConstants.spacingSM,
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Desktop Profile Image
//                   if (isDesktop) ...[
//                     SizedBox(width: SpacingConstants.spacing6XL),
//                     _buildDesktopProfileImage(),
//                   ],
//                 ],
//               ),

//               // Education Card - moved below for better mobile layout
//               if (isDesktop) SizedBox(height: SpacingConstants.spacing3XL),
//               _buildEducationCard(context, isDesktop),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMobileProfileImage(BuildContext context, double screenWidth) {
//     final size = screenWidth > 400 ? 200.0 : 150.0;

//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: const LinearGradient(
//           colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppConstants.primaryColor.withOpacity(0.3),
//             blurRadius: 30,
//             spreadRadius: 5,
//           ),
//         ],
//       ),
//       child: ClipOval(
//         child: Image.asset(
//           data.profileImagePath,
//           fit: BoxFit.cover,
//           cacheWidth: 400,
//           cacheHeight: 400,
//           errorBuilder: (context, error, stackTrace) {
//             return Container(
//               color: AppConstants.primaryColor.withOpacity(0.1),
//               child: const Icon(Icons.person, size: 100),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildDesktopProfileImage() {
//     return Container(
//       width: 400,
//       height: 400,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: const LinearGradient(
//           colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppConstants.primaryColor.withOpacity(0.3),
//             blurRadius: 30,
//             spreadRadius: 5,
//           ),
//         ],
//       ),
//       child: ClipOval(
//         child: Image.asset(
//           data.profileImagePath,
//           fit: BoxFit.cover,
//           cacheWidth: 400,
//           cacheHeight: 400,
//           errorBuilder: (context, error, stackTrace) {
//             return Container(
//               color: AppConstants.primaryColor.withOpacity(0.1),
//               child: const Icon(Icons.person, size: 100),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildGreeting(
//     BuildContext context,
//     bool isDesktop,
//     double screenWidth,
//   ) {
//     return Text(
//       data.uiContent.greeting,
//       textAlign: isDesktop ? TextAlign.left : TextAlign.center,
//       style: TextStyle(
//         fontSize: isDesktop ? 28 : (screenWidth > 400 ? 20 : 18),
//         color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
//       ),
//     );
//   }

//   Widget _buildName(BuildContext context, bool isDesktop, double screenWidth) {
//     return ShaderMask(
//       shaderCallback: (bounds) => LinearGradient(
//         colors: [AppConstants.primaryColor, Colors.red],
//       ).createShader(bounds),
//       child: Text(
//         data.name,
//         textAlign: isDesktop ? TextAlign.left : TextAlign.center,
//         style: TextStyle(
//           fontSize: isDesktop ? 72 : (screenWidth > 400 ? 48 : 36),
//           fontWeight: FontWeight.bold,
//           height: 1.2,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

//   Widget _buildTitle(BuildContext context, bool isDesktop, double screenWidth) {
//     return Text(
//       data.uiContent.professionalTitle,
//       textAlign: isDesktop ? TextAlign.left : TextAlign.center,
//       style: TextStyle(
//         fontSize: isDesktop ? 28 : (screenWidth > 400 ? 20 : 18),
//         color: AppConstants.primaryColor,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }

//   Widget _buildBio(BuildContext context, bool isDesktop, double screenWidth) {
//     return Text(
//       data.bio,
//       textAlign: isDesktop ? TextAlign.left : TextAlign.center,
//       style: TextStyle(
//         fontSize: isDesktop ? 18 : (screenWidth > 400 ? 16 : 14),
//         height: 1.8,
//         color: Theme.of(context).textTheme.bodyMedium?.color,
//       ),
//     );
//   }

//   Widget _buildActionButtons(
//     BuildContext context,
//     bool isDesktop,
//     double screenWidth,
//   ) {
//     if (isDesktop) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [_buildPrimaryButton(context)],
//       );
//     } else {
//       return SizedBox(child: _buildPrimaryButton(context, isMobile: true));
//     }
//   }

//   Widget _buildPrimaryButton(BuildContext context, {bool isMobile = false}) {
//     return FilledButton.icon(
//       onPressed: () => _downloadCV(context),
//       icon: const Icon(Icons.download_rounded, size: 22),
//       label: Text(
//         data.uiContent.buttonLabels['downloadCV']!,
//         style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5),
//       ),
//     );
//   }

//   Widget _buildEducationCard(BuildContext context, bool isDesktop) {
//     return RepaintBoundary(
//       child: Container(
//         padding: SpacingConstants.getCardPadding(context),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           borderRadius: BorderRadius.circular(SpacingConstants.borderRadiusLG),
//           border: Border.all(
//             color: Theme.of(context).dividerColor.withOpacity(0.1),
//             width: 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Theme.of(context).shadowColor.withOpacity(0.04),
//               blurRadius: 12,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           children: List.generate(data.education.length, (index) {
//             final edu = data.education[index];
//             return Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: SpacingConstants.sectionHeaderBarWidth,
//                       height: isDesktop ? 80 : 70,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             AppConstants.primaryColor,
//                             AppConstants.secondaryColor,
//                           ],
//                         ),
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                     SizedBox(
//                       width: isDesktop
//                           ? SpacingConstants.spacing2XL
//                           : SpacingConstants.spacingLG,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             edu.period,
//                             style: TextStyle(
//                               color: AppConstants.primaryColor,
//                               fontWeight: FontWeight.w800,
//                               fontSize: isDesktop ? 12 : 11,
//                               letterSpacing: 0.8,
//                             ),
//                           ),
//                           SizedBox(
//                             height: isDesktop
//                                 ? SpacingConstants.spacingMD
//                                 : SpacingConstants.spacingSM,
//                           ),
//                           Text(
//                             edu.degree,
//                             style: TextStyle(
//                               fontSize: isDesktop ? 22 : 20,
//                               fontWeight: FontWeight.w900,
//                               letterSpacing: -0.3,
//                             ),
//                           ),
//                           SizedBox(
//                             height: isDesktop
//                                 ? SpacingConstants.spacingSM
//                                 : SpacingConstants.spacingXS,
//                           ),
//                           Text(
//                             edu.institution,
//                             style: TextStyle(
//                               fontSize: isDesktop ? 15 : 14,
//                               color: Theme.of(
//                                 context,
//                               ).textTheme.bodyMedium?.color?.withOpacity(0.7),
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.3,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (index < data.education.length - 1) ...[
//                   SizedBox(
//                     height: isDesktop
//                         ? SpacingConstants.spacing2XL
//                         : SpacingConstants.spacingXL,
//                   ),
//                   Divider(
//                     height: 1,
//                     thickness: 1,
//                     color: Theme.of(context).dividerColor.withOpacity(0.1),
//                   ),
//                   SizedBox(
//                     height: isDesktop
//                         ? SpacingConstants.spacing2XL
//                         : SpacingConstants.spacingXL,
//                   ),
//                 ],
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSection extends StatelessWidget {
  final PortfolioData data;

  const HomeSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return Container(
      padding: SpacingConstants.getHomePadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: SpacingConstants.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Mobile Profile Image
              if (!isDesktop)
                _MobileProfileImage(data: data, screenWidth: screenWidth),

              // Main Content
              isDesktop
                  ? _DesktopLayout(data: data, screenWidth: screenWidth)
                  : _MobileLayout(data: data, screenWidth: screenWidth),

              // Education Card
              SizedBox(height: isDesktop ? SpacingConstants.spacing3XL : 0),
              _EducationCard(data: data, isDesktop: isDesktop),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileProfileImage extends StatelessWidget {
  final PortfolioData data;
  final double screenWidth;

  const _MobileProfileImage({required this.data, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final size = screenWidth > 400 ? 200.0 : 150.0;

    return Padding(
      padding: EdgeInsets.only(bottom: SpacingConstants.spacing3XL),
      child: _ProfileImageCircle(data: data, size: size),
    );
  }
}

class _ProfileImageCircle extends StatelessWidget {
  final PortfolioData data;
  final double size;

  const _ProfileImageCircle({required this.data, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          data.profileImagePath,
          fit: BoxFit.cover,
          cacheWidth: (size * 2).toInt(),
          cacheHeight: (size * 2).toInt(),
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppConstants.primaryColor.withOpacity(0.1),
              child: const Icon(Icons.person, size: 80),
            );
          },
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final PortfolioData data;
  final double screenWidth;

  const _DesktopLayout({required this.data, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TextContent(data: data, isDesktop: true),
              SizedBox(height: SpacingConstants.spacing3XL),
              _ActionButton(
                data: data,
                onPressed: () {
                  _downloadCV(context);
                },
              ),
            ],
          ),
        ),
        SizedBox(width: SpacingConstants.spacing6XL),
        _ProfileImageCircle(data: data, size: 400),
      ],
    );
  }

  Future<void> _downloadCV(BuildContext context) async {
    final url = Uri.parse(data.cvUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

class _MobileLayout extends StatelessWidget {
  final PortfolioData data;
  final double screenWidth;

  const _MobileLayout({required this.data, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _TextContent(data: data, isDesktop: false, screenWidth: screenWidth),
        SizedBox(height: SpacingConstants.spacing3XL),
        _ActionButton(
          data: data,
          isMobile: true,
          onPressed: () {
            _downloadCV(context);
          },
        ),
        SizedBox(height: SpacingConstants.spacing2XL),
      ],
    );
  }

  Future<void> _downloadCV(BuildContext context) async {
    final url = Uri.parse(data.cvUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

class _TextContent extends StatelessWidget {
  final PortfolioData data;
  final bool isDesktop;
  final double screenWidth;

  const _TextContent({
    required this.data,
    required this.isDesktop,
    this.screenWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          data.uiContent.greeting,
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isDesktop ? 28 : (screenWidth > 400 ? 20 : 18),
            color: Theme.of(
              context,
            ).textTheme.bodyMedium?.color?.withOpacity(0.6),
          ),
        ),
        SizedBox(height: SpacingConstants.spacingLG),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppConstants.primaryColor, Colors.red],
          ).createShader(bounds),
          child: Text(
            data.name,
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 72 : (screenWidth > 400 ? 48 : 36),
              fontWeight: FontWeight.bold,
              height: 1.2,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: SpacingConstants.spacingLG),
        Text(
          data.uiContent.professionalTitle,
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isDesktop ? 28 : (screenWidth > 400 ? 20 : 18),
            color: AppConstants.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: isDesktop
              ? SpacingConstants.spacingLG
              : SpacingConstants.spacingSM,
        ),
        Text(
          data.bio,
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isDesktop ? 18 : (screenWidth > 400 ? 16 : 14),
            height: 1.8,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final PortfolioData data;
  final VoidCallback onPressed;
  final bool isMobile;

  const _ActionButton({
    required this.data,
    required this.onPressed,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.download_rounded, size: 22),
      label: Text(
        data.uiContent.buttonLabels['downloadCV']!,
        style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5),
      ),
    );

    return isMobile ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class _EducationCard extends StatelessWidget {
  final PortfolioData data;
  final bool isDesktop;

  const _EducationCard({required this.data, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: SpacingConstants.getCardPadding(context),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(SpacingConstants.borderRadiusLG),
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: List.generate(
            data.education.length,
            (index) => _EducationItem(
              edu: data.education[index],
              isDesktop: isDesktop,
              isLast: index == data.education.length - 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _EducationItem extends StatelessWidget {
  final dynamic edu;
  final bool isDesktop;
  final bool isLast;

  const _EducationItem({
    required this.edu,
    required this.isDesktop,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SpacingConstants.sectionHeaderBarWidth,
              height: isDesktop ? 80 : 70,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppConstants.primaryColor,
                    AppConstants.secondaryColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(
              width: isDesktop
                  ? SpacingConstants.spacing2XL
                  : SpacingConstants.spacingLG,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    edu.period,
                    style: TextStyle(
                      color: AppConstants.primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: isDesktop ? 12 : 11,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(
                    height: isDesktop
                        ? SpacingConstants.spacingMD
                        : SpacingConstants.spacingSM,
                  ),
                  Text(
                    edu.degree,
                    style: TextStyle(
                      fontSize: isDesktop ? 22 : 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(
                    height: isDesktop
                        ? SpacingConstants.spacingSM
                        : SpacingConstants.spacingXS,
                  ),
                  Text(
                    edu.institution,
                    style: TextStyle(
                      fontSize: isDesktop ? 15 : 14,
                      color: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!isLast) ...[
          SizedBox(
            height: isDesktop
                ? SpacingConstants.spacing2XL
                : SpacingConstants.spacingXL,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
          SizedBox(
            height: isDesktop
                ? SpacingConstants.spacing2XL
                : SpacingConstants.spacingXL,
          ),
        ],
      ],
    );
  }
}
