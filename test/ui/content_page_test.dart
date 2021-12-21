import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:dynamics_news/ui/pages/content/content_page.dart';

void main() {
  testWidgets("states-screen", (WidgetTester tester) async {
    // Widgets Testing requires that the widgets we need to test have a unique key
    final section = find.byKey(const ValueKey("statesSection"));
    final card = find.byKey(const ValueKey("statusCard"));

    // This is a helper method for avoid network usage on NetworkImage
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const GetMaterialApp(home: ContentPage()));
      await tester.pump();
      await tester.tap(section);
      await tester.pumpAndSettle();

      expect(card, findsWidgets);
    });
  });

  testWidgets("social-screen", (WidgetTester tester) async {
    // Widgets Testing requires that the widgets we need to test have a unique key
    final section = find.byKey(const ValueKey("socialSection"));
    final card = find.byKey(const ValueKey("socialCard"));

    // This is a helper method for avoid network usage on NetworkImage
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const GetMaterialApp(home: ContentPage()));
      await tester.pump();
      await tester.tap(section);
      await tester.pumpAndSettle();

      expect(card, findsWidgets);
    });
  });

  testWidgets("verified-screen", (WidgetTester tester) async {
    // Widgets Testing requires that the widgets we need to test have a unique key
    final section = find.byKey(const ValueKey("offersSection"));
    final card = find.byKey(const ValueKey("offerCard"));

    // This is a helper method for avoid network usage on NetworkImage
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const GetMaterialApp(home: ContentPage()));
      await tester.pump();
      await tester.tap(section);
      await tester.pumpAndSettle();

      expect(card, findsWidgets);
    });
  });

  testWidgets("location-screen", (WidgetTester tester) async {
    // Widgets Testing requires that the widgets we need to test have a unique key
    final section = find.byKey(const ValueKey("locationSection"));
    final myCard = find.byKey(const ValueKey("myLocationCard"));
    final card = find.byKey(const ValueKey("locationCard"));

    // This is a helper method for avoid network usage on NetworkImage
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const GetMaterialApp(home: ContentPage()));
      await tester.pump();
      await tester.tap(section);
      await tester.pumpAndSettle();

      expect(myCard, findsOneWidget);
      expect(card, findsWidgets);
    });
  });

  testWidgets("wrong-screen", (WidgetTester tester) async {
    // Widgets Testing requires that the widgets we need to test have a unique key
    final section = find.byKey(const ValueKey("statesSection"));
    final myCard = find.byKey(const ValueKey("myLocationCard"));
    final card = find.byKey(const ValueKey("locationCard"));

    // This is a helper method for avoid network usage on NetworkImage
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const GetMaterialApp(home: ContentPage()));
      await tester.pump();
      await tester.tap(section);
      await tester.pumpAndSettle();

      expect(myCard, findsNothing);
      expect(card, findsNothing);
    });
  });
}
