import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whitematrix_mt/core/constants/colors.dart';
import '../../loginscreen/view/login_screen.dart';
import '../../otp_screen/view/otp_screen.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phoneNumberController = TextEditingController();
    final nameController = TextEditingController();

    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorTheme.secondarycolor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgpic.png',
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                // top: size.height * 0.2,
                left: size.width * .1,
                right: size.width * .1,
                bottom: size.height * 0.6,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * .01, right: size.width * .01),
                    child: TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      validator: (name) {
                        if (name!.isEmpty) {
                          return "Enter a valid Username";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: ColorTheme.maincolor,
                        ),
                        filled: false,
                        hintText: 'Enter Your Name ',
                        hintStyle: TextStyle(color: ColorTheme.maincolor),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: ColorTheme.maincolor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                              color: ColorTheme.maincolor,
                              width:
                                  2), // Set border color to black for enabled state
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide:
                              BorderSide(color: ColorTheme.maincolor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * .01, right: size.width * .01),
                    child: TextFormField(
                      controller: phoneNumberController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      validator: (phonenumber) {
                        if (phonenumber!.isEmpty) {
                          return "Enter a valid phone number";
                        } else {
                          return null;
                        }
                      },

                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: ColorTheme.maincolor,
                        ),
                        filled: false,
                        hintText: 'Phone Number ',
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
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: phoneNumberController.text,
                          verificationCompleted: (phoneAuthCredential) {},
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
                                builder: (context) =>
                                    OtpScreen(verificationId: verificationId),
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
                      height: size.height * 0.05,
                      width: size.width * 0.57,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorTheme.maincolor,
                            width: 2,
                          ),
                          color: ColorTheme.maincolor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "SEND",
                          style: TextStyle(color: ColorTheme.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.3,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Already have an account? Login",
                        style: TextStyle(
                            color: ColorTheme.maincolor,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
