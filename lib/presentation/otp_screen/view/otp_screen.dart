import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/widgets.dart';
import 'package:whitematrix_mt/core/constants/global_textstyles.dart';
import 'package:whitematrix_mt/presentation/product_screen/controller/product_controller.dart';

import '../../../core/constants/colors.dart';
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
      name: "rdtfgyhj",
      price: 0.0,
      imageUrl:
      'https://media.istockphoto.com/id/1204235743/photp?b=1&s=612x612&w=0&',
      description: "drtfgyhujk.",
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

  Future<void> verifyOtp() async {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the OTP')),
      );
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user is new
      final user = userCredential.user;
      final isNewUser =
          user?.metadata.creationTime == user?.metadata.lastSignInTime;

      setState(() {
        _otpVerified = true;
        _isNewUser = isNewUser;
      });

      log('OTP verified successfully');

      if (_otpVerified && _isNewUser) {
        // Navigate to the scratch card screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScratchCard(
              onAddToCart: _addProductToCart,
            ),
          ),
        );
      } else {
        // Navigate to HomeScreen directly if not a new user
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      log('Error verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP, please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: ColorTheme.secondarycolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.08),
            Text(
                'ENTER THE OTP ',style: GlobalTextStyles.mainTittle,
            ),
            SizedBox(height: size.height * 0.15),
            Padding(
              padding: EdgeInsets.only(left: size.width * .1, right: size.width * .1),
              child: TextFormField(
                controller: otpController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.confirmation_number,
                    color: ColorTheme.maincolor,
                  ),
                  filled: false,
                  hintText: ' _ _ _ _ _ _ _ ',
                  hintStyle: TextStyle(color: ColorTheme.maincolor),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(
                          width: 5, color: ColorTheme.maincolor)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide:
                    BorderSide(color: ColorTheme.maincolor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide:
                    BorderSide(color: ColorTheme.maincolor, width: 2),
                  ),
                ),
            ),),
            SizedBox(height: size.height * 0.05),
            ElevatedButton(
              onPressed: verifyOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.maincolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text(
                '     Verify     ',style: TextStyle(color: ColorTheme.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
