import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helios/auth/intro_page.dart';
import 'package:intl/intl.dart';

import '../constant/vars.dart';

class EditProfile extends StatefulWidget {
  // final dynamic modal;
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  bool isLogout=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName.text = userDetails['First Name']??'';
    lastName.text = userDetails['Last Name']??'';
    email.text = userDetails['Email']??'';
    phoneController.text = userDetails['mobileNo']??'';
    gender.text = userDetails['Gender']??'';
    birthDate.text = userDetails['Birthday']??'';

    // if(widget.modal!=null){
    //   firstName.text = widget.modal['First Name'];
    //   lastName.text = widget.modal['Last Name'];
    //   email.text = widget.modal['Email'];
    //   phoneController.text = widget.modal['mobileNo'];
    //   gender.text = widget.modal['Gender'];
    //   birthDate.text = widget.modal['Birthday'];
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff023034),
        title: const Text("My Profile",
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(children: [
         !isLogout ?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(
                child: const Text("Edit Profile",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff023034))),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("First Name",
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w500)),
                  Text("Last Name",
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w500)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: textFields(
                          controller: firstName)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: textFields(
                          controller: lastName)),
                ],
              ),
              Text("Email Address",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500)),
              textFields(
                  enabled: false,
                  controller: email),
              Text("Mobile Number",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500)),
              textFields(
                  enabled: false,
                  controller:
                      TextEditingController(text: phoneController.text)),
              Text("Gender",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500)),
              textFields(
                  controller: gender,
                  hintText: "Rather Not Say",
                  enabled: false,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                    ),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 225,
                          child: Column(
                            children: [
                              genderList(
                                Text("Select Your Gender"),
                                TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Divider(
                                height: 0,
                                thickness: 1.2,
                              ),
                              InkWell(
                                onTap: () {},
                                child: genderList(
                                  Text("Male"),
                                  TextStyle(color: Colors.black),
                                  onTap: () {
                                    gender.text = "Male";
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Divider(
                                height: 0,
                                thickness: 1.2,
                              ),
                              genderList(
                                Text("Female"),
                                TextStyle(color: Colors.black),
                                onTap: () {
                                  gender.text = "Female";
                                  Navigator.pop(context);
                                },
                              ),
                              Divider(
                                height: 0,
                                thickness: 1.2,
                              ),
                              genderList(
                                Text("Rather Not Say"),
                                TextStyle(color: Colors.black),
                                onTap: () {
                                  gender.text = "";
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }),
              Text("BirthDay",
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500)),
              textFields(
                  enabled: false,
                  controller: birthDate,
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                      ),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                            height: 300,
                            child: Column(
                              children: [
                                Expanded(
                                  child: CupertinoDatePicker(
                                    dateOrder: DatePickerDateOrder.dmy,
                                    minimumYear: 1980,
                                    maximumYear: 2050,
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: DateTime.now(),
                                    onDateTimeChanged: (value) {
                                      birthDate.text = DateFormat("dd/MMM/yyyy")
                                          .format(value);
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Select Date"),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color(0xff023034))),
                                )
                              ],
                            ));
                      },
                    );
                  }),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        userDetails.clear();
                        isLogout=true;
                        setState(() {
                        });
                      },
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        margin: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 5),
                        decoration: BoxDecoration(
                          // border: Border.all(color: Color(0xff023034),width: 1.3),
                          color: const Color(0xff023034),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text("Log Out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                       //  if(widget.modal==null){
                       // FirebaseFirestore.instance.collection("users").doc(widget.modal['id']).update(
                       //     {
                       //       "First Name" : firstName.text,
                       //       "Last Name" : lastName.text,
                       //       "Gender" : gender.text,
                       //       "Birthday" : birthDate.text,
                       //     });}
                      },
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        margin: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 5),
                        decoration: BoxDecoration(
                          // border: Border.all(color: Color(0xff023034),width: 1.3),
                          color: const Color(0xff023034),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text("Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ):Column(
           children: [
             SizedBox(
               height: MediaQuery.of(context).size.height * 0.03,
             ),
             Center(
               child: const Text("Account Setting",
                   style: TextStyle(
                       fontSize: 25,
                       fontWeight: FontWeight.bold,
                       color: Color(0xff023034))),
             ),
             // SizedBox(
             //   height: MediaQuery.of(context).size.height * 0.03,
             // ),
             InkWell(

               onTap: () {

               },
               child: Container(
                 width: double.maxFinite,
                 padding: const EdgeInsets.symmetric(vertical: 14),
                 margin: const EdgeInsets.symmetric(
                     vertical: 25, horizontal: 5),
                 decoration: BoxDecoration(
                   // border: Border.all(color: Color(0xff023034),width: 1.3),
                   color: const Color(0xff023034),
                   borderRadius: BorderRadius.circular(8),
                 ),
                 child: const Center(
                   child: Text("Sign or Login",
                       style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                           fontSize: 16)),
                 ),
               ),
             ),
           ],
         ),
        ]),
      ),
    );
  }
}

Widget textFields(
    {String? hintText,
    TextEditingController? controller,
    bool? enabled,
    Widget? suffixIcon,
    Function? onTap,
      InputBorder? disabledBorder}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: InkWell(
      onTap: () {
        onTap!();
      },
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            disabledBorder: disabledBorder,
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff023034), width: 1.5),
                borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            suffixIcon: suffixIcon),
      ),
    ),
  );
}

Widget genderList(Widget? title, TextStyle? titleTextStyle,
    {void Function()? onTap}) {
  return ListTile(
    title: Center(child: title),
    titleTextStyle: titleTextStyle,
    onTap: onTap,
  );
}
