import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:scratcher/widgets.dart';
import 'package:whitematrix_mt/presentation/product_screen/controller/product_controller.dart';

import '../../../model/product_model.dart';
import '../../../scratchcard_screen/scratch_screen.dart';
import '../../product_screen/view/product_screen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();
  bool _otpVerified = false;
  bool _isNewUser = false;

  void _addProductToCart() {
    final cartProvider = Provider.of<ProductProvider>(context, listen: false);
    final product = Product(
      name: "HAND BAG",
      price: 0.0,
      imageUrl: 'https://media.istockphoto.com/id/1204235743/photo/stylish-fashionable-woman-with-orange-round-bag.webp?b=1&s=612x612&w=0&k=20&c=KG95k0zw49LTxC7uxyyKCw88GhaybjhVIxRZjBVbgak=',
      description: "A stylish hand bag.",
      quantity: 1,
      id: '',
    );

    cartProvider.addToCart(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product added to cart.'),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    // Navigate to HomeScreen if OTP is verified and user is not new
    if (_otpVerified && !_isNewUser) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
        );
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.2),
            Text(
              "WELCOME TO BAG NEST",
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              'Enter your OTP ',
            ),
            SizedBox(height: size.height * 0.09),
            Padding(
              padding: EdgeInsets.only(left: size.width * .1, right: size.width * .1),
              child: TextFormField(
                controller: otpController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter OTP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            ElevatedButton(
              onPressed: () async {
                final otp = otpController.text.trim();
                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: otp,
                );

                try {
                  final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

                  // Check if user is new or existing
                  final user = userCredential.user;
                  final isNewUser = user?.metadata.creationTime == user?.metadata.lastSignInTime;

                  setState(() {
                    _otpVerified = true;
                    _isNewUser = isNewUser;
                  });
                } catch (e) {
                  log('Error verifying OTP: $e');
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Verify OTP',
              ),
            ),
            if (_otpVerified && _isNewUser)
              Expanded(
                child: ScratchCard(
                  onAddToCart: _addProductToCart,
                ),
              ),
          ],
        ),
      ),
    );
  }
}