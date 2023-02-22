import 'package:get/get.dart';
import 'package:myauctionapp/modules/details/details.dart';
import 'package:myauctionapp/modules/home/home.dart';
import 'package:myauctionapp/modules/sign_in/sign_in.dart';
import 'package:myauctionapp/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => Home(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => SignIn(),
    ),
  ];
}
