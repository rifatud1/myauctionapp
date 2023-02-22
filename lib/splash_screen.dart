
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:myauctionapp/modules/sign_in/sign_in.dart';

class SplashScreen extends StatelessWidget {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedSplashScreen(
          splash: Image.asset('assets/myauctionapp.png',),
          nextScreen: SignIn(),
          // backgroundColor: primaryColor.withOpacity(.5),
          splashIconSize: 400,
          // duration: 1000,
          splashTransition: SplashTransition.slideTransition,
        ),
      ),
    );
  }
}