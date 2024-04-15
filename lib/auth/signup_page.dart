import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helios/controller/user_controller.dart';
import 'package:lottie/lottie.dart';

import '../constant/assets_path.dart';
import '../constant/vars.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  UserController userController=Get.find();
  final _formKey = GlobalKey<FormState>();

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
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const Text("Login",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff023034))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Row(
                children: [
                  CountryCodePicker(
                    onChanged: (value) {
                      userController.countryCode=value.dialCode!;
                      setState(() {});
                    },
                    initialSelection: 'IN',
                    favorite: const ['+91', 'IN'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        userController.phone=value;
                      },
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xff023034), width: 1.5),
                            borderRadius: BorderRadius.circular(8)),
                        counterText: "",
                      ),
                      validator: (value) {
                        if(
                        !RegExp(r'(^[]?[(]?[0-9]{3}[)]?[-\s]?[0-9]{3}[-\s]?[0-9]{4,6}$)').hasMatch(value ?? '')){
                            return "Enter a valid PhoneNumber";
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              InkWell(
                onTap: () async {
    if (_formKey.currentState!.validate()) {
               userController.sentOTP(context);
                }},
                child: !isLoaderVisible?Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xff023034),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text("Login with OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  )
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
      ),
    );
  }
}
