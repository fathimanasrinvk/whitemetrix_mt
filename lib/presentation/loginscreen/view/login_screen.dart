import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whitematrix_mt/core/constants/colors.dart';
import '../../otp_screen/view/otp_screen.dart';
import '../../product_screen/view/product_screen.dart';
import '../../signup_screen/view/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorTheme.secondarycolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            SizedBox(height: size.height * 0.2),
            Padding(
              padding: EdgeInsets.only(left: size.width * .1, right: size.width * .1),
              child: TextFormField(
                controller: phoneController,
                textInputAction: TextInputAction.next,
                validator: (name) {
                  if (name!.isEmpty) {
                    return "Enter a valid phone number";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                  ),
                  filled: true,
                  hintText: 'Phone Number',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.07),
            InkWell(
              onTap: () async {
                try {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: phoneController.text,
                    verificationCompleted: (phoneAuthCredential) {
                      // Auto verification succeeded, sign in directly
                      FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (route) => false,
                      );
                    },
                    verificationFailed: (error) {
                      log('Verification failed: ${error.message}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Verification failed')),
                      );
                    },
                    codeSent: (verificationId, forceResendingToken) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(verificationId: verificationId),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (verificationId) {
                      log("Auto retrieval timeout");
                    },
                  );
                } catch (e) {
                  log('Error during phone number verification: $e');
                }
              },
              child: Container(
                height: size.height * 0.06,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "LOGIN",
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.3),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationScreen(),
                  ),
                );
              },
              child: Text(
                "Don't have an account? Register",

              ),
            ),
          ],
        ),
      ),
    );
  }
}