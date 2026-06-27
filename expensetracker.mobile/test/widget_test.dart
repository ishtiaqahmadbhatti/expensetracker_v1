import 'package:flutter_test/flutter_test.dart';

import 'package:expensetracker/main.dart';

void main() {
  testWidgets('Splash screen and home screen navigation test', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash screen shows the title.
    expect(find.text('Expense Tracker'), findsOneWidget);
    expect(find.text('Manage your budget intelligently'), findsOneWidget);

    // Pump a 3-second delay to trigger the navigation.
    await tester.pump(const Duration(seconds: 3));
    // Pump the transition animation duration.
    await tester.pump(const Duration(milliseconds: 800));

    // Verify that we are on the Home Screen and see the "Total Balance" header.
    expect(find.text('Total Balance'), findsOneWidget);
    expect(find.text('Recent Transactions'), findsOneWidget);
  });
}
