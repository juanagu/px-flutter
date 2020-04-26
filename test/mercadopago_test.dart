import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercadopago/mercadopago.dart';

void main() {
  const MethodChannel channel = MethodChannel('mercadopago');

  TestWidgetsFlutterBinding.ensureInitialized();

  test('getPlatformVersion', () async {
    var result = await MercadoPago.startPayment(
      'TEST-2819b345-7a12-44a5-9ad3-fb5278308215',
      '129086117-c3c3f010-be33-45d2-99a1-bba41968cbd9',
    );
    expect(result, isNotNull);
  });
}
