import 'package:flutter/material.dart';
import '../data/menu_data.dart';
import '../models/menu_item.dart';
import '../services/favorites_service.dart';
import '../widgets/item_card.dart';
import 'home_screen.dart';

/// Saved items screen with an empty state and live updates.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: AnimatedBuilder(
        animation: favorites,
        builder: (context, _) {
          final List<MenuItem> saved = favorites.favoriteIds
              .map((id) {
                try {
                  return items.firstWhere((i) => i.id == id);
                } catch (_) {
                  return null;
                }
              })
              .whereType<MenuItem>()
              .toList();

          if (saved.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite_border,
                        size: 72, color: Colors.black26),
                    const SizedBox(height: 16),
                    Text(
                      'No favorites yet',
                      style:
                          Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the heart on any item to save it here for quick access.',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            itemCount: saved.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, i) {
              final item = saved[i];
              return Dismissible(
                key: ValueKey(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete,
                      color: Colors.white),
                ),
                onDismissed: (_) => favorites.toggle(item.id),
                child: ItemCard(
                  item: item,
                  onTap: () => openItemDetail(context, item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
