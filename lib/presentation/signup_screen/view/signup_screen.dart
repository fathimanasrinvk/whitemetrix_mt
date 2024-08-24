import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../loginscreen/view/login_screen.dart';
import '../../otp_screen/view/otp_screen.dart';

class RegistrationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final phoneNumberController = TextEditingController();
    final nameController = TextEditingController();


    var size = MediaQuery.sizeOf(context);
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Text(
              "WELCOME TO BAG NEST",

            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Padding(
              padding:
              EdgeInsets.only(left: size.width * .1, right: size.width * .1),
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
                    Icons.person,

                  ),
                  filled: true,

                  hintText: 'Name',

                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding:
              EdgeInsets.only(left: size.width * .1, right: size.width * .1),
              child: TextFormField(
                controller: phoneNumberController,
                textInputAction: TextInputAction.next,
                // validator: (phonenumber) {
                //   if (phonenumber!.isEmpty) {
                //     return "Enter a valid phone number";
                //   } else {
                //     return null;
                //   }
                // },

                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,

                  ),
                  filled: true,

                  hintText: 'Phone Number',

                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide.none),
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

                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "SEND",

                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.3,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  "Already have an account? Login",

                ))
          ],
        ),
      ),
    );
  }
}