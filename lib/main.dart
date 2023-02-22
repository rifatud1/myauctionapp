import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myauctionapp/modules/sign_in/sign_in.dart';
import 'package:get/get.dart';
import 'package:myauctionapp/routes/app_pages.dart';
import 'package:myauctionapp/routes/app_routes.dart';

// Here, I have used Getx for routing

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash,
      title: 'My Auction App',
    );
  }
}
