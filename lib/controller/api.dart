import 'dart:convert';

import 'package:get/get.dart';
import 'package:senthur_murugan/controller/apiservice.dart';
import 'package:senthur_murugan/controller/lazy.dart';
import 'package:senthur_murugan/controller/put.dart';

class Customer extends GetxController {
  final ApiService apiService = ApiService();
  List territorylist_ = [].obs;
  List customersearchlist_ = [].obs;
  List employeesearchlist_ = [].obs;
  List bitsizelist = [].obs;
  var employeelist = [].obs;
  var customerlist = [].obs;
  var expenselist = [].obs;
  var customerlistisLoading = true.obs;
  var employeelistisLoading = true.obs;
  var fliterlist = [].obs;
  var customerfliterlist = [].obs;
  var vechilelist = [].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    expensetype();
    vechilelist_();
    employeelist_();
  }

  Future territory(name) async {
    final response =
        await apiService.get("/api/method/frappe.desk.search.search_link", {
      "txt": name,
      "doctype": "Territory",
      "ignore_user_permissions": "1",
      "reference_doctype": "Customer",
      "filters": jsonEncode({"is_group": 0})
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

  Future customerName(name) async {
    print(name);
    print('ppppppppppppppppppppppppppppppp');
    final response =
        await apiService.get("/api/method/frappe.desk.search.search_link", {
      "txt": name,
      "doctype": "Customer",
      "ignore_user_permissions": "1",
      "reference_doctype": "Customer",
      // "filters": jsonEncode({"company": "Sri Senthur Murugan Bore Wells"})
    });
    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
      customersearchlist_.clear();
      List<String> valuesList = [];

      final jsonResponse = json.decode(response.body);
      for (var item in jsonResponse['results']) {
        print(item);

        if (item.containsKey('value')) {
          valuesList.add(item['value']);
        }
      }
      customersearchlist_ += (valuesList);
    }
  }

  Future bitSize(name) async {
    final response =
        await apiService.get("/api/method/frappe.desk.search.search_link", {
      "txt": name,
      "doctype": "Bit Size",
      "ignore_user_permissions": "1",
      "reference_doctype": "Customer",
    });
    if (response.statusCode == 200) {
      bitsizelist.clear();
      List<String> valuesList = [];

      final jsonResponse = json.decode(response.body);
      for (var item in jsonResponse['results']) {
        if (item.containsKey('value')) {
          valuesList.add(item['value']);
        }
      }
      bitsizelist += (valuesList);
    }
  }

  Future employee(name) async {
    final response =
        await apiService.get("/api/method/frappe.desk.search.search_link", {
      "txt": name,
      "doctype": "Employee",
      "ignore_user_permissions": "1",
      "reference_doctype": "Employee",
      "filters": jsonEncode({"department": "Driller"})
    });
    if (response.statusCode == 200) {
      employeesearchlist_.clear();
      List<String> valuesList = [];

      final jsonResponse = json.decode(response.body);
      for (var item in jsonResponse['results']) {
        if (item.containsKey('value')) {
          valuesList.add(item['value']);
        }
      }
      employeesearchlist_ += (valuesList);
    }
  }

  Future splash() async {
    final response =
        await apiService.get("/api/method/frappe.auth.get_logged_user", {});
    if (response.statusCode == 200) {
      // await Future.delayed(const Duration(seconds: 3));
      Get.offAllNamed("/Bottomnavigation");
    } else {
      // await Future.delayed(const Duration(seconds: 3));
      Get.offAllNamed("/loginpage");
    }
  }

  Future employeelist_() async {
    employeelistisLoading.value = true;
    final response = await apiService.get(
        "/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.employeelist", {});

    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      employeelist.value = jsonResponse["message"];
      await Future.delayed(const Duration(seconds: 1));
      employeelistisLoading.value = false;
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
        print(i["balance"]);
        print(i["balance"] != null);

        if (i["balance"] != null) {
          name['balance'] = i["balance"];
        }

        temp.add(name);
        fliterlist.value = temp;
      }
    }
  }

  Future customerlist_() async {
    customerlistisLoading.value = true;
    final response = await apiService.get(
        "/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.customerlist", {});
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      customerlist.value = jsonResponse["message"];
      await Future.delayed(const Duration(seconds: 1));
      customerlistisLoading.value = false;
    }
  }

  void customerfliter(change) {
    List<Map<String, dynamic>> temp = [];
    for (var i in customerlist) {
      if ((i["customer_name"]
              .toLowerCase()
              .contains(change.trim().toLowerCase())) ||
          (i["mobile_no"]
              .toLowerCase()
              .contains(change.trim().toLowerCase()))) {
        var name = <String, dynamic>{};
        name["customer_name"] = i["customer_name"];
        name["mobile_no"] = i["mobile_no"];
        temp.add(name);
        customerfliterlist.value = temp;
      }
    }
  }

  Future expensetype() async {
    expenselist.clear();
    final response = await apiService.get(
        "/api/method/ssm_bore_wells.ssm_bore_wells.utlis.api.expense_claim_type",
        {});
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      expenselist.value = jsonResponse["message"];
    }
  }

  Future vechilelist_() async {
    final response = await apiService.get("/api/resource/Vehicle", {
      "fields": jsonEncode(["name"]),
      "filters": jsonEncode({"company": "Sri Senthur Murugan Bore Wells"})
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      for (var temp in jsonResponse["data"]) {
        vechilelist.add(temp["name"]);
      }
      print("[[][][][][][][][][][]]");
      print(vechilelist);
    }
  }
}

// class Gobal {
//   static Future<void> inidt() async {
//     print("pppppppppppppppppppppppp");
//     Get.put(put());
//     Get.lazyPut(() => lazy());
//   }
// }
