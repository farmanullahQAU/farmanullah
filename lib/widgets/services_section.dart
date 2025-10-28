import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;
    final screenWidth = MediaQuery.of(context).size.width;

    final services = [
      {
        'title': 'Mobile App Development',
        'description':
            'Build high-performance cross-platform mobile applications with Flutter',
        'icon': Icons.smartphone_rounded,
      },
      {
        'title': 'Firebase Integration',
        'description':
            'Implement authentication, real-time databases, and cloud functions',
        'icon': Icons.cloud_rounded,
      },
      {
        'title': 'Blockchain & Web3',
        'description':
            'Develop dApps, smart contracts, and integrate wallet services',
        'icon': Icons.account_balance_wallet_rounded,
      },
      {
        'title': 'UI/UX Design',
        'description':
            'Create beautiful, modern interfaces following Material Design',
        'icon': Icons.palette_rounded,
      },
      {
        'title': 'App Monetization',
        'description': 'Implement ads, in-app purchases, and payment gateways',
        'icon': Icons.monetization_on_rounded,
      },
      {
        'title': 'App Publishing',
        'description': 'Publish apps to Google Play Store and Apple App Store',
        'icon': Icons.store_rounded,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : (screenWidth > 400 ? 24 : 16),
        vertical: isDesktop ? 100 : 80,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.3),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Title
              Row(
                children: [
                  Container(
                    width: 4,
                    height: isDesktop ? 50 : 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.primaryColor,
                          AppConstants.secondaryColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        AppConstants.primaryColor,
                        AppConstants.secondaryColor,
                      ],
                    ).createShader(bounds),
                    child: Text(
                      'Services',
                      style: TextStyle(
                        fontSize: isDesktop
                            ? 48
                            : (screenWidth > 400 ? 36 : 32),
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Services Grid - Same as before but with new card design
              if (isDesktop)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[0],
                            isDesktop,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[1],
                            isDesktop,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[2],
                            isDesktop,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[3],
                            isDesktop,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[4],
                            isDesktop,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildExperienceStyleCard(
                            context,
                            services[5],
                            isDesktop,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Column(
                  children: services.map((service) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _buildExperienceStyleCard(
                        context,
                        service,
                        isDesktop,
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceStyleCard(
    BuildContext context,
    Map<String, dynamic> service,
    bool isDesktop,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 32 : 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon with gradient background
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppConstants.primaryColor.withOpacity(0.15),
                        AppConstants.secondaryColor.withOpacity(0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    service['icon'] as IconData,
                    color: AppConstants.primaryColor,
                    size: isDesktop ? 32 : 28,
                  ),
                ),
                SizedBox(height: isDesktop ? 24 : 20),

                // Title
                Text(
                  service['title'] as String,
                  style: TextStyle(
                    fontSize: isDesktop ? 20 : 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  service['description'] as String,
                  style: TextStyle(
                    fontSize: isDesktop ? 15 : 14,
                    height: 1.6,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
