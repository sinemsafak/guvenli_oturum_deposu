
import 'package:flutter_test/flutter_test.dart';
import 'package:guvenli_oturum_deposu/main.dart';

void main() {
  testWidgets('Güvenli belirteç ekranı açılmalı',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SecureStorageApp());

    expect(
      find.text('Güvenli Oturum Deposu'),
      findsOneWidget,
    );

    expect(
      find.text('Test Belirteci Kaydet'),
      findsOneWidget,
    );

    expect(
      find.text('Belirteci Oku ve Doğrula'),
      findsOneWidget,
    );

    expect(
      find.text('Belirteci Sil'),
      findsOneWidget,
    );
  });
}