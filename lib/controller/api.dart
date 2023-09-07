import 'dart:convert';

import 'package:get/get.dart';
import 'package:senthur_murugan/controller/apiservice.dart';

class Customer extends GetxController {
  final ApiService apiService = ApiService();
  List territorylist_ = [].obs;
  List employeelist = [].obs;

  Future territory(name) async {
    print(name);
    final response = await apiService.get("frappe.desk.search.search_link", {
      "txt": name,
      "doctype": "Territory",
      "ignore_user_permissions": "1",
      "reference_doctype": "Customer"
    });
    print(response.body);
    if (response.statusCode == 200) {
      territorylist_.clear();
      List<String> valuesList = [];

      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      print(response.body);
      final jsonResponse = json.decode(response.body);
      for (var item in jsonResponse['results']) {
        if (item.containsKey('value')) {
          valuesList.add(item['value']);
        }
      }
      territorylist_ += (valuesList);
      print(territorylist_);
    }
  }

  Future splash() async {
    final response = await apiService.get("frappe.auth.get_logged_user", {});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Get.toNamed("/Bottomnavigation");
    } else {
      Get.toNamed("/loginpage");
    }
  }

  Future employeelist_() async {
    final response = await apiService
        .get("ssm_bore_wells.ssm_bore_wells.utlis.api.employeelist", {});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      employeelist = jsonResponse["message"];
    }
    print(employeelist);
  }
}
