import 'package:farmanullah/utils/constants.dart';
import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  final String email;
  final String phone;
  final String linkedIn;

  const ContactSection({
    super.key,
    required this.email,
    required this.phone,
    required this.linkedIn,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Get In Touch',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Text(
                'Let\'s work together on your next project.',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 48),
              if (isDesktop)
                Row(
                  children: [
                    Expanded(
                      child: _buildContactCard(
                        context,
                        'Email',
                        Icons.email,
                        email,
                        () {},
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildContactCard(
                        context,
                        'Phone',
                        Icons.phone,
                        phone,
                        () {},
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildContactCard(
                        context,
                        'LinkedIn',
                        Icons.link,
                        'farman4',
                        () {},
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildContactCard(
                      context,
                      'Email',
                      Icons.email,
                      email,
                      () {},
                    ),
                    const SizedBox(height: 16),
                    _buildContactCard(
                      context,
                      'Phone',
                      Icons.phone,
                      phone,
                      () {},
                    ),
                    const SizedBox(height: 16),
                    _buildContactCard(
                      context,
                      'LinkedIn',
                      Icons.link,
                      'farman4',
                      () {},
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String title,
    IconData icon,
    String value,
    VoidCallback onTap,
  ) {
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppConstants.primaryColor, size: 32),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
