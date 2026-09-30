import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../theme/app_theme.dart';

/// About this app: version, disclaimer, data note.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalItems = items.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: AppColors.pink,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.donut_large,
                    color: Colors.white,
                    size: 56,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Dunkin' PH Menu",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Your Dunkin\u2019 favorites, priced in peso',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.darkSoft,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.orange.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: AppColors.orangeDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          _InfoCard(
            icon: Icons.menu_book,
            title: 'What is this app?',
            body:
                "Dunkin' PH Menu is a handy pocket guide to the Dunkin' Donuts Philippines menu. Browse $totalItems items across ${categories.length} categories — classic, premium and supreme donuts, munchkins, bundles, coffee, iced drinks, savory bunwiches and sulit combos — all with prices in Philippine Peso.",
          ),
          const SizedBox(height: 12),
          _InfoCard(
            icon: Icons.search,
            title: 'Features',
            body:
                'Live search across the whole menu, category browsing, item details with similar picks, and a favorites list saved on your device so your go-to orders are always one tap away.',
          ),
          const SizedBox(height: 12),
          _InfoCard(
            icon: Icons.info_outline,
            title: 'Disclaimer',
            body:
                "Unofficial fan-made menu guide. Prices may vary by branch and are subject to change. Not affiliated with Dunkin' Donuts Philippines.",
          ),
          const SizedBox(height: 12),
          _InfoCard(
            icon: Icons.calendar_month,
            title: 'Data note',
            body: 'Menu compiled September 2026.',
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Made with love for Filipino donut lovers',
              style: TextStyle(
                color: AppColors.darkSoft,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.pink.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.pink),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
