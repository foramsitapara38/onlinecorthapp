import 'package:flutter_test/flutter_test.dart';
import 'package:luxe/main.dart';

void main() {
  testWidgets('splash holds for five seconds then opens the shop', (
    tester,
  ) async {
    await tester.pumpWidget(const LuxeApp());

    expect(find.text('LUXE'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Create Account'), findsNothing);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.text('Get Started'), findsNothing);
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });
}
