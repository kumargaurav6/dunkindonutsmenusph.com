import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Persists the user's favorite menu items using a lightweight
/// platform storage channel (backed by Android SharedPreferences)
/// and notifies listeners so hearts update live across the app.
class FavoritesService extends ChangeNotifier {
  static const String _storageKey = 'favorite_item_ids';
  static const MethodChannel _channel =
      MethodChannel('com.dunkinph.menu/storage');

  final Set<String> _favoriteIds = {};

  /// Must be called (and awaited) before the app starts.
  Future<void> init() async {
    try {
      final List<dynamic>? stored =
          await _channel.invokeMethod<List<dynamic>>(
        'getStringList',
        <String, dynamic>{'key': _storageKey},
      );
      if (stored != null) {
        _favoriteIds.addAll(stored.whereType<String>());
      }
    } catch (e) {
      // On web (or any platform without the native storage plugin),
      // MethodChannel throws MissingPluginException — favorites then
      // simply live in memory for the session.
      debugPrint('FavoritesService init failed: $e');
    }
  }

  bool isFavorite(String itemId) => _favoriteIds.contains(itemId);

  Future<void> toggle(String itemId) async {
    if (_favoriteIds.contains(itemId)) {
      _favoriteIds.remove(itemId);
    } else {
      _favoriteIds.add(itemId);
    }
    try {
      await _channel.invokeMethod<bool>(
        'setStringList',
        <String, dynamic>{
          'key': _storageKey,
          'value': _favoriteIds.toList(),
        },
      );
    } catch (e) {
      debugPrint('FavoritesService save failed: $e');
    }
    notifyListeners();
  }

  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  int get count => _favoriteIds.length;
}

/// Makes the [FavoritesService] available to the whole widget tree.
class FavoritesScope extends InheritedNotifier<FavoritesService> {
  const FavoritesScope({
    super.key,
    required FavoritesService favorites,
    required super.child,
  }) : super(notifier: favorites);

  static FavoritesService of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<FavoritesScope>();
    assert(scope != null, 'FavoritesScope not found in widget tree.');
    return scope!.notifier!;
  }
}
