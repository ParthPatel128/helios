import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../constant/vars.dart';
import '../home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _formKey = GlobalKey<FormState>();
  final profile = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff023034),
          title: const Text("My Profile",
              style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        const Text("Create Profile",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff023034))),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: textFields(
                              texts: "First Name",
                              controller: firstName,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "required";
                                }
                                return null;
                              },
                            )),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                                child: textFields(
                                    texts: "Last Name", controller: lastName,
                                validator: (p0) {
                                  if(p0!.isEmpty){
                                    return "required";
                                  }
                                  return null;
                                },)),
                          ],
                        ),
                        textFields(texts: "Email Address", controller: email,
                          validator: (p0) {
                            if(p0!.isEmpty){
                              return "required";
                            }else if(
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(p0)){
                              return "notValid";
                            }
                            return null;
                          },),
                        textFields(
                            texts: "Phone Number",
                            controller: TextEditingController(
                                text: phoneController.text),
                            enabled: false),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 225,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Center(
                                            child: Text(
                                          "Select Your Gender",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                      ),
                                      Divider(
                                        height: 0,
                                        thickness: 1.2,
                                      ),
                                      ListTile(
                                        onTap: () {
                                          gender.text = "Male";
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        title: Center(
                                          child: Text(
                                            "Male",
                                            style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: 0,
                                        thickness: 1.2,
                                      ),
                                      ListTile(
                                        onTap: () {
                                          gender.text = "Female";
                                          Navigator.pop(context);
                                        },
                                        title: Center(
                                          child: Text(
                                            "Female",
                                            style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        height: 0,
                                        thickness: 1.2,
                                      ),
                                      ListTile(
                                        onTap: () {
                                          gender.text = "";
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        title: Center(
                                          child: Text(
                                            "Rather not say",
                                            style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                                enabled: false,
                                controller: gender,
                                decoration: InputDecoration(
                                    hintText: "Rather not say",
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xff023034)),
                                        borderRadius: BorderRadius.circular(8)),
                                    counterText: "",
                                    suffixIcon: const Icon(
                                        Icons.keyboard_arrow_down_outlined))),
                            // validator: validator,
                          ),
                        ),
                        InkWell(
                            onTap: () async {
                              final pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2030));
                              if (pickDate != null) {
                                birthDate.text =
                                    DateFormat('dd/MMM/yyyy').format(pickDate);
                                setState(() {});
                              }
                            },
                            child: textFields(
                                texts: "Birthday",
                                enabled: false,
                                controller: birthDate,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff023034)
                              )
                            ))),
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              FirebaseFirestore.instance.collection("profile").add(
                                  {
                                    "First Name" : firstName.text,
                                    "Last Name" : lastName.text,
                                    "Email" : email.text,
                                    "Gender" : gender.text,
                                    "Birthday" : birthDate.text,
                                    "mobileNo" : phoneController.text,
                                  });

                              QuerySnapshot<Map<String, dynamic>> data =
                                  await FirebaseFirestore.instance
                                  .collection("profile")
                                  .where('mobileNo', isEqualTo: phoneController.text)
                                  .get();

                              if(data.docs.isNotEmpty){
                                profile.write("isLogin", true);
                                Map<String,dynamic> map = data.docs[0].data();
                                map['id'] = data.docs[0].id;
                                profile.write("users", data.docs[0].data());
                                userDetails =map;
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ));
                            }
                          },
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              // border: Border.all(color: Color(0xff023034),width: 1.3),
                              color: const Color(0xff023034),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text("Create Account",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          ),
                        )
                      ]),
                )
              ],
            )));
  }

  Widget textFields(
      {required String texts,
      TextEditingController? controller,
      bool? enabled,
      Widget? suffixIcon,
      String? Function(String?)? validator,
        InputBorder? disabledBorder}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        enabled: enabled ?? true,
        controller: controller,
        decoration: InputDecoration(
            labelText: texts,
            labelStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff023034), width: 1.5),
                borderRadius: BorderRadius.circular(8)),
            disabledBorder: disabledBorder,
            counterText: "",
            suffixIcon: suffixIcon),
        validator: validator,
      ),
    );
  }
}
