import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    final services = [
      {
        'title': 'Mobile App Development',
        'description':
            'Build high-performance cross-platform mobile applications with Flutter',
        'icon': Icons.smartphone,
      },
      {
        'title': 'Firebase Integration',
        'description':
            'Implement authentication, real-time databases, and cloud functions',
        'icon': Icons.cloud,
      },
      {
        'title': 'Blockchain & Web3',
        'description':
            'Develop dApps, smart contracts, and integrate wallet services',
        'icon': Icons.account_balance_wallet,
      },
      {
        'title': 'UI/UX Design',
        'description':
            'Create beautiful, modern interfaces following Material Design',
        'icon': Icons.palette,
      },
      {
        'title': 'App Monetization',
        'description': 'Implement ads, in-app purchases, and payment gateways',
        'icon': Icons.monetization_on,
      },
      {
        'title': 'App Publishing',
        'description': 'Publish apps to Google Play Store and Apple App Store',
        'icon': Icons.store,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Services',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),
              isDesktop
                  ? Row(
                      children: [
                        Expanded(
                          child: _buildServiceCard(context, services[0]),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildServiceCard(context, services[1]),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildServiceCard(context, services[2]),
                        ),
                      ],
                    )
                  : Column(
                      children: services.map((service) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _buildServiceCard(context, service),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 24),
              if (isDesktop)
                Row(
                  children: [
                    Expanded(child: _buildServiceCard(context, services[3])),
                    const SizedBox(width: 24),
                    Expanded(child: _buildServiceCard(context, services[4])),
                    const SizedBox(width: 24),
                    Expanded(child: _buildServiceCard(context, services[5])),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              service['icon'] as IconData,
              color: AppConstants.primaryColor,
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            service['title'] as String,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            service['description'] as String,
            style: TextStyle(
              height: 1.6,
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
