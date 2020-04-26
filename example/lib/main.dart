import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mercadopago/mercadopago.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String paymentResponse = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('start payment'),
                onPressed: onStartPayment,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(paymentResponse),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onStartPayment() async {
    var publicKey = 'TEST-2819b345-7a12-44a5-9ad3-fb5278308215';
    var checkoutPreferenceId = '129086117-c3c3f010-be33-45d2-99a1-bba41968cbd9';

    var response = await MercadoPago.startPayment(
      publicKey,
      checkoutPreferenceId,
    );

    setState(() {
      paymentResponse = response;
    });
  }
}
