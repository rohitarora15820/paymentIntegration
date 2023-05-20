import 'package:flutter/material.dart';
import 'package:paymentintegration/paymentMethods/razorpayment.dart';
import 'package:paymentintegration/paymentMethods/upipayment.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Test UPI',
      home: PaymentMethods(),
    );
  }
}

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text("Payment Methods")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Razorpaymethod(),
                  ));
                },
                child: const Text('Pay via RazorPay')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UpiIndiaPayment(),
                  ));
                },
                child: const Text('Pay via Ui India')),
          ],
        ),
      ),
    );
  }
}
