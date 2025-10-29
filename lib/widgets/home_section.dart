import 'package:farmanullah/models/portfolio_model.dart';
import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSection extends StatelessWidget {
  final PortfolioData data;

  const HomeSection({super.key, required this.data});

  Future<void> _downloadCV(BuildContext context) async {
    final url = Uri.parse(data.cvUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open CV link')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : (screenWidth > 400 ? 24 : 16),
        vertical: isDesktop ? 50 : 30,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Mobile Profile Image
              if (!isDesktop) ...[
                _buildMobileProfileImage(context, screenWidth),
                const SizedBox(height: 32),
              ],

              // Main Content Row/Column
              Row(
                children: [
                  // Left content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: isDesktop
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        _buildGreeting(context, isDesktop, screenWidth),
                        const SizedBox(height: 16),
                        _buildName(context, isDesktop, screenWidth),
                        const SizedBox(height: 16),
                        _buildTitle(context, isDesktop, screenWidth),
                        SizedBox(height: isDesktop ? 16 : 8),
                        _buildBio(context, isDesktop, screenWidth),
                        SizedBox(height: isDesktop ? 32 : 32),
                        _buildActionButtons(context, isDesktop, screenWidth),
                        SizedBox(height: isDesktop ? 16 : 8),
                      ],
                    ),
                  ),

                  // Desktop Profile Image
                  if (isDesktop) ...[
                    const SizedBox(width: 60),
                    _buildDesktopProfileImage(),
                  ],
                ],
              ),

              // Education Card - moved below for better mobile layout
              if (isDesktop) const SizedBox(height: 32),
              _buildEducationCard(context, isDesktop),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileProfileImage(BuildContext context, double screenWidth) {
    final size = screenWidth > 400 ? 200.0 : 150.0;

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
          cacheWidth: 400,
          cacheHeight: 400,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppConstants.primaryColor.withOpacity(0.1),
              child: const Icon(Icons.person, size: 100),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDesktopProfileImage() {
    return Container(
      width: 400,
      height: 400,
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
          cacheWidth: 400,
          cacheHeight: 400,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppConstants.primaryColor.withOpacity(0.1),
              child: const Icon(Icons.person, size: 100),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGreeting(
    BuildContext context,
    bool isDesktop,
    double screenWidth,
  ) {
    return Text(
      data.uiContent.greeting,
      textAlign: isDesktop ? TextAlign.left : TextAlign.center,
      style: TextStyle(
        fontSize: isDesktop ? 28 : (screenWidth > 400 ? 20 : 18),
        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
      ),
    );
  }

  Widget _buildName(BuildContext context, bool isDesktop, double screenWidth) {
    return ShaderMask(
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
    );
  }

  Widget _buildTitle(BuildContext context, bool isDesktop, double screenWidth) {
    return Text(
      data.uiContent.professionalTitle,
      textAlign: isDesktop ? TextAlign.left : TextAlign.center,
      style: TextStyle(
        fontSize: isDesktop ? 28 : (screenWidth > 400 ? 20 : 18),
        color: AppConstants.primaryColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildBio(BuildContext context, bool isDesktop, double screenWidth) {
    return Text(
      data.bio,
      textAlign: isDesktop ? TextAlign.left : TextAlign.center,
      style: TextStyle(
        fontSize: isDesktop ? 18 : (screenWidth > 400 ? 16 : 14),
        height: 1.8,
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    bool isDesktop,
    double screenWidth,
  ) {
    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [_buildPrimaryButton(context)],
      );
    } else {
      return SizedBox(child: _buildPrimaryButton(context, isMobile: true));
    }
  }

  Widget _buildPrimaryButton(BuildContext context, {bool isMobile = false}) {
    return FilledButton.icon(
      onPressed: () => _downloadCV(context),
      icon: const Icon(Icons.download_rounded, size: 22),
      label: Text(
        data.uiContent.buttonLabels['downloadCV']!,
        style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildEducationCard(BuildContext context, bool isDesktop) {
    return RepaintBoundary(
      child: Container(
        padding: EdgeInsets.all(isDesktop ? 32 : 24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
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
          children: List.generate(data.education.length, (index) {
            final edu = data.education[index];
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
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
                    SizedBox(width: isDesktop ? 24 : 16),
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
                          SizedBox(height: isDesktop ? 12 : 8),
                          Text(
                            edu.degree,
                            style: TextStyle(
                              fontSize: isDesktop ? 22 : 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: isDesktop ? 8 : 6),
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
                if (index < data.education.length - 1) ...[
                  SizedBox(height: isDesktop ? 24 : 20),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                  ),
                  SizedBox(height: isDesktop ? 24 : 20),
                ],
              ],
            );
          }),
        ),
      ),
    );
  }
}
