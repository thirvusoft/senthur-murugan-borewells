import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:senthur_murugan/page/attendance.dart';
import 'package:senthur_murugan/page/home_page.dart';
import 'package:senthur_murugan/page/login_page.dart';
import '../page/customer_creation.dart';

class Routes {
  static String customercreation = '/Customercreation';
  static String loginpage = '/loginpage';
  static String homepage = '/homepage';
  static String attendance = '/attendance';
}

final getPages = [
  GetPage(
    name: Routes.customercreation,
    page: () => const Customercreation(),
  ),
  GetPage(
    name: Routes.loginpage,
    page: () => Loginpage(),
  ),
  GetPage(
    name: Routes.homepage,
    page: () => const Homepage(),
  ),
  GetPage(
    name: Routes.attendance,
    page: () => const Attendance(),
  ),
];
