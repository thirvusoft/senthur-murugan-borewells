import 'dart:convert';

import 'package:get/get.dart';
import 'package:senthur_murugan/controller/apiservice.dart';

class Customer extends GetxController {
  final ApiService apiService = ApiService();
  List territorylist_ = [].obs;
  var employeelist = [].obs;
  var fliterlist = [].obs;

  Future territory(name) async {
    final response = await apiService.get("frappe.desk.search.search_link", {
      "txt": name,
      "doctype": "Territory",
      "ignore_user_permissions": "1",
      "reference_doctype": "Customer"
    });
    if (response.statusCode == 200) {
      territorylist_.clear();
      List<String> valuesList = [];

      final jsonResponse = json.decode(response.body);
      for (var item in jsonResponse['results']) {
        if (item.containsKey('value')) {
          valuesList.add(item['value']);
        }
      }
      territorylist_ += (valuesList);
    }
  }

  Future splash() async {
    final response = await apiService.get("frappe.auth.get_logged_user", {});
    if (response.statusCode == 200) {
      // await Future.delayed(const Duration(seconds: 3));
      Get.offAllNamed("/Bottomnavigation");
    } else {
      // await Future.delayed(const Duration(seconds: 3));
      Get.offAllNamed("/loginpage");
    }
  }

  Future employeelist_() async {
    final response = await apiService
        .get("ssm_bore_wells.ssm_bore_wells.utlis.api.employeelist", {});
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      employeelist.value = jsonResponse["message"];
    }
  }

  void fliter(change) {
    // employeelist.clear();
    List<Map<String, dynamic>> temp = [];
    for (var i in employeelist) {
      if ((i["first_name"]
          .toLowerCase()
          .contains(change.trim().toLowerCase()))) {
        var name = <String, dynamic>{};
        name['first_name'] = i["first_name"];
        name['name'] = i["name"];
        temp.add(name);
        fliterlist.value = temp;
        print(employeelist);
      }
    }
  }
}
