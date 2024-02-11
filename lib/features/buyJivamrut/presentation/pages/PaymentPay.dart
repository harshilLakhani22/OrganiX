// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
//
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late Razorpay _razorpay;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _razorpay = Razorpay();
//
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//
//   }
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Handle payment success
//     print('Payment Successful: ${response.paymentId}');
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Handle payment failure
//     print('Payment Error: ${response.message}');
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Handle external wallet
//     print('External Wallet: ${response.walletName}');
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void _openRazorpay() {
//     var options = {
//       'key': 'rzp_test_tXchSfNmtZYJ3X',
//       'amount': 10000, // amount in the smallest currency unit (in this case, paise)
//       'name': 'Your Company Name',
//       'description': 'Test Payment',
//       'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print('Error initiating Razorpay: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Razorpay Integration'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _openRazorpay,
//           child: Text('Pay with Razorpay'),
//         ),
//       ),
//     );
//   }
// }
//
//
