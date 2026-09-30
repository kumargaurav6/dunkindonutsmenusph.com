import 'dart:io';

import 'package:dunkin_ph_menu/main.dart';
import 'package:dunkin_ph_menu/services/favorites_service.dart';
import 'package:dunkin_ph_menu/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const String _sdkFonts =
    '/home/hatch/workspace/flutter-sdk/flutter/bin/cache/artifacts/material_fonts';

Future<void> _loadFont(String family, String path) async {
  final bytes = await File(path).readAsBytes();
  final loader = FontLoader(family)
    ..addFont(Future.value(ByteData.view(bytes.buffer)));
  await loader.load();
}

Future<void> _loadFonts() async {
  await _loadFont('Roboto', '$_sdkFonts/Roboto-Regular.ttf');
  await _loadFont('Roboto', '$_sdkFonts/Roboto-Medium.ttf');
  await _loadFont('Roboto', '$_sdkFonts/Roboto-Bold.ttf');
  await _loadFont('Roboto', '$_sdkFonts/Roboto-Light.ttf');
  await _loadFont('Roboto', '$_sdkFonts/Roboto-Italic.ttf');
  await _loadFont('MaterialIcons', '$_sdkFonts/MaterialIcons-Regular.otf');
}

void main() {
  testWidgets('Dunkin PH Menu app screenshots', (tester) async {
    // Real async IO (font files) must run outside the FakeAsync zone.
    await tester.runAsync(_loadFonts);

    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final favorites = FavoritesService();
    await tester.runAsync(favorites.init);
    await tester.pumpWidget(DunkinApp(favorites: favorites));

    // 0. Splash (capture before the 1500ms timer fires)
    await tester.pump(const Duration(milliseconds: 300));
    await expectLater(
        find.byType(MaterialApp), matchesGoldenFile('goldens/00-splash.png'));

    // Precache bundled images so goldens show real photos, not blanks.
    // Must use the same AssetImage providers the widgets use.
    await tester.runAsync(() async {
      final context = tester.element(find.byType(MaterialApp));
      for (final name in [
        'hero_banner.png',
        'classic_donuts.png',
        'premium_donuts.png',
        'supreme_donuts.png',
        'munchkins.png',
        'bundles.png',
        'brewed_coffee.png',
        'iced_coffee.png',
        'bunwich.png',
        'combo.png',
      ]) {
        await precacheImage(AssetImage('assets/images/$name'), context);
      }
    });

    // 1. Home (after splash timer fires)
    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();
    await expectLater(
        find.byType(MaterialApp), matchesGoldenFile('goldens/01-home.png'));

    // 2. Menu tab
    await tester.tap(find.byIcon(Icons.restaurant_menu));
    await tester.pumpAndSettle();
    await expectLater(
        find.byType(MaterialApp), matchesGoldenFile('goldens/02-menu.png'));

    // 3. Search for "donut" (go home, open search)
    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(TextField).first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'donut');
    await tester.pumpAndSettle();
    await expectLater(
        find.byType(MaterialApp), matchesGoldenFile('goldens/03-search.png'));

    // 4. Item detail (tap first result card)
    await tester.tap(find.byType(ItemCard).first);
    await tester.pumpAndSettle();
    await expectLater(
        find.byType(MaterialApp), matchesGoldenFile('goldens/04-detail.png'));

    // 5. Favorites tab (pop back to shell first)
    await tester.pageBack(); // detail -> search
    await tester.pumpAndSettle();
    await tester.pageBack(); // search -> shell
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pumpAndSettle();
    await expectLater(find.byType(MaterialApp),
        matchesGoldenFile('goldens/05-favorites.png'));

    // 6. About tab
    await tester.tap(find.byIcon(Icons.info));
    await tester.pumpAndSettle();
    await expectLater(
        find.byType(MaterialApp), matchesGoldenFile('goldens/06-about.png'));
  });
}
