import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helios/constant/vars.dart';
import 'package:helios/controller/user_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../constant/assets_path.dart';
import 'profile_page.dart';

class OTPScreen extends StatefulWidget {
final verificationId;

  const OTPScreen({super.key, this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // TextEditingController otpController = TextEditingController();
 UserController userController =Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff023034),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Image.asset(
            appBarNameTag,
            height: 130,
            width: 130,
          ),
        ),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const Text("Enter Code",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff023034))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            OTPTextField(
              length: 6,
              otpFieldStyle:
                  OtpFieldStyle(focusBorderColor: const Color(0xff023034)),
              width: MediaQuery.of(context).size.width,
              fieldWidth: 45,
              style: const TextStyle(fontSize: 18),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                if (kDebugMode) {
                  print(userController.otp=pin);
                }
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            InkWell(
              onTap: () async {
                userController.verifyOTP(context,widget.verificationId);
                },
              child: !isLoaderVisible?Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 14),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  // border: Border.all(color: Color(0xff023034),width: 1.3),
                  color: const Color(0xff023034),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text("Verify OTP",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ):Container(
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xff023034),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Lottie.asset("assets/json/loader.json",height: 47),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
