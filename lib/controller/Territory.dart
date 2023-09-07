import 'dart:convert';

import 'package:get/get.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Customer extends GetxController {
  final ApiService apiService = ApiService();
  List territorylist_ = [].obs;

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
}
