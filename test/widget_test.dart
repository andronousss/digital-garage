import 'package:digital_garage/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows mechanic home screen', (tester) async {
    await tester.pumpWidget(const DigitalGarageApp());

    expect(find.text('Азамат Рахимов ·\nМеханик'), findsOneWidget);
    expect(find.text('Сканировать QR'), findsOneWidget);
    expect(find.text('График ТО'), findsNWidgets(2));
    expect(find.text('Мои заявки'), findsOneWidget);
  });
}
