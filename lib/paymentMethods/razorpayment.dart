import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Razorpaymethod extends StatefulWidget {
  const Razorpaymethod({super.key});

  @override
  State<Razorpaymethod> createState() => _RazorpaymethodState();
}

class _RazorpaymethodState extends State<Razorpaymethod> {
  //razorpay integration
  final razorpay = Razorpay();
  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExtenalWallet);
    super.initState();
  }

  handlePaymentSuccess(PaymentSuccessResponse response) {
    log("Payment success:${response.paymentId} + ${response.orderId}+ ${response.signature}");
  }

  handlePaymentFailure(PaymentFailureResponse response) {
    log("Payment failure:${response.code} + ${response.error}+ ${response.message}");
  }

  handleExtenalWallet(ExternalWalletResponse response) {
    log("External Wallet: ${response.walletName}");
  }

  void payviarazorpay() {
    const total = 100;
    const name = "TestPay";
    const description = "Test payment";
    var options = {
      'key': 'rzp_test_cwBUehfXB9t2Gx',
      'amount': total * 100,
      'name': name,
      'description': description,
      'prefill': {
        'contact': 8295883688,
        'email': 'rohitarora15820@gmail.com',
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      log("Error$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          onPressed: () {
            payviarazorpay();
          },
          child: Text('Pay via RazorPay')),
    );
  }
}
