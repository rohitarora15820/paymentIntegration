import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:upi_india/upi_india.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Payment Integrations'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//upi india
  Future<UpiResponse>? _transaction;

  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  //razorpay integration
  final razorpay = Razorpay();

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExtenalWallet);
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "rohitarora@okaxis",
      receiverName: 'Rohit Arora',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );
  }

  Widget displayUpiApps() {
    if (apps == null) {
      return CircularProgressIndicator();
    } else if (apps!.isEmpty) {
      return Center(
        child: Text("No Upi App Found"),
      );
    } else {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.memory(app.icon,width: 50,height: 50,),
                    
                    Text(
                      app.name
                    )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
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
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  // payviarazorpay();
                },
                child: const Text("Upi App"))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
