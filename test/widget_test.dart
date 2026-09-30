import 'package:dunkin_ph_menu/main.dart';
import 'package:dunkin_ph_menu/services/favorites_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App boots: splash then home', (tester) async {
    final favorites = FavoritesService();
    await tester.runAsync(favorites.init);

    await tester.pumpWidget(DunkinApp(favorites: favorites));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text("Dunkin' PH Menu"), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();
    expect(find.text('Browse categories'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });
}
