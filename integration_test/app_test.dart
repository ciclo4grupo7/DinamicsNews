import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:dynamics_news/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('signup walkthrough', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Widgets Testing requires that the widgets we need to test have a unique key
      final switchTo = find.byKey(const ValueKey("toSignUpButton"));
      final nameField = find.byKey(const ValueKey("signUpName"));
      final emailField = find.byKey(const ValueKey("signUpEmail"));
      final passwordField = find.byKey(const ValueKey("signUpPassword"));
      final actionButton = find.byKey(const ValueKey("signUpButton"));

      // Sections key
      final statesSection = find.byKey(const ValueKey("statesSection"));
      final socialSection = find.byKey(const ValueKey("socialSection"));
      final offersSection = find.byKey(const ValueKey("offersSection"));
      final locationSection = find.byKey(const ValueKey("locationSection"));

      // Cards keys
      final statusCard = find.byKey(const ValueKey("statusCard"));
      final socialCard = find.byKey(const ValueKey("socialCard"));
      final offerCard = find.byKey(const ValueKey("offerCard"));
      final locationCard = find.byKey(const ValueKey("locationCard"));

      // Actions
      final themeAction = find.byKey(const ValueKey("themeAction"));
      final logoutAction = find.byKey(const ValueKey("logoutAction"));

      expect(switchTo, findsOneWidget);
      await tester.tap(switchTo);

      // Trigger a frame.
      await tester.pumpAndSettle();

      expect(nameField, findsOneWidget);
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(actionButton, findsOneWidget);
      await tester.enterText(nameField, "User");
      await tester.enterText(emailField, "barry.allen@example.com");
      await tester.enterText(passwordField, "SuperSecretPassword!");

      // Emulate a tap on the floating action button.
      await tester.tap(actionButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify states section
      expect(statusCard, findsWidgets);

      // Change section
      await tester.tap(socialSection);
      await tester.pumpAndSettle();

      // Verify states section
      expect(socialCard, findsWidgets);

      // Change section
      await tester.tap(offersSection);
      await tester.pumpAndSettle();

      // Verify states section
      expect(offerCard, findsWidgets);

      // Change section
      await tester.tap(locationSection);
      await tester.pumpAndSettle();

      // Verify states section
      expect(locationCard, findsWidgets);

      // Change section
      await tester.tap(statesSection);
      await tester.pumpAndSettle();

      // Verify states section
      expect(statusCard, findsWidgets);

      // Change theme
      await tester.tap(themeAction);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      await tester.tap(themeAction);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      // Logout
      await tester.tap(logoutAction);
    });

    testWidgets('signin walkthrough', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Widgets Testing requires that the widgets we need to test have a unique key
      final emailField = find.byKey(const ValueKey("signInEmail"));
      final passwordField = find.byKey(const ValueKey("signInPassword"));
      final actionButton = find.byKey(const ValueKey("signInButton"));

      // Sections key
      final statesSection = find.byKey(const ValueKey("statesSection"));
      final socialSection = find.byKey(const ValueKey("socialSection"));
      final offersSection = find.byKey(const ValueKey("offersSection"));
      final locationSection = find.byKey(const ValueKey("locationSection"));

      // Cards keys
      final statusCard = find.byKey(const ValueKey("statusCard"));
      final socialCard = find.byKey(const ValueKey("socialCard"));
      final offerCard = find.byKey(const ValueKey("offerCard"));
      final locationCard = find.byKey(const ValueKey("locationCard"));

      // Actions
      final themeAction = find.byKey(const ValueKey("themeAction"));
      final logoutAction = find.byKey(const ValueKey("logoutAction"));

      // Trigger a frame.
      await tester.pumpAndSettle();

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(actionButton, findsOneWidget);
      await tester.enterText(emailField, "barry.allen@example.com");
      await tester.enterText(passwordField, "SuperSecretPassword!");

      // Emulate a tap on the floating action button.
      await tester.tap(actionButton);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify states section
      expect(statusCard, findsWidgets);

      // Change section
      await tester.tap(socialSection);
      await tester.pumpAndSettle();

      // Verify states section
      expect(socialCard, findsWidgets);

      // Change section
      await tester.tap(offersSection);
      await tester.pumpAndSettle();

      // Verify states section
      expect(offerCard, findsWidgets);

      // Change section
      await tester.tap(locationSection);
      await tester.pumpAndSettle();

      // Verify states section
      expect(locationCard, findsWidgets);

      // Change section
      await tester.tap(statesSection);
      await tester.pumpAndSettle();

      // Verify states section
      expect(statusCard, findsWidgets);

      // Change theme
      await tester.tap(themeAction);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      await tester.tap(themeAction);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      // Logout
      await tester.tap(logoutAction);
    });
  });
}
