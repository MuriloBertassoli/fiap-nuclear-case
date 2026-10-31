import 'package:flutter_test/flutter_test.dart';
import 'package:fiap_nuclear/main.dart';

void main() {
  testWidgets('Verifica carregamento da tela inicial do Nuclear Case',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NuclearCaseApp());

    expect(find.text('NUCLEAR CASE'), findsOneWidget);
    expect(find.text('Descubra o que você não vê.'), findsOneWidget);
  });
}