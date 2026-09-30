import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../models/menu_item.dart';
import '../services/favorites_service.dart';
import '../theme/app_theme.dart';
import '../utils/peso.dart';
import '../widgets/favorite_button.dart';
import 'home_screen.dart';

/// Detail view for one menu item: big image, price card, tags,
/// favorite button and similar items from the same category.
class ItemDetailScreen extends StatelessWidget {
  final MenuItem item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final category = categoryById(item.categoryId);
    final similar = itemsInCategory(item.categoryId)
        .where((i) => i.id != item.id)
        .take(6)
        .toList();
    final favorites = FavoritesScope.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                item.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.pink.withValues(alpha: 0.1),
                  child: const Icon(
                    Icons.donut_large,
                    color: AppColors.pink,
                    size: 120,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.name.toUpperCase(),
                              style: const TextStyle(
                                color: AppColors.orange,
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      FavoriteButton(itemId: item.id),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (item.isPopular)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.orange.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_fire_department,
                              color: AppColors.orange, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Popular pick',
                            style: TextStyle(
                              color: AppColors.orangeDark,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(
                                  color: AppColors.darkSoft,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Philippine Peso',
                                style: TextStyle(
                                  color: AppColors.darkSoft,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            formatPeso(item.price),
                            style: const TextStyle(
                              color: AppColors.pink,
                              fontWeight: FontWeight.w800,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'About this item',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(height: 1.5),
                  ),
                  if (item.tags.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final tag in item.tags)
                          Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(
                                color: AppColors.pink,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor:
                                AppColors.pink.withValues(alpha: 0.08),
                            side: const BorderSide(color: AppColors.pink),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: favorites,
                    builder: (context, _) {
                      final isFav = favorites.isFavorite(item.id);
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => favorites.toggle(item.id),
                          icon: Icon(isFav
                              ? Icons.favorite
                              : Icons.favorite_border),
                          label: Text(isFav
                              ? 'Saved to favorites'
                              : 'Save to favorites'),
                        ),
                      );
                    },
                  ),
                  if (similar.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      'You may also like',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 190,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: similar.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, i) =>
                            _SimilarCard(item: similar[i]),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SimilarCard extends StatelessWidget {
  final MenuItem item;

  const _SimilarCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => openItemDetail(context, item),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  item.image,
                  height: 88,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 88,
                    color: AppColors.pink.withValues(alpha: 0.08),
                    child: const Icon(
                      Icons.donut_large,
                      color: AppColors.pink,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 12.5),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatPeso(item.price),
                      style: const TextStyle(
                        color: AppColors.pink,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
