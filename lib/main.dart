import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'services/favorites_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final favorites = FavoritesService();
  await favorites.init();
  runApp(DunkinApp(favorites: favorites));
}

class DunkinApp extends StatelessWidget {
  final FavoritesService favorites;

  const DunkinApp({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return FavoritesScope(
      favorites: favorites,
      child: MaterialApp(
        title: "Dunkin' PH Menu",
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const SplashScreen(),
      ),
    );
  }
}
