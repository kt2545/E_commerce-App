import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants/esewa.dart';

class Esewa {
  // Function to initiate payment
  void pay(List<Map<String, dynamic>> cartItems, String totalAmount) {
    try {
      if (cartItems.isEmpty) {
        debugPrint('Cart is empty. Cannot proceed with payment.');
        return;
      }

      // Selecting the first product to display in Esewa UI
      Map<String, dynamic> firstProduct = cartItems.first;

      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment:
              Environment.test, // Change to Environment.live for production
          clientId: kEsewaClientId,
          secretId: kEsewaSecretKey,
        ),
        esewaPayment: EsewaPayment(
          productId: firstProduct["productId"],
          productName: firstProduct["productName"],
          productPrice: totalAmount, // Total cart amount
          callbackUrl: "https://your-callback-url.com",
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult result) {
          debugPrint('Payment SUCCESS: ${result.refId}');
          verify(result, cartItems);
        },
        onPaymentFailure: () {
          debugPrint('Payment FAILURE');
        },
        onPaymentCancellation: () {
          debugPrint('Payment CANCELLED');
        },
      );
    } catch (e) {
      debugPrint('EXCEPTION: $e');
    }
  }

  Future<void> verify(EsewaPaymentSuccessResult result,
      List<Map<String, dynamic>> cartItems) async {
    try {
      Dio dio = Dio();
      String basicAuth =
          'Basic ${base64.encode(utf8.encode('$kEsewaClientId:$kEsewaSecretKey'))}';

      // Assuming first product for transaction verification (Modify as needed)
      if (cartItems.isEmpty) {
        debugPrint("No products found in cart for verification.");
        return;
      }

      // Sending first product details for verification (modify if needed)
      Map<String, dynamic> firstProduct = cartItems.first;
      String productId = firstProduct["productId"];
      String amount = firstProduct["productPrice"];

      Response response = await dio.get(
        'https://rc.esewa.com.np/mobile/transaction',
        queryParameters: {
          'txnRefId': result.refId,
          'productId': productId,
          'amount': amount,
        },
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      // Log verification response
      debugPrint("Payment Verification Response: ${response.data}");

      if (response.statusCode == 200) {
        debugPrint("Payment Verified Successfully");
      } else {
        debugPrint("Payment Verification Failed");
      }
    } catch (e) {
      debugPrint("Verification Error: $e");
    }
  }
}
