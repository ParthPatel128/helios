import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/otp_page.dart';
import '../auth/profile_page.dart';
import '../constant/vars.dart';

class UserController extends GetxController {
  String otp = "";
  String verificationId="";
  String countryCode = "+91";
  var phone = "";

  sentOTP(context) async {
    isLoaderVisible = true;
      await FirebaseAuth.instance.verifyPhoneNumber(
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException ex) {
            isLoaderVisible = false;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please try again")));
          },
          codeSent: (String verificationId, int? resendToken) {
            isLoaderVisible = false;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("OTP sent successfully")));
            Get.to(OTPScreen(verificationId: verificationId));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
          phoneNumber: countryCode + phone);
    }

  verifyOTP(context, verificationId) {
    isLoaderVisible = true;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("OTP verify successfully")));
        Get.to(ProfilePage());
        isLoaderVisible = false;
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid OTP")));
        isLoaderVisible = false;
      });
    } catch (ex) {
      if (kDebugMode) {
        print("Error:$ex");
      }
    }
  }
}
