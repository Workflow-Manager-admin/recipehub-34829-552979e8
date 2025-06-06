import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipehub_frontend/main.dart';

void main() {
  testWidgets('RecipeHubApp builds and shows Home tab', (WidgetTester tester) async {
    await tester.pumpWidget(const RecipeHubApp());

    // App name/title bar should not be present (since AppBar is not used), but Home tab is visible.
    expect(find.text('Home'), findsOneWidget);

    // Search bar is present on Home tab.
    expect(find.byType(TextField), findsOneWidget);

    // Bottom navigation bar is present.
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });

  testWidgets('Can switch tabs and see screen changes', (WidgetTester tester) async {
    await tester.pumpWidget(const RecipeHubApp());

    // Switch to Favorites tab.
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();
    expect(find.text('Your favorite recipes will appear here!'), findsOneWidget);

    // Switch to Add Recipe tab.
    await tester.tap(find.text('Add Recipe'));
    await tester.pumpAndSettle();
    expect(find.text('Create your own recipe!'), findsOneWidget);

    // Switch to Profile tab.
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Profile and sharing options coming soon!'), findsOneWidget);
  });
}
