import 'package:get/get_navigation/src/routes/get_route.dart';

import '../page/customer_creation.dart';
class Routes {
  static String customercreation = '/Customercreation';
  
}
final getPages=[  
   GetPage( 
    name: Routes.customercreation,
    page: () => const Customercreation(),
  ),
];