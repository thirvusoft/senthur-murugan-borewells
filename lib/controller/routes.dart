import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:senthur_murugan/page/customer_list.dart';
import 'package:senthur_murugan/page/expanse_list.dart';
import 'package:senthur_murugan/widgets/bottom_navigation.dart';
import 'package:senthur_murugan/page/home_page.dart';
import 'package:senthur_murugan/page/login_page.dart';
import 'package:senthur_murugan/page/splash_page.dart';
import '../page/customer_creation.dart';

class Routes {
  static String customercreation = '/Customercreation';
  static String loginpage = '/loginpage';
  static String homepage = '/homepage';
  static String splashscreen = "/splashscreen";
  static String bottomnavigation = '/Bottomnavigation';
  static String customerlist = '/customerlist';
  static String expense = '/customerlist';
  static String dashboard = '/dashboard';
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
    name: Routes.splashscreen,
    page: () => const Splashscreen(),
  ),
  GetPage(
    name: Routes.bottomnavigation,
    page: () => const Bottomnavigation(),
  ),
  GetPage(
    name: Routes.customerlist,
    page: () => const Cusomerlist(),
  ),
  GetPage(
    name: Routes.dashboard,
    page: () => const Epensedashboard(),
  ),
];
