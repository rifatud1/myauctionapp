import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:myauctionapp/modules/home/home.dart';
import 'package:myauctionapp/routes/app_routes.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  signInWithGoogle(context) async {
    try {
      // Trigger the authentication flow
      print("process started");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      var user = userCredential.user;

      if (user!.uid.isNotEmpty) {
        print('success');
        print(user.displayName);
        print(user.email);
        print(user.uid);
        print(user.phoneNumber);
        Get.toNamed(AppRoutes.home);

      }
    } catch (e) {
      print("The error is $e");
      print('failed');
    }
  }

  signOut() async {
    var result = await FirebaseAuth.instance.signOut();
    print("logged out");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => signInWithGoogle(context),
              child: Ink(
                color: Color(0xFF397AF3),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset("assets/google_logo.png", height: 20, width: 20,),
                      SizedBox(width: 12),
                      Text('Sign in with Google'),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => signOut(),
              child: Ink(
                color: Color(0xFF397AF3),
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset("assets/google_logo.png", height: 20, width: 20,),
                      SizedBox(width: 12),
                      Text('Log Out'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
