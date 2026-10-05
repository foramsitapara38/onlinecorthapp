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

  testWidgets('login and forgot password move between each other', (
    tester,
  ) async {
    await tester.pumpWidget(const LuxeApp());
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Already have an account? Login'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!!'), findsOneWidget);

    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();

    expect(find.text('Forgot password'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back!!'), findsOneWidget);
  });
}
