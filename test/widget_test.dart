import 'package:flutter_test/flutter_test.dart';

import 'package:expense_manager/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SpendWiseApp());
    await tester.pumpAndSettle();

    // Verify that the title is present.
    expect(find.text('SpendWise'), findsOneWidget);
  });
}
