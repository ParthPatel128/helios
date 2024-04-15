import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helios/constant/vars.dart';
import 'package:helios/home_page.dart';

import 'auth/intro_page.dart';
import 'constant/assets_path.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final profile = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff023034),
body:
Center(child: Image.asset(splashLogo)),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if(profile.read("isLogin")??false){
          userDetails = profile.read("users")??{};
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const IntroPage(),));
        }

      },
    );
  }
}
