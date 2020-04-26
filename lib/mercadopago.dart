import 'dart:async';

import 'package:flutter/services.dart';

class MercadoPago {
  static const MethodChannel _channel = const MethodChannel('mercadopago');

  static Future<dynamic> startPayment(
      String publicKey, String checkoutPreferenceId) async {
    return await _channel.invokeMethod('startPayment', {
      'publicKey': publicKey,
      'checkoutPreferenceId': checkoutPreferenceId,
    });
  }
}
