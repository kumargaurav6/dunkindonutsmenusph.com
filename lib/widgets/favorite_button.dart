import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../theme/app_theme.dart';

/// Heart button that toggles a favorite and rebuilds live
/// whenever the favorites list changes.
class FavoriteButton extends StatelessWidget {
  final String itemId;

  const FavoriteButton({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesScope.of(context);
    return AnimatedBuilder(
      animation: favorites,
      builder: (context, _) {
        final isFav = favorites.isFavorite(itemId);
        return IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? AppColors.pink : AppColors.darkSoft,
          ),
          tooltip: isFav ? 'Remove from favorites' : 'Save to favorites',
          onPressed: () => favorites.toggle(itemId),
        );
      },
    );
  }
}
