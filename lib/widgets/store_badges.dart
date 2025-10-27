import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreBadges extends StatelessWidget {
  final String? playStoreUrl;
  final String? appStoreUrl;

  const StoreBadges({super.key, this.playStoreUrl, this.appStoreUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (playStoreUrl != null) ...[
          _buildStoreButton(
            context,
            'Google Play',
            Icons.android,
            Colors.green,
            playStoreUrl!,
          ),
          const SizedBox(width: 8),
        ],
        if (appStoreUrl != null)
          _buildStoreButton(
            context,
            'App Store',
            Icons.apple,
            Colors.blue,
            appStoreUrl!,
          ),
      ],
    );
  }

  Widget _buildStoreButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    String url,
  ) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
